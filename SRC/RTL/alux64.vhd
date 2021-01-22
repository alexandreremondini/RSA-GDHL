library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

--mov ope_i = 0x0
--add ope_i = 0x1
--addc ope_i = 0x2
--sub ope_i = 0x3
--subc ope_i = 0x4
--shiftr ope_i = 0x5
--shiftrc ope_i = 0x6
--shiftl ope_i = 0x7
--shiftlc ope_i = 0x8
--mul ope_i = 0x9
--clean ope_i = 0xA

entity alux64 is

  port (
  a_i  :       in std_logic_vector(63 downto 0) := (others=>'0');
  b_i  :       in std_logic_vector(63 downto 0) := (others=>'0');
  high_mul_i :   in std_logic := '0';
  cadd_i :       in std_logic := '0';
  csub_i :       in std_logic := '0';
  shftr_i :     in std_logic := '0';
  shftl_i :     in std_logic := '0';
  ope_i :      in std_logic_vector(3 downto 0) := (others=>'0');
  s_o:         out std_logic_vector(63 downto 0) := (others=>'0');
  cadd_o :       out std_logic := '0';
  csub_o :       out std_logic := '0';
  shftr_o :     out std_logic := '0';
  shftl_o :     out std_logic := '0');

end entity alux64;


architecture alux64_arch of alux64 is

  component alux64_add
    port (
      a_i :      in std_logic_vector(63 downto 0);
      b_i :      in std_logic_vector(63 downto 0);
      co_o :     out std_logic;
      s_o:       out std_logic_vector(63 downto 0));
  end component alux64_add;

  component alux64_addc
    port (
    a_i :      in std_logic_vector(63 downto 0);
    b_i :      in std_logic_vector(63 downto 0);
    ci_i:      in std_logic;
    co_o :     out std_logic;
    s_o:       out std_logic_vector(63 downto 0));
  end component alux64_addc;

  component alux64_subc
    port (
    a_i :      in std_logic_vector(63 downto 0);
    b_i :      in std_logic_vector(63 downto 0);
    ci_i:      in std_logic;
    co_o :     out std_logic;
    s_o:       out std_logic_vector(63 downto 0));
  end component alux64_subc;

  component alux64_sub
    port (
    a_i :      in std_logic_vector(63 downto 0);
    b_i :      in std_logic_vector(63 downto 0);
    co_o :     out std_logic;
    s_o:       out std_logic_vector(63 downto 0));
  end component alux64_sub;

  component alux64_mul
    port (
    a_i:         in std_logic_vector(63 downto 0);
    b_i:         in std_logic_vector(63 downto 0);
    sel_high_i : in std_logic; -- if set to 1 return 64 MSB of the result, otherwise 64 LSB
    s_o:         out std_logic_vector(63 downto 0));
  end component alux64_mul;


  component alux64_shiftr
    port (
    a_i  :      in std_logic_vector(63 downto 0);
    s_o  :      out std_logic_vector(63 downto 0);
    shft_o :      out std_logic);
  end component alux64_shiftr;

  component alux64_shiftrc
    port (
    shft_i :    in std_logic;
    a_i  :      in std_logic_vector(63 downto 0);
    s_o  :      out std_logic_vector(63 downto 0);
    shft_o :      out std_logic);
  end component alux64_shiftrc;

  component alux64_shiftl
    port (
    a_i  :      in std_logic_vector(63 downto 0);
    s_o  :      out std_logic_vector(63 downto 0);
    shft_o :      out std_logic);
  end component alux64_shiftl;

  component alux64_shiftlc
    port (
    shft_i :    in std_logic;
    a_i  :      in std_logic_vector(63 downto 0);
    s_o  :      out std_logic_vector(63 downto 0);
    shft_o :      out std_logic);
  end component alux64_shiftlc;

  component generic_mux is
      generic (
          N: natural := 4; --2^N = number of entries
          W: natural := 64 --width of each entry
      );
      port (
          a_i : in std_logic_vector ((2**N)*W-1 downto 0);
          sel_i : in std_logic_vector(N-1 downto 0);
          s_o : out std_logic_vector (W-1 downto 0)
      );
  end component generic_mux;

  component mux21 is
      port (
          a_i : in std_logic;
          b_i : in std_logic;
          sel_i : in std_logic;
          s_o : out std_logic
      );
  end component mux21;

  constant N : integer := 4;
  signal ope_to_mux : std_logic_vector(2**N * 64 - 1 downto 0) := (others => '0');
  signal c_add_to_mux : std_logic_vector(1 downto 0) :=(others=>'0');
  signal c_sub_to_mux : std_logic_vector(1 downto 0) :=(others=>'0');
  signal c_shftr_to_mux : std_logic_vector(1 downto 0) :=(others=>'0');
  signal c_shftl_to_mux : std_logic_vector(1 downto 0) :=(others=>'0');
