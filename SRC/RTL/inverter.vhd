library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity inverter is

  port (
  e_i :      in std_logic;
  s_o :      out std_logic);

end entity inverter;


architecture inverter_arch of inverter is

begin  -- adder_synch_arch
  s_o <= not e_i;

end inverter_arch;
