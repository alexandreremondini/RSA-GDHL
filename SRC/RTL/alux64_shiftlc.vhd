library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_shiftlc is

  port (
  shft_i :    in std_logic;
  a_i  :      in std_logic_vector(63 downto 0);
  s_o  :      out std_logic_vector(63 downto 0);
  shft_o :      out std_logic);

end entity alux64_shiftlc;

architecture alux64_shiftlc_arch of alux64_shiftlc is

begin  -- adder_synch_arch

  s_o <= a_i(62 downto 0) & shft_i;
  shft_o <= a_i(63);

end alux64_shiftlc_arch;