begin  -- adder_synch_arch

    --mov
    ope_to_mux(63 downto 0) <= a_i;

    alux64_add_1 : alux64_add
    port map (
    a_i => a_i,
    b_i => b_i,
    co_o => c_add_to_mux(1),
    s_o => ope_to_mux(64*2 - 1 downto 64));

    alux64_addc_1 : alux64_addc
    port map (
    a_i => a_i,
    b_i => b_i,
    ci_i => cadd_i,
    co_o => c_add_to_mux(0),
    s_o => ope_to_mux(64*3 - 1 downto 64*2));

    alux64_sub_1 : alux64_sub
    port map (
    a_i => a_i,
    b_i => b_i,
    co_o => c_sub_to_mux(1),
    s_o => ope_to_mux(64*4 - 1 downto 64*3));

    alux64_subc_1 : alux64_subc
    port map (
    a_i => a_i,
    b_i => b_i,
    ci_i => csub_i,
    co_o => c_sub_to_mux(0),
    s_o => ope_to_mux(64*5 - 1 downto 64*4));

    alux64_shiftr_1 : alux64_shiftr
    port map (
    a_i => a_i,
    s_o => ope_to_mux(64*6 - 1 downto 64*5),
    shft_o => c_shftr_to_mux(1));

    alux64_shiftrc_1 : alux64_shiftrc
    port map (
    shft_i => shftr_i,
    a_i => a_i,
    s_o => ope_to_mux(64*7 - 1 downto 64*6),
    shft_o => c_shftr_to_mux(0));

    alux64_shiftl_1 : alux64_shiftl
    port map (
    a_i => a_i,
    s_o => ope_to_mux(64*8 - 1 downto 64*7),
    shft_o => c_shftl_to_mux(1));

    alux64_shiftlc_1 : alux64_shiftlc
    port map (
    shft_i => shftl_i,
    a_i => a_i,
    s_o => ope_to_mux(64*9 - 1 downto 64*8),
    shft_o => c_shftl_to_mux(0));

    alux64_mul_1 : alux64_mul
      port map (
      a_i => a_i,
      b_i => b_i,
      sel_high_i => high_mul_i,
      s_o => ope_to_mux(64*10 - 1 downto 64*9));

    mux_ope : generic_mux
    generic map(
        N => N, --2^N = number of entries
        W => 64 --width of each entry
    )
    port map (
        a_i => ope_to_mux,
        sel_i => ope_i,
        s_o => s_o
    );

    mux21_add : mux21
    port map (
        a_i => c_add_to_mux(0),
        b_i => c_add_to_mux(1),
        sel_i => ope_i(0), --means LSB of add and addc for ope_i are different
        s_o => cadd_o
    );

    mux21_sub : mux21
    port map (
        a_i => c_sub_to_mux(0),
        b_i => c_sub_to_mux(1),
        sel_i => ope_i(0), --means LSB of sub (= 0) and subc (= 1) for ope_i are different
        s_o => csub_o
    );

    mux21_shftr : mux21
    port map (
        a_i => c_shftr_to_mux(0),
        b_i => c_shftr_to_mux(1),
        sel_i => ope_i(0),
        s_o => shftr_o
    );

    mux21_shftl : mux21
    port map (
        a_i => c_shftl_to_mux(0),
        b_i => c_shftl_to_mux(1),
        sel_i => ope_i(0),
        s_o => shftl_o
    );

end alux64_arch;

configuration alux64_conf of alux64 is

  for alux64_arch --architecture name

    for all : alux64_add --component name
      use entity lib_rtl.alux64_add(alux64_add_arch); --model choice
    end for;

    for all : alux64_addc --component name
      use entity lib_rtl.alux64_addc(alux64_addc_arch); --model choice
    end for;

    for all : alux64_subc --component name
      use entity lib_rtl.alux64_subc(alux64_subc_arch); --model choice
    end for;

    for all : alux64_sub --component name
      use entity lib_rtl.alux64_sub(alux64_sub_arch); --model choice
    end for;

    for all : alux64_shiftr --component name
      use entity lib_rtl.alux64_shiftr(alux64_shiftr_arch); --model choice
    end for;

    for all : alux64_shiftrc --component name
      use entity lib_rtl.alux64_shiftrc(alux64_shiftrc_arch); --model choice
    end for;

    for all : alux64_shiftl --component name
      use entity lib_rtl.alux64_shiftl(alux64_shiftl_arch); --model choice
    end for;

    for all : alux64_shiftlc --component name
      use entity lib_rtl.alux64_shiftlc(alux64_shiftlc_arch); --model choice
    end for;

    for all : alux64_mul --component name
      use entity lib_rtl.alux64_mul(alux64_mul_arch); --model choice
    end for;

    for all : generic_mux --component name
      use entity lib_rtl.generic_mux(generic_mux_arch); --model choice
    end for;

    for all : mux21 --component name
      use entity lib_rtl.mux21(mux21_arch); --model choice
    end for;

  end for;

end alux64_conf;
