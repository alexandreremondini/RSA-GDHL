library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity full_adder is

  port (
    a_i, b_i, cin_i : in std_logic;
    s_o, cout_o	    : out std_logic);

end full_adder;

architecture full_adder_arch of full_adder is
--component declarations
  component half_adder
  port (
    a_i, b_i : in std_logic;
    s_o, c_o : out std_logic);
end component;

component or_gate
  port (
    a_i, b_i : in std_logic;
    s_o	     : out std_logic);
end component;

--signal declarations
signal n1_s, n2_s, n3_s : std_logic :='0';

  begin --structural description

    half1 : half_adder port map (
      a_i => cin_i,
      b_i => a_i,
      s_o => n2_s,
      c_o => n1_s);

    half2 : half_adder port map (
      a_i => n2_s,
      b_i => b_i,
      s_o => s_o,
      c_o => n3_s);

    or1 : or_gate port map (
      a_i => n1_s,
      b_i => n3_s,
      s_o => cout_o);
  end full_adder_arch;


configuration full_adder_conf of full_adder is

  for full_adder_arch --architecture name
    for all : half_adder --component name
      use entity LIB_RTL.half_adder(half_adder_arch); --model choice
    end for;
    for OR1 : or_gate --component name
      use entity LIB_RTL.or_gate(or_gate_arch); --model choice
    end for;
  end for;

end full_adder_conf;
