library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity adder_1024_tb is
end entity adder_1024_tb;


architecture adder_1024_tb_arch of adder_1024_tb is

  component adder_1024

    port (
    a_i:  in std_logic_vector(1023 downto 0);
    b_i:  in std_logic_vector(1023 downto 0);
    clk_i : in std_logic;
    resetb_i : in std_logic;
    sel_i : in std_logic;
    s_o:  out std_logic_vector(1023 downto 0));

  end component adder_1024;

  constant sig128 : std_logic_vector(127 downto 0) := x"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
  signal a_s : std_logic_vector(1023 downto 0);
  signal b_s : std_logic_vector(1023 downto 0);
  signal clk_s : std_logic :='0';
  signal resetb_s : std_logic;
  signal sel_s : std_logic;
  signal s_s : std_logic_vector(1023 downto 0);

begin  -- adder_synch_arch

    DUT : adder_1024
    port map (
      a_i => a_s,
      b_i => b_s,
      clk_i => clk_s,
      resetb_i => resetb_s,
      sel_i => sel_s,
      s_o => s_s);

    a_s <= (others=>'1'), sig128 & sig128 & sig128 & sig128 & sig128 & sig128 & sig128 & sig128 after 9 ns;
    b_s <= (others=>'1'), sig128 & sig128 & sig128 & sig128 & sig128 & sig128 & sig128 & sig128 after 9 ns;
    clk_s    <= not clk_s after 2 ns;
    sel_s <= '0', '1' after 1 ns, '0' after 5 ns, '1' after 9 ns, '0' after 15 ns;
    resetb_s <= '0', '1'  after 1 ns, '0' after 19 ns, '1' after 21 ns;

end adder_1024_tb_arch;

configuration adder_1024_tb_conf of adder_1024_tb is

  for adder_1024_tb_arch --architecture name
    for all : adder_1024 --component name
      use entity lib_rtl.adder_1024(adder_1024_arch); --model choice
    end for;
  end for;

end adder_1024_tb_conf;
