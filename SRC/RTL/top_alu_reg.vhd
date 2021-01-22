library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity top_alu_reg is
  generic (
    N_reg : natural); --2^N = number of registers x64

  port (
    clk_i         : in std_logic :='0';
    resetb_i      : in std_logic :='0';
    ext_i         : in std_logic :='0'; --if 1 write data_write_i otherwise write ALU data
    data_write_i  : in std_logic_vector(63 downto 0) := (others => '0');
    en_write_i    : in std_logic :='0';
    addr_read1_i  : in std_logic_vector(N_reg-1 downto 0) := (others => '0');
    addr_read2_i  : in std_logic_vector(N_reg-1 downto 0):= (others => '0');
    addr_write_i  : in std_logic_vector(N_reg-1 downto 0):= (others => '0');
    ope_i         : in std_logic_vector(3 downto 0):= (others => '0');
    high_mul_i    : in std_logic :='0';
    cadd_o        : out std_logic :='0';
    csub_o        : out std_logic :='0';
    shftl_o        : out std_logic :='0';
    shftr_o        : out std_logic :='0';
    data_read1_o  : out std_logic_vector(63 downto 0):= (others => '0');
    data_read2_o  : out std_logic_vector(63 downto 0):= (others => '0'));
end entity top_alu_reg;


architecture top_alu_reg_arch of top_alu_reg is

  component reg_file
    generic (
      N_reg : natural); --2^N = number of registers x64

    port (
      clk_i    : in std_logic;
      resetb_i : in std_logic;
      en_write_i   : in std_logic;
      addr_read1_i : in std_logic_vector(N_reg-1 downto 0);
      addr_read2_i : in std_logic_vector(N_reg-1 downto 0);
      addr_write_i : in std_logic_vector(N_reg-1 downto 0);
      data_write_i : in std_logic_vector(63 downto 0);
      data_read1_o : out std_logic_vector(63 downto 0);
      data_read2_o : out std_logic_vector(63 downto 0));

  end component reg_file;

  component alux64

    port (
    a_i  :       in std_logic_vector(63 downto 0);
    b_i  :       in std_logic_vector(63 downto 0);
    high_mul_i : in std_logic;
    cadd_i :       in std_logic;
    csub_i :       in std_logic;
    shftr_i :     in std_logic;
    shftl_i :     in std_logic;
    ope_i :      in std_logic_vector(3 downto 0);
    s_o:         out std_logic_vector(63 downto 0);
    cadd_o :       out std_logic;
    csub_o :       out std_logic;
    shftr_o :     out std_logic;
    shftl_o :     out std_logic);

  end component alux64;

  component dff

    port (
      clk_i    : in std_logic;
      d_i      : in std_logic;
      resetb_i : in std_logic;
      sel_i    : in std_logic;
      q_o      : out std_logic);

  end component dff;

  component generic_mux
  generic (
      N:    natural := 4; --2^N = number of entries
      W: natural := 64); --width of each entry
  port (
      a_i : in std_logic_vector ((2**N)*W-1 downto 0);
      sel_i : in std_logic_vector(N-1 downto 0);
      s_o : out std_logic_vector (W-1 downto 0));
  end component generic_mux;

  signal a_s : std_logic_vector(63 downto 0) :=(others=>'0');
  signal b_s : std_logic_vector(63 downto 0) :=(others=>'0');
  signal data_i_s : std_logic_vector(127 downto 0) :=(others=>'0'); --data in to write(127 downto 64) & ALU result (63 downto 0)
  signal data_w_s : std_logic_vector(63 downto 0) :=(others=>'0'); --data to be written in reg
  signal cadd_o_s : std_logic :='0';
  signal csub_o_s : std_logic :='0';
  signal cadd_i_s : std_logic :='0';
  signal csub_i_s : std_logic :='0';
  signal shftl_o_s : std_logic :='0';
  signal shftr_o_s : std_logic :='0';
  signal shftl_i_s : std_logic :='0';
  signal shftr_i_s : std_logic :='0';
begin  -- adder_synch_arch

    data_i_s(127 downto 64) <= data_write_i;
    cadd_o <= cadd_o_s;
    csub_o <= csub_o_s;
    shftr_o <= shftr_o_s;
    shftl_o <= shftl_o_s;
    data_read1_o <= a_s;
    data_read2_o <= b_s;

    reg_file_1 : reg_file
    generic map (
        N_reg => N_reg) --2^N = number of registers x64

      port map (
        clk_i => clk_i,
        resetb_i => resetb_i,
        en_write_i => en_write_i,
        addr_read1_i => addr_read1_i,
        addr_read2_i => addr_read2_i,
        addr_write_i => addr_write_i,
        data_write_i => data_w_s,
        data_read1_o => a_s,
        data_read2_o => b_s);

    generic_mux_write : generic_mux
    generic map(
        N => 1, --2^N = number of entries
        W => 64) --width of each entry
    port map(
        a_i => data_i_s,
        sel_i(0) => ext_i,
        s_o => data_w_s);

    alux64_1 : alux64

    port map(
    a_i => a_s,
    b_i => b_s,
    high_mul_i => high_mul_i,
    cadd_i => cadd_i_s,
    csub_i => csub_i_s,
    shftr_i => shftr_i_s,
    shftl_i => shftl_i_s,
    ope_i => ope_i,
    s_o => data_i_s(63 downto 0),
    cadd_o => cadd_o_s,
    csub_o => csub_o_s,
    shftr_o => shftr_o_s,
    shftl_o => shftl_o_s);

    dff_carry_add : dff
      port map (
        clk_i => clk_i,
        d_i => cadd_o_s,
        resetb_i => resetb_i,
        sel_i => '1',
        q_o => cadd_i_s);

    dff_carry_sub : dff
      port map (
        clk_i => clk_i,
        d_i => csub_o_s,
        resetb_i => resetb_i,
        sel_i => '1',
        q_o => csub_i_s);

    dff_shftl : dff
      port map (
        clk_i => clk_i,
        d_i => shftl_o_s,
        resetb_i => resetb_i,
        sel_i => '1',
        q_o => shftl_i_s);

    dff_shftr : dff
      port map (
        clk_i => clk_i,
        d_i => shftr_o_s,
        resetb_i => resetb_i,
        sel_i => '1',
        q_o => shftr_i_s);

end top_alu_reg_arch;

configuration top_alu_reg_conf of top_alu_reg is

  for top_alu_reg_arch --architecture name

    for all : reg_file --component name
      use entity lib_rtl.reg_file(reg_file_arch); --model choice
    end for;

    for all : alux64 --component name
      use entity lib_rtl.alux64(alux64_arch); --model choice
    end for;

    for all : generic_mux --component name
      use entity lib_rtl.generic_mux(generic_mux_arch); --model choice
    end for;

    for all : dff --component name
      use entity lib_rtl.dff(dff_arch); --model choice
    end for;

  end for;

end top_alu_reg_conf;
