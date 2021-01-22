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

entity fsm_1024_counters_tb is
end entity fsm_1024_counters_tb;


architecture fsm_1024_counters_tb_arch of fsm_1024_counters_tb is

  component fsm_1024_counters

    generic(
    N : natural := 8); --2^N = number of registers in the reg file
    port(
      clk_i                     : in  std_logic;
      resetb_i                  : in  std_logic;
      start_i                   : in  std_logic; --launch fsm
      ope_i                     : in std_logic_vector(3 downto 0);
      --cpt_i                     : in  std_logic_vector(3*N-1 downto 0); -- 3 counter output of N bits each
      addr_read1_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 1
      addr_read2_i              : in std_logic_vector(N-1 downto 0); --LSB register for operand 2
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

  constant N : integer := 8;
  signal clk_s                     :  std_logic :='0';
  signal resetb_s                  :  std_logic :='0';
  signal start_s                   :  std_logic :='0'; --launch fsm
  signal ope_i_s                     : std_logic_vector(3 downto 0);
  signal addr_read1_i_s              : std_logic_vector(N-1 downto 0) :=(others => '0'); --LSB register for operand 1
  signal addr_read2_i_s              : std_logic_vector(N-1 downto 0) :=(others => '0'); --LSB register for operand 2
  signal addr_write_i_s              : std_logic_vector(N-1 downto 0) :=(others => '0'); --LSB register for result storage
  signal cadd_s                    : std_logic :='0'; --ALU's current add carry
  signal csub_s                    : std_logic :='0'; --ALU's current sub carry
  signal shftl_s                   : std_logic :='0'; --ALU's current shift left carry
  signal shftr_s                   : std_logic :='0'; --ALU's current shift right carry

  signal done_s                    :  std_logic :='0'; --when output reg_file is full
  signal ope_o_s                     : std_logic_vector(3 downto 0) :=(others => '0');
  signal high_mul_s                : std_logic :='0';
  signal en_write_s                : std_logic :='0'; --enable write in reg_file
  signal addr_read1_o_s              : std_logic_vector(N-1 downto 0) :=(others => '0');
  signal addr_read2_o_s              : std_logic_vector(N-1 downto 0) :=(others => '0');
  signal addr_write_o_s              : std_logic_vector(N-1 downto 0) :=(others => '0');
  signal external_write_o_s          : std_logic; --write external data instead of ALU's data

begin  -- adder_synch_arch


    dut : fsm_1024_counters
    generic map(
    N => N) --2^N = number of registers in the reg file

    port map (
    clk_i => clk_s,
    resetb_i => resetb_s,
    start_i => start_s,
    ope_i => ope_i_s,
    addr_read1_i => addr_read1_i_s,
    addr_read2_i => addr_read2_i_s,
    addr_write_i => addr_write_i_s,
    cadd_i => cadd_s,
    csub_i => csub_s,
    shftl_i => shftl_s,
    shftr_i => shftr_s,

    done_o => done_s,
    ope_o => ope_o_s,
    high_mul_o => high_mul_s,
    en_write_o => en_write_s,
    addr_read1_o => addr_read1_o_s,
    addr_read2_o => addr_read2_o_s,
    addr_write_o => addr_write_o_s,
    external_write_o => external_write_o_s);


    clk_s <= not clk_s after 10 ns;
    resetb_s <= '1', '0' after 2 ns, '1' after 4 ns;
    start_s <= '0', '1' after 5 ns, '0' after 15 ns;
    ope_i_s <= x"2";
    addr_read1_i_s <= x"10";
    addr_read2_i_s <= x"20";
    addr_write_i_s <= x"30";
    cadd_s <= '1', '0' after 60 ns, '1' after 80 ns, '0' after 140 ns;
    csub_s <= '1';
    shftl_s <= '1';
    shftr_s <= '1';

end fsm_1024_counters_tb_arch;

configuration fsm_1024_counters_tb_conf of fsm_1024_counters_tb is

  for fsm_1024_counters_tb_arch --architecture name

    for all : fsm_1024_counters --component name
      use entity lib_rtl.fsm_1024_counters(fsm_1024_counters_arch); --model choice
    end for;

  end for;

end fsm_1024_counters_tb_conf;
