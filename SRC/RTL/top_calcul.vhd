library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity top_calcul is
  generic (
    N_reg : natural); --2^N = number of registers x64

  port (
    clk_i        : in std_logic;
    resetb_i     : in std_logic;
    addr_read1_i : in std_logic_vector(N_reg-1 downto 0);
    addr_read2_i : in std_logic_vector(N_reg-1 downto 0);
    addr_write_i : in std_logic_vector(N_reg-1 downto 0);
    addr_mod_i   : in std_logic_vector(N_reg-1 downto 0); --LSB register for modulo
    data_write_i : in std_logic_vector(63 downto 0);
    ope_i        : in std_logic_vector(3 downto 0);
    start_i      : in std_logic;
    done_o       : out std_logic;
    data_read1_o : out std_logic_vector(63 downto 0);
    data_read2_o : out std_logic_vector(63 downto 0));

end entity top_calcul;


architecture top_calcul_arch of top_calcul is

  component top_alu_reg
    generic (
      N_reg : natural); --2^N = number of registers x64

    port (
      clk_i         : in std_logic;
      resetb_i      : in std_logic;
      ext_i         : in std_logic; --if 1 write data_write_i otherwise write ALU data
      data_write_i  : in std_logic_vector(63 downto 0);
      en_write_i    : in std_logic;
      addr_read1_i  : in std_logic_vector(N_reg-1 downto 0);
      addr_read2_i  : in std_logic_vector(N_reg-1 downto 0);
      addr_write_i  : in std_logic_vector(N_reg-1 downto 0);
      ope_i         : in std_logic_vector(3 downto 0);
      high_mul_i    : in std_logic;
      cadd_o        : out std_logic;
      csub_o        : out std_logic;
      shftl_o        : out std_logic;
      shftr_o        : out std_logic;
      data_read1_o  : out std_logic_vector(63 downto 0);
      data_read2_o  : out std_logic_vector(63 downto 0));
  end component top_alu_reg;


  component fsm_1024_counters

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
      addr_mod_i                : in std_logic_vector(N-1 downto 0); --LSB register for modulo
      addr_write_i              : in std_logic_vector(N-1 downto 0); --LSB register for result storage
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

  end component fsm_1024_counters;

  signal cadd_s : std_logic := '0';
  signal csub_s : std_logic := '0';
  signal shftl_s : std_logic := '0';
  signal shftr_s : std_logic := '0';

  signal ope_s : std_logic_vector(3 downto 0) := (others => '0');
  signal high_mul_s : std_logic :='0';

  signal external_write_s : std_logic := '0';

  signal addr_read1_s : std_logic_vector(N_reg-1 downto 0) := (others => '0');
  signal addr_read2_s : std_logic_vector(N_reg-1 downto 0) := (others => '0');
  signal addr_write_s : std_logic_vector(N_reg-1 downto 0) := (others => '0');
  signal en_write_s : std_logic :='0';

begin  -- adder_synch_arch

    top_alu_reg1 : top_alu_reg
      generic map (
        N_reg => N_reg) --2^N = number of registers x64

      port map (
        clk_i => clk_i,
        resetb_i => resetb_i,
        ext_i => external_write_s,
        data_write_i  => data_write_i,
        en_write_i => en_write_s,
        addr_read1_i => addr_read1_s,
        addr_read2_i => addr_read2_s,
        addr_write_i => addr_write_s,
        ope_i => ope_s,
        high_mul_i => high_mul_s,
        cadd_o => cadd_s,
        csub_o => csub_s,
        shftl_o => shftl_s,
        shftr_o => shftr_s,
        data_read1_o => data_read1_o,
        data_read2_o  => data_read2_o);

    fsm_1024_counters_1 : fsm_1024_counters

      generic map(
        N  => N_reg) --number of registers in the reg file
      port map(
        clk_i => clk_i,
        resetb_i => resetb_i,
        start_i => start_i,
        ope_i => ope_i,
        --cpt_i
        addr_read1_i => addr_read1_i,
        addr_read2_i => addr_read2_i,
        addr_mod_i => addr_mod_i,
        addr_write_i => addr_write_i,
        cadd_i => cadd_s,
        csub_i => csub_s,
        shftl_i => shftl_s,
        shftr_i => shftr_s,
        done_o => done_o,
        ope_o => ope_s,
        high_mul_o => high_mul_s,
        --init_cpt_o
        --en_cpt_o
        en_write_o => en_write_s,
        addr_read1_o => addr_read1_s,
        addr_read2_o => addr_read2_s,
        addr_write_o => addr_write_s,
        external_write_o => external_write_s
        );

end top_calcul_arch;

configuration top_calcul_conf of top_calcul is

  for top_calcul_arch --architecture name

    for all : top_alu_reg --component name
      use entity lib_rtl.top_alu_reg(top_alu_reg_arch); --model choice
    end for;

    for all : fsm_1024_counters --component name
      use entity lib_rtl.fsm_1024_counters(fsm_1024_counters_arch); --model choice
    end for;

  end for;

end top_calcul_conf;
