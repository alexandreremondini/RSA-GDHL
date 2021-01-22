library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity adder_gen_tb is
end entity adder_gen_tb;


architecture adder_gen_tb_arch of adder_gen_tb is

  component adder_gen
    generic (
      N : natural := 4);             -- number of full_adder

    port (
      a_i:  in std_logic_vector(N-1 downto 0);
      b_i:  in std_logic_vector(N-1 downto 0);
      ci_i: in std_logic;
      s_o:  out std_logic_vector(N-1 downto 0);
      co_o: out std_logic);
  end component adder_gen;

  constant W : integer := 4;
  signal a_s : std_logic_vector(W-1 downto 0);
  signal b_s : std_logic_vector(W-1 downto 0);
  signal ci_s : std_logic;
  signal s_s : std_logic_vector(W-1 downto 0);
  signal co_s : std_logic;

begin  -- adder_synch_arch

    adder_gen_1 : adder_gen
    generic map (
      N => W)             -- number of full_adder
    port map (
      a_i => a_s,
      b_i => b_s,
      ci_i => ci_s,
      s_o => s_s,
      co_o => co_s);

    a_s <= (others => '1'), "1010" after 5 ns;
    b_s <= (others => '1'), "0010" after 5 ns;
    ci_s    <= '0', '1' after 10 ns, '0' after 20 ns;

end adder_gen_tb_arch;

configuration adder_gen_tb_conf of adder_gen_tb is

  for adder_gen_tb_arch --architecture name
    for all : adder_gen --component name
      use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
    end for;
  end for;

end adder_gen_tb_conf;
