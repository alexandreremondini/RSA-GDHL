library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity adder_gen is

  generic (
	N : natural); -- Le paramètre N permet de dimensionner la taille de l'additionneur, il est déclaré avec la clause generic

  port (
  a_i:  in std_logic_vector(N-1 downto 0);
  b_i:  in std_logic_vector(N-1 downto 0);
  ci_i: in std_logic;
  s_o:  out std_logic_vector(N-1 downto 0);
  co_o: out std_logic);

end entity adder_gen;


architecture adder_gen_arch of adder_gen is

  component full_adder
    port (
    a_i    : in  std_logic;
    b_i    : in  std_logic;
    cin_i  : in  std_logic;                -- carry in
    s_o    : out std_logic;                -- sum
    cout_o : out std_logic);               -- carry out
  end component;

signal c_s : std_logic_vector(N downto 0) :=(others=>'0');

begin  -- full_adder_arch

  -- to place input and output carries in the signal to avoid side effects
  c_s(0) <= ci_i; -- input carry
  co_o <= c_s(N); -- output carry

  full_adder_gen : for i in 0 to N-1 generate -- l'étiquette du for generate est nécessaire
    OP1 : full_adder
    port map (
    a_i    => a_i(i),
    b_i    => b_i(i),
    cin_i  => c_s(i),
    s_o    => s_o(i),
    cout_o => c_s(i+1)); --la variable de boucle OP1 n'est pas nécessaire
  end generate full_adder_gen;

end adder_gen_arch;

--configuration adder_gen_conf of adder_gen is

--  for adder_gen_arch --architecture name

--    for G
--      for OP1 : full_adder --component name
--        use entity lib_rtl.full_adder(full_adder_arch); --model choice
--      end for;
--    end for;

--  end for;

--end adder_gen_conf;
