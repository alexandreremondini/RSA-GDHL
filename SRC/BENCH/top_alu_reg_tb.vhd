library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_RTL;

entity top_alu_reg_tb is
end entity top_alu_reg_tb;

architecture top_alu_reg_tb_arch of top_alu_reg_tb is

  component top_alu_reg is
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

  constant N   : integer := 8;
  signal clk_s         :  std_logic :='0';
  signal resetb_s      :  std_logic :='0';
  signal ext_s         :  std_logic :='0'; --if 1 write data_write_i otherwise write ALU data
  signal data_write_s  :  std_logic_vector(63 downto 0) := (others => '0');
  signal en_write_s    :  std_logic :='0';
  signal addr_read1_s  :  std_logic_vector(N-1 downto 0) :=(others => '0');
  signal addr_read2_s  :  std_logic_vector(N-1 downto 0) :=(others => '0');
  signal addr_write_s  :  std_logic_vector(N-1 downto 0) :=(others => '0');
  signal ope_s         :  std_logic_vector(3 downto 0) :=(others => '0');
  signal high_mul_s    :  std_logic :='0';
  signal cadd_s        :  std_logic :='0';
  signal csub_s        :  std_logic :='0';
  signal shftr_o_s     :  std_logic :='0';
  signal shftl_o_s     :  std_logic :='0';
  signal data_read1_s  :  std_logic_vector(63 downto 0) := (others => '0');
  signal data_read2_s  :  std_logic_vector(63 downto 0) := (others => '0');

  constant a:    std_logic_vector (63 downto 0) := X"0000000000000000";
  constant b:    std_logic_vector (63 downto 0) := X"1111111111111111";
  constant c:    std_logic_vector (63 downto 0) := X"2222222222222222";
  constant d:    std_logic_vector (63 downto 0) := X"3333333333333333";
  constant e:    std_logic_vector (63 downto 0) := X"4444444444444444";
  constant f:    std_logic_vector (63 downto 0) := X"5555555555555555";
  constant g:    std_logic_vector (63 downto 0) := X"6666666666666666";
  constant h:    std_logic_vector (63 downto 0) := X"8888888888888889";

begin  -- architecture multiplier_synch_64_tb_arch

  dut : top_alu_reg
  generic map (
    N_reg => N)--2^N = number of registers x64

  port map (
    clk_i => clk_s,
    resetb_i => resetb_s,
    ext_i => ext_s, --if 1 write data_write_i otherwise write ALU data
    data_write_i => data_write_s,
    en_write_i => en_write_s,
    addr_read1_i => addr_read1_s,
    addr_read2_i  => addr_read2_s,
    addr_write_i  => addr_write_s,
    ope_i  => ope_s,
    high_mul_i => high_mul_s,
    cadd_o => cadd_s,
    csub_o => csub_s,
    shftl_o => shftl_o_s,
    shftr_o => shftr_o_s,
    data_read1_o => data_read1_s,
    data_read2_o => data_read2_s);

  clk_s    <= not clk_s after 10 ns;
  resetb_s <= '1','0' after 1 ns, '1' after 3 ns, '0'  after 90 ns, '1' after 95 ns;
  ext_s <= '1', '0' after 35 ns;
  data_write_s <= h;
  en_write_s <= '1', '0' after 65 ns;
  addr_read1_s <= x"00";
  addr_read2_s <= x"01";
  addr_write_s <= x"00", x"01" after 25 ns,  x"00" after 45 ns;
  ope_s <= x"2";

end architecture top_alu_reg_tb_arch;

configuration top_alu_reg_tb_conf of top_alu_reg_tb is
	for top_alu_reg_tb_arch
		for dut : top_alu_reg
			use entity LIB_RTL.top_alu_reg(top_alu_reg_arch);
		end for;
	end for;
end configuration top_alu_reg_tb_conf;
