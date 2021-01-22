library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_addc is

  port (
  a_i :      in std_logic_vector(63 downto 0);
  b_i :      in std_logic_vector(63 downto 0);
  ci_i:      in std_logic;
  co_o :     out std_logic;
  s_o:       out std_logic_vector(63 downto 0));

end entity alux64_addc;


architecture alux64_addc_arch of alux64_addc is

  component adder_gen
    generic (
  	N : natural := 64); -- N is the number of adder = the maximal number of bits of added numbers

    port (
    a_i:  in std_logic_vector(N-1 downto 0);
    b_i:  in std_logic_vector(N-1 downto 0);
    ci_i: in std_logic;
    s_o:  out std_logic_vector(N-1 downto 0);
    co_o: out std_logic);
  end component adder_gen;

begin  -- adder_synch_arch

    adder_gen_1 : adder_gen
    generic map (
    N => 64)

    port map (
    a_i => a_i,
    b_i => b_i,
    ci_i => ci_i,
    s_o => s_o,
    co_o => co_o);

end alux64_addc_arch;

configuration alux64_addc_conf of alux64_addc is

  for alux64_addc_arch --architecture name

    for all : adder_gen --component name
      use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
    end for;

  end for;

end alux64_addc_conf;
