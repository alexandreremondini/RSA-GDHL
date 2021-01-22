library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity inverterx64 is

  port (
  e_i :      in std_logic_vector(63 downto 0);
  s_o :      out std_logic_vector(63 downto 0));

end entity inverterx64;


architecture inverterx64_arch of inverterx64 is

  component inverter

    port (
    e_i :      in std_logic;
    s_o :      out std_logic);

  end component inverter;

begin  -- adder_synch_arch
inverter_gen : for i in 0 to 63 generate -- l'étiquette du for generate est nécessaire
  OP1 : inverter
  port map (
  e_i    => e_i(i),
  s_o    => s_o(i)); --la variable de boucle OP1 n'est pas nécessaire
end generate inverter_gen;

end inverterx64_arch;


configuration inverterx64_conf of inverterx64 is

  for inverterx64_arch --architecture name

    for inverter_gen
      for OP1 : inverter
        use entity lib_rtl.inverter(inverter_arch);
      end for;
    end for;

  end for;

end inverterx64_conf;
