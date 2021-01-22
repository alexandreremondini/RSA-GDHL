library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_shiftl is

  port (
  a_i  :      in std_logic_vector(63 downto 0);
  s_o  :      out std_logic_vector(63 downto 0);
  shft_o :      out std_logic);

end entity alux64_shiftl;

architecture alux64_shiftl_arch of alux64_shiftl is

begin  -- adder_synch_arch

  s_o <= a_i(62 downto 0) & '0';
  shft_o <= a_i(63);

end alux64_shiftl_arch;
