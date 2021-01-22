library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity reg_file_tb is
end entity reg_file_tb;


architecture reg_file_tb_arch of reg_file_tb is

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

  constant N_reg : integer := 4;
  signal clk_s    : std_logic := '0';
  signal resetb_s : std_logic := '0';
  signal en_write_s   : std_logic := '0';
  signal addr_read1_s : std_logic_vector(N_reg-1 downto 0) := (others => '0');
  signal addr_read2_s : std_logic_vector(N_reg-1 downto 0) := (others => '0');
  signal addr_write_s : std_logic_vector(N_reg-1 downto 0) := (others => '0');
  signal data_write_s : std_logic_vector(63 downto 0) := (others => '0');
  signal data_read1_s : std_logic_vector(63 downto 0) := (others => '0');
  signal data_read2_s : std_logic_vector(63 downto 0) := (others => '0');

begin  -- adder_synch_arch

    reg_file_1 : reg_file
    generic map (
      N_reg => N_reg) --2^N = number of registers x64

    port map (
      clk_i    => clk_s,
      resetb_i => resetb_s,
      en_write_i   => en_write_s,
      addr_read1_i => addr_read1_s,
      addr_read2_i => addr_read2_s,
      addr_write_i => addr_write_s,
      data_write_i => data_write_s,
      data_read1_o => data_read1_s,
      data_read2_o => data_read2_s);

    clk_s    <= not clk_s after 2 ns;
    resetb_s <= '1','0' after 1 ns, '1' after 3 ns, '0'  after 41 ns, '1' after 43 ns;
    en_write_s <= '0', '1' after 5 ns, '0' after 9 ns, '1' after 15 ns, '0' after 19 ns;
    addr_read1_s <= x"0";
    addr_read2_s <= x"F";
    addr_write_s <= x"0", x"F" after 7 ns;
    data_write_s <= x"F0F0F0F0F0F0F0F0", x"C0C0C0C0C0C0C0C0" after 10 ns;


end reg_file_tb_arch;

configuration reg_file_tb_conf of reg_file_tb is

  for reg_file_tb_arch --architecture name
    for all : reg_file --component name
      use entity lib_rtl.reg_file(reg_file_arch); --model choice
    end for;
  end for;

end reg_file_tb_conf;
