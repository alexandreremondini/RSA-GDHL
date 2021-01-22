library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_RTL;

entity generic_mux_tb is
end entity generic_mux_tb;

architecture generic_mux_tb_arch of generic_mux_tb is

  component generic_mux is
    generic (
        N:    natural := 4; --2^N = number of entries
        W: natural := 64 --width of each entry
    );
    port (
        a_i : in std_logic_vector ((2**N)*W-1 downto 0);
        sel_i : in std_logic_vector(N-1 downto 0);
        s_o : out std_logic_vector (W-1 downto 0)
    );
  end component generic_mux;

  constant N   : integer := 4;
  constant W   : integer := 64;
  signal a_s   : std_logic_vector((2**N)*W-1 downto 0);
  signal sel_s : std_logic_vector(N-1 downto 0);
  signal s_s   : std_logic_vector(W-1 downto 0);

  constant a:    std_logic_vector (W-1 downto 0) := X"0000000000000000";
  constant b:    std_logic_vector (W-1 downto 0) := X"1111111111111111";
  constant c:    std_logic_vector (W-1 downto 0) := X"2222222222222222";
  constant d:    std_logic_vector (W-1 downto 0) := X"3333333333333333";
  constant e:    std_logic_vector (W-1 downto 0) := X"4444444444444444";
  constant f:    std_logic_vector (W-1 downto 0) := X"5555555555555555";
  constant g:    std_logic_vector (W-1 downto 0) := X"6666666666666666";

begin  -- architecture multiplier_synch_64_tb_arch

  dut : generic_mux
    generic map(
    N => N,
    W => W)
    port map(
    a_i => a_s,
    sel_i => sel_s,
    s_o => s_s);

  a_s <= a & b & c & d & e & f & g & a & a & a & a & a & a & a & a & a;
  sel_s <= X"F", X"E" after 10 ns, X"D" after 20 ns, X"0" after 30 ns, X"D" after 40 ns;
end architecture generic_mux_tb_arch;

configuration generic_mux_tb_conf of generic_mux_tb is
	for generic_mux_tb_arch
		for dut : generic_mux
			use entity LIB_RTL.generic_mux(generic_mux_arch);
		end for;
	end for;
end configuration generic_mux_tb_conf;
