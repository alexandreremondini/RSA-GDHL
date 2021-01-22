-- Parallelised architecture
-- 16 adder_synch_x64 needed
-- 1024 full adder, 1024 registers, one clock rise only

library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity adder_1024 is

  port (
  a_i:  in std_logic_vector(1023 downto 0);
  b_i:  in std_logic_vector(1023 downto 0);
  clk_i : in std_logic;
  resetb_i : in std_logic;
  sel_i : in std_logic;
  s_o:  out std_logic_vector(1023 downto 0));

end entity adder_1024;


architecture adder_1024_arch of adder_1024 is

  component adder_synch_x64 is

    port (
    a_i :      in std_logic_vector(63 downto 0);
    b_i :      in std_logic_vector(63 downto 0);
    cin_i :    in std_logic;
    clk_i :    in std_logic;
    resetb_i : in std_logic;
    sel_i :    in std_logic;
    cout_o :   out std_logic;
    s_o:       out std_logic_vector(63 downto 0));

  end component adder_synch_x64;

  signal a_s : std_logic_vector(1023 downto 0);
  signal b_s : std_logic_vector(1023 downto 0);
  signal s_s : std_logic_vector(1023 downto 0);
  signal c_s : std_logic_vector(16 downto 0); --1024/64 + 1 for all carries

begin  -- adder_synch_arch
  c_s(0) <= '0'; -- first input carry, not used
  a_s <= a_i;
  b_s <= b_i;
  s_o <= s_s;

  adder_synch_x64_gen : for i in 0 to 15 generate -- l'étiquette du for generate est nécessaire
    OP1 : adder_synch_x64
    port map (
    a_i      => a_s((i + 1) * 64 - 1 downto i * 64),
    b_i      => b_i((i + 1) * 64 - 1 downto i * 64),
    cin_i    => c_s(i),
    clk_i    => clk_i,
    sel_i    => sel_i,
    resetb_i => resetb_i,
    s_o      => s_s((i + 1) * 64 - 1 downto i * 64),
    cout_o   => c_s(i + 1));
  end generate adder_synch_x64_gen;

end adder_1024_arch;

configuration adder_1024_conf of adder_1024 is

  for adder_1024_arch --architecture name
    for adder_synch_x64_gen
      for all : adder_synch_x64 --component name
        use entity lib_rtl.adder_synch_x64(adder_synch_x64_arch); --model choice
      end for;
    end for;
  end for;

end adder_1024_conf;
