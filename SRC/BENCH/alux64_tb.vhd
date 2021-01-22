library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_tb is
end entity alux64_tb;


architecture alux64_tb_arch of alux64_tb is

  component alux64
    port (
    a_i  :       in std_logic_vector(63 downto 0);
    b_i  :       in std_logic_vector(63 downto 0);
    high_mul_i :   in std_logic;
    cadd_i :       in std_logic;
    csub_i :       in std_logic;
    shftr_i :     in std_logic;
    shftl_i :     in std_logic;
    ope_i :      in std_logic_vector(3 downto 0);
    s_o:         out std_logic_vector(63 downto 0);
    cadd_o :       out std_logic;
    csub_o :       out std_logic;
    shftr_o :     out std_logic;
    shftl_o :     out std_logic);
  end component alux64;

  signal a_s  :      std_logic_vector(63 downto 0) := (others => '0');
  signal b_s  :      std_logic_vector(63 downto 0) := (others => '0');
  signal high_mul_s  :      std_logic;
  signal cadd_i_s :      std_logic := '0';
  signal csub_i_s :      std_logic := '0';
  signal shftr_i_s :      std_logic := '0';
  signal shftl_i_s :      std_logic := '0';
  signal ope_s :     std_logic_vector(3 downto 0) := (others => '0');
  signal s_s:        std_logic_vector(63 downto 0):= (others => '0');
  signal cadd_o_s :      std_logic := '0';
  signal csub_o_s :      std_logic := '0';
  signal shftr_o_s :      std_logic := '0';
  signal shftl_o_s :      std_logic := '0';

begin  -- adder_synch_arch

    alux64_1 : alux64
    port map (
    a_i  => a_s,
    b_i  => b_s,
    high_mul_i => high_mul_s,
    cadd_i => cadd_i_s,
    csub_i => csub_i_s,
    shftr_i => shftr_i_s,
    shftl_i => shftl_i_s,
    ope_i => ope_s,
    s_o => s_s,
    cadd_o => cadd_o_s,
    csub_o => csub_o_s,
    shftr_o => shftr_o_s,
    shftl_o => shftl_o_s);

    a_s <= x"0888888888888888", x"8888888888888888" after 20 ns, x"F333333322222222" after 60 ns;
    b_s <= x"F777777777777777", x"0000000000000000" after 20 ns, x"7777777977777777" after 22 ns, x"FFFFFFFFFFFFFFFF" after 26 ns, x"9777777977777777" after 28 ns, x"7777777977777777" after 30 ns, x"8888888888888889" after 32 ns, x"FFFFFFFFFFFFFFFF" after 38 ns, x"8000000000000003" after 60 ns;
    high_mul_s <= '0';
    cadd_i_s <= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns;
    csub_i_s <= '0', '1' after 25 ns, '0' after 30 ns, '1' after 35 ns;
    ope_s <= x"1", x"2" after 10 ns, x"3" after 20 ns, x"4" after 30 ns, x"5" after 40 ns, x"6" after 50 ns, x"7" after 60 ns, x"8" after 70 ns, x"9" after 80 ns, x"A" after 90 ns, x"B" after 100 ns;

end alux64_tb_arch;

configuration alux64_tb_conf of alux64_tb is

  for alux64_tb_arch --architecture name
    for all : alux64 --component name
      use entity lib_rtl.alux64(alux64_arch); --model choice
    end for;
  end for;

end alux64_tb_conf;
