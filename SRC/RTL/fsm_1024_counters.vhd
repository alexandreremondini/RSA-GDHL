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

entity fsm_1024_counters is

  generic(
  N : natural); --number of registers in the reg file
  port(
    clk_i                     : in  std_logic;
    resetb_i                  : in  std_logic;
    start_i                   : in  std_logic; --launch fsm
    ope_i                     : in std_logic_vector(3 downto 0);
    --cpt_i                     : in  std_logic_vector(3*N-1 downto 0); -- 3 counter output of N bits each
    addr_read1_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 1
    addr_read2_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 2
    addr_write_i              : in std_logic_vector(N-1 downto 0); --LSB register for result storage
    addr_mod_i                : in std_logic_vector(N-1 downto 0); --LSB register for modulo
    cadd_i                    : in std_logic; --ALU's current add carry
    csub_i                    : in std_logic; --ALU's current sub carry
    shftl_i                   : in std_logic; --ALU's current shift left carry
    shftr_i                   : in std_logic; --ALU's current shift right carry

    done_o                    : out std_logic; --when output reg_file is full
    ope_o                     : out std_logic_vector(3 downto 0);
    high_mul_o                : out std_logic;
    --init_cpt_o                : out std_logic_vector(2 downto 0); --init counter to 0
    --en_cpt_o                  : out std_logic_vector(2 downto 0); --enable counter
    en_write_o                : out std_logic; --enable write in reg_file
    addr_read1_o              : out std_logic_vector(N-1 downto 0);
    addr_read2_o              : out std_logic_vector(N-1 downto 0);
    addr_write_o              : out std_logic_vector(N-1 downto 0);
    external_write_o          : out std_logic --write external data instead of ALU's data
    );

end entity fsm_1024_counters;


architecture fsm_1024_counters_arch of fsm_1024_counters is

  component fsm_1024

    generic(
    N : natural); -- 2^N = number of registers in the reg file
    port(
      clk_i                     : in  std_logic;
      resetb_i                  : in  std_logic;
      start_i                   : in  std_logic; --launch fsm
      ope_i                     : in std_logic_vector(3 downto 0);
      cpt_i                     : in  std_logic_vector(3*N-1 downto 0); -- 3 counter output of N bits each
      addr_read1_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 1
      addr_read2_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 2
      addr_write_i              : in std_logic_vector(N-1 downto 0); --LSB register for result storage
      addr_mod_i                : in std_logic_vector(N-1 downto 0); --LSB register for modulo
      cadd_i                    : in std_logic; --ALU's current add carry
      csub_i                    : in std_logic; --ALU's current sub carry
      shftl_i                   : in std_logic; --ALU's current shift left carry
      shftr_i                   : in std_logic; --ALU's current shift right carry

      done_o                    : out std_logic; --when output reg_file is full
      ope_o                     : out std_logic_vector(3 downto 0);
      high_mul_o                : out std_logic;
      init_cpt_o                : out std_logic_vector(2 downto 0); --init counter to 0
      en_cpt_o                  : out std_logic_vector(2 downto 0); --enable counter
      en_write_o                : out std_logic; --enable write in reg_file
      addr_read1_o              : out std_logic_vector(N-1 downto 0);
      addr_read2_o              : out std_logic_vector(N-1 downto 0);
      addr_write_o              : out std_logic_vector(N-1 downto 0);
      external_write_o          : out std_logic
      );

  end component fsm_1024;

  component counter
    generic(
      N : natural);
    port(
      resetb_i : in std_logic;
    	enable_i : in std_logic;
      init_i : in std_logic;
    	clk_i : in std_logic;
    	count_o : out std_logic_vector(N-1 downto 0));
  end component counter;

  signal enable_cpt_s : std_logic_vector(2 downto 0) :=(others=>'0');
  signal init_cpt_s : std_logic_vector(2 downto 0) :=(others=>'0');
  signal cpt_s : std_logic_vector(3*N-1 downto 0) :=(others=>'0');

begin  -- adder_synch_arch


    fsm_1024_1 : fsm_1024
    generic map(
    N => N
    )
    port map (
    clk_i => clk_i,
    resetb_i => resetb_i,
    start_i => start_i,
    ope_i => ope_i,
    cpt_i => cpt_s,
    addr_read1_i => addr_read1_i,
    addr_read2_i => addr_read2_i,
    addr_write_i => addr_write_i,
    addr_mod_i => addr_mod_i,
    cadd_i => cadd_i,
    csub_i => csub_i,
    shftl_i => shftl_i,
    shftr_i => shftr_i,

    done_o => done_o,
    ope_o => ope_o,
    high_mul_o => high_mul_o,
    init_cpt_o => init_cpt_s,
    en_cpt_o => enable_cpt_s,
    en_write_o => en_write_o,
    addr_read1_o => addr_read1_o,
    addr_read2_o => addr_read2_o,
    addr_write_o => addr_write_o,
    external_write_o => external_write_o);

    counter_gen : for i in 0 to 2 generate
      OP1 : counter
      generic map(
      N => N
      )
      port map (
      resetb_i => resetb_i,
    	enable_i => enable_cpt_s(i),
      init_i => init_cpt_s(i),
    	clk_i => clk_i,
    	count_o => cpt_s((i+1)*N-1 downto i*N));
    end generate counter_gen;

end fsm_1024_counters_arch;

configuration fsm_1024_counters_conf of fsm_1024_counters is

  for fsm_1024_counters_arch --architecture name

    for all : fsm_1024 --component name
      use entity lib_rtl.fsm_1024(fsm_1024_arch); --model choice
    end for;

    for counter_gen
      for OP1 : counter
        use entity lib_rtl.counter(counter_arch);
      end for;
    end for;

  end for;

end fsm_1024_counters_conf;
