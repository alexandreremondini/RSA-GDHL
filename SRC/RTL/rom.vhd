-- rom.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is

  port(

    add_i  : in  std_logic_vector(1 downto 0) :=(others=>'0');
    data_o : out std_logic_vector(7 downto 0) := :=(others='0')
    );

end rom;


architecture rom_arch of rom is

  type table_rom_t is array(0 to 3) of std_logic_vector(7 downto 0);

  constant table_rom_c : table_rom_t :=  (x"FF", x"55", x"11", x"AA");

begin
  data_o <= table_rom_c(to_integer(unsigned(add_i)));

end rom_arch;
