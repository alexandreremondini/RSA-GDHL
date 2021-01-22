library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_RTL;

entity decoder_tb is

end entity decoder_tb;

architecture decoder_tb_arch of decoder_tb is

  component decoder is
    generic (
      N : natural); --number of input bits
    port (
      a_i     : in std_logic_vector(N-1 downto 0);
      s_o     : out std_logic_vector(2**N-1 downto 0));
  end component decoder;

  constant N   : integer :=4;
  signal a_s   : std_logic_vector(N-1 downto 0);
  signal s_s   : std_logic_vector(2**N-1 downto 0);

begin  -- architecture multiplier_synch_64_tb_arch

  dut : decoder
    generic map(
    N => N)
    port map(
    a_i => a_s,
    s_o => s_s);

  a_s <= x"1", x"2" after 2 ns, x"3" after 3 ns, x"4" after 4 ns,  x"5" after 5 ns , x"6" after 6 ns, x"7" after 7 ns , x"E" after 8 ns, x"F" after 9 ns, x"E" after 10 ns;

end architecture decoder_tb_arch;

configuration decoder_tb_conf of decoder_tb is
	for decoder_tb_arch
		for dut : decoder
			use entity LIB_RTL.decoder(decoder_arch);
		end for;
	end for;
end configuration decoder_tb_conf;
