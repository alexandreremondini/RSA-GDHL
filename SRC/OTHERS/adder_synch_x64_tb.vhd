library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity adder_synch_x64_tb is
end entity adder_synch_x64_tb;


architecture adder_synch_x64_tb_arch of adder_synch_x64_tb is

  component adder_synch_x64

    port (
      a_i:  in std_logic_vector(63 downto 0);
      b_i:  in std_logic_vector(63 downto 0);
      cin_i : in std_logic;
      clk_i : in std_logic;
      resetb_i : in std_logic;
      sel_i : in std_logic;
      cout_o : out std_logic;
      s_o:  out std_logic_vector(63 downto 0));
  end component adder_synch_x64;

  signal a_s : std_logic_vector(63 downto 0);
  signal b_s : std_logic_vector(63 downto 0);
  signal cin_s : std_logic;
  signal clk_s : std_logic :='0';
  signal resetb_s : std_logic;
  signal sel_s : std_logic;
  signal cout_s : std_logic;
  signal s_s : std_logic_vector(63 downto 0);

begin  -- adder_synch_arch

    adder_synch_x64_1 : adder_synch_x64

    port map (
      a_i => a_s,
      b_i => b_s,
      cin_i => cin_s,
      clk_i => clk_s,
      resetb_i => resetb_s,
      sel_i => sel_s,
      cout_o => cout_s,
      s_o => s_s);

    a_s <= x"FFFFFFFFFFFFFFFF", x"AAAAAAAAAAAAAAAA" after 9 ns;
    b_s <= x"FFFFFFFFFFFFFFFF", x"AAAAAAAAAAAAAAAA" after 9 ns;
    cin_s <= '0', '1' after 10 ns;
    clk_s    <= not clk_s after 2 ns;
    sel_s <= '0', '1' after 3 ns, '0' after 7 ns, '1' after 13 ns, '0' after 15 ns, '1' after 17 ns, '0' after 19 ns;
    resetb_s <= '0', '1' after 1 ns, '0'  after 25 ns, '1' after 26 ns;

end adder_synch_x64_tb_arch;

configuration adder_synch_x64_tb_conf of adder_synch_x64_tb is

  for adder_synch_x64_tb_arch --architecture name
    for all : adder_synch_x64 --component name
      use entity lib_rtl.adder_synch_x64(adder_synch_x64_arch); --model choice
    end for;
  end for;

end adder_synch_x64_tb_conf;
