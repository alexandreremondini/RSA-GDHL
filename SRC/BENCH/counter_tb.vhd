library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity counter_tb is
end entity counter_tb;


architecture counter_tb_arch of counter_tb is

  component counter
    generic(
      N : natural);
    port(
      resetb_i : in std_logic;
      enable_i : in std_logic;
      clk_i : in std_logic;
      count_o : out std_logic_vector(N-1 downto 0));
  end component counter;

  constant N : integer := 8;
  signal resetb_s : std_logic;
  signal enable_s : std_logic;
  signal clk_s : std_logic :='0';
  signal count_s : std_logic_vector(N-1 downto 0);

begin  -- adder_synch_arch

    counter_1 : counter
    generic map(
      N => N)
    port map (
    resetb_i => resetb_s,
    enable_i => enable_s,
    clk_i => clk_s,
    count_o => count_s);

    enable_s <= '0', '1' after 10 ns;
    clk_s    <= not clk_s after 2 ns;
    resetb_s <= '0', '1' after 1 ns, '0'  after 25 ns, '1' after 26 ns;

end counter_tb_arch;

configuration counter_tb_conf of counter_tb is

  for counter_tb_arch --architecture name
    for all : counter --component name
      use entity lib_rtl.counter(counter_arch); --model choice
    end for;
  end for;

end counter_tb_conf;
