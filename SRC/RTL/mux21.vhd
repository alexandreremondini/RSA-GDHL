library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux21 is
    port (
        a_i : in std_logic;
        b_i : in std_logic;
        sel_i : in std_logic;
        s_o : out std_logic
    );
end entity;

architecture mux21_arch of mux21 is
begin
  s_o <= a_i when (sel_i='0') else b_i;
end architecture;
