library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_RTL;

entity top_calcul_tb is
end entity top_calcul_tb;

architecture top_calcul_tb_arch of top_calcul_tb is

  component top_calcul is
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
  end component top_calcul;

  constant N   : integer := 8;
  signal clk_s         :  std_logic :='0';
  signal resetb_s      :  std_logic :='0';
  signal addr_read1_s  :  std_logic_vector(N-1 downto 0) :=(others => '0');
  signal addr_read2_s  :  std_logic_vector(N-1 downto 0) :=(others => '0');
  signal addr_write_s  :  std_logic_vector(N-1 downto 0) :=(others => '0');
  signal addr_mod_s  :  std_logic_vector(N-1 downto 0) :=(others => '0');
  signal data_write_s  :  std_logic_vector(63 downto 0) := (others => '0');
  signal ope_s         :  std_logic_vector(3 downto 0) :=(others => '0');
  signal start_s       :  std_logic :='0';
  signal done_s       :  std_logic :='0';
  signal data_read1_s  :  std_logic_vector(63 downto 0) := (others => '0');
  signal data_read2_s  :  std_logic_vector(63 downto 0) := (others => '0');

  constant a:    std_logic_vector (63 downto 0) := X"0000000000000000";
  constant b:    std_logic_vector (63 downto 0) := X"0000000000000001";
  constant c:    std_logic_vector (63 downto 0) := X"2222222222222222";
  constant d:    std_logic_vector (63 downto 0) := X"3333333333333333";
  constant e:    std_logic_vector (63 downto 0) := X"4444444444444444";
  constant f:    std_logic_vector (63 downto 0) := X"5555555555555555";
  constant g:    std_logic_vector (63 downto 0) := X"FFFFFFFFFFFFFFFF";
  constant h:    std_logic_vector (63 downto 0) := X"8888888888888888";

begin  -- architecture multiplier_synch_64_tb_arch

  dut : top_calcul
  generic map (
    N_reg => N)--2^N = number of registers x64

    port map (
      clk_i => clk_s,
      resetb_i => resetb_s,
      addr_read1_i => addr_read1_s,
      addr_read2_i => addr_read2_s,
      addr_mod_i => addr_mod_s,
      addr_write_i => addr_write_s,
      data_write_i => data_write_s,
      ope_i => ope_s,
      start_i => start_s,
      done_o => done_s,
      data_read1_o => data_read1_s,
      data_read2_o => data_read2_s);


  --load_reg : process
  --begin
  --  if done_s = '1' then
  --    addr_write_s <= d;
  --  else
  --    adc_busy_s <= '0';
  --    wait for 40 ns;
  --  end if;
  --end process;
  clk_s    <= not clk_s after 10 ns;
  resetb_s <= '1','0' after 1 ns, '1' after 3 ns;

  addr_write_s <= x"10",
                  x"11" after 40 ns,
                  x"12" after 80 ns,
                  x"13" after 120 ns,
                  x"14" after 160 ns,
                  x"15" after 200 ns,
                  x"16" after 240 ns,
                  x"17" after 280 ns,
                  x"18" after 320 ns,     --Fill for read 1
                  x"19" after 360 ns,
                  x"1A" after 400 ns,
                  x"1B" after 440 ns,
                  x"1C" after 480 ns,
                  x"1D" after 520 ns,
                  x"1E" after 560 ns,
                  x"1F" after 600 ns,

                  x"20" after 680 ns,
                  x"21" after 720 ns,
                  x"22" after 760 ns,
                  x"23" after 800 ns,
                  x"24" after 840 ns,
                  x"25" after 880 ns,
                  x"26" after 920 ns,
                  x"27" after 960 ns,   --Fill for read 2
                  x"28" after 1000 ns,
                  x"29" after 1040 ns,
                  x"2A" after 1080 ns,
                  x"2B" after 1120 ns,
                  x"2C" after 1160 ns,
                  x"2D" after 1200 ns,
                  x"2E" after 1240 ns,
                  x"2F" after 1280 ns,

                  x"50" after 1360 ns,
                  x"51" after 1400 ns,
                  x"52" after 1440 ns,
                  x"53" after 1480 ns,
                  x"54" after 1520 ns,
                  x"55" after 1560 ns,
                  x"56" after 1600 ns,
                  x"57" after 1640 ns,  --Fill for modulo
                  x"58" after 1680 ns,
                  x"59" after 1720 ns,
                  x"5A" after 1760 ns,
                  x"5B" after 1800 ns,
                  x"5C" after 1840 ns,
                  x"5D" after 1880 ns,
                  x"5E" after 1920 ns,
                  x"5F" after 1960 ns,

                  X"30" after 2000 ns;

  addr_read1_s <= x"10";
  addr_read2_s <= x"20";
  addr_mod_s <= x"50";
  ope_s <= x"3", x"4" after 2000 ns;
  data_write_s <= c, f after 680 ns, d after 1360 ns;
  start_s <= '1', '0' after 2100 ns;

end architecture top_calcul_tb_arch;

configuration top_calcul_tb_conf of top_calcul_tb is
	for top_calcul_tb_arch
		for dut : top_calcul
			use entity LIB_RTL.top_calcul(top_calcul_arch);
		end for;
	end for;
end configuration top_calcul_tb_conf;
