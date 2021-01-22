library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity generic_mux is
    generic (
        N:    natural := 4; --2^N = number of entries
        W: natural := 64 --width of each entry
    );
    port (
        a_i : in std_logic_vector ((2**N)*W-1 downto 0) :=(others=>'0');
        sel_i : in std_logic_vector(N-1 downto 0):=(others=>'0');
        s_o : out std_logic_vector (W-1 downto 0):=(others=>'0')
    );
end entity;

architecture generic_mux_arch of generic_mux is
    type mux_array is array (natural range 0 to 2**N-1) of
                std_logic_vector(s_o'range);
    signal array_val: mux_array;
begin

GEN: for i in array_val'range generate
        array_val(i) <= a_i (s_o'LEFT+(i*W) downto i*W);
    end generate;

    s_o <= array_val(to_integer(unsigned(sel_i)));

end architecture;
