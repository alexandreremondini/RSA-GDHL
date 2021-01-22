library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder is

  port (
    a_i, b_i : in std_logic;
    s_o, c_o : out std_logic);

end half_adder;

architecture half_adder_arch of half_adder is

--dataflow description

begin -- half_adder_arch

  s_o <= a_i xor b_i;
  c_o <= a_i and b_i;

end half_adder_arch;

