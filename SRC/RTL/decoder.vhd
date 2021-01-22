library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--asynchronous
entity decoder is
  generic (
    N : natural); --number of input bits
  port (
    a_i     : in std_logic_vector(N-1 downto 0) :=(others=>'0');
    s_o     : out std_logic_vector(2**N-1 downto 0) :=(others=>'0'));

end entity decoder;

architecture decoder_arch of decoder is

signal s_s : std_logic_vector(2**N-1 downto 0) :=(others=>'0');

begin
  decod : process (a_i)
  begin
      s_s <= (others => '0');
      s_s(to_integer(unsigned(a_i))) <= '1';
  end process;
  s_o <= s_s;
end decoder_arch;
