library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_shiftrc is

  port (
  shft_i :    in std_logic;
  a_i  :      in std_logic_vector(63 downto 0);
  s_o  :      out std_logic_vector(63 downto 0);
  shft_o :      out std_logic);

end entity alux64_shiftrc;

architecture alux64_shiftrc_arch of alux64_shiftrc is

begin  -- adder_synch_arch

  s_o <= shft_i & a_i(63 downto 1);
  shft_o <= a_i(0);

end alux64_shiftrc_arch;
