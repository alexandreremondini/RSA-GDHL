library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity adder_synch_x64 is

  port (
  a_i :      in std_logic_vector(63 downto 0);
  b_i :      in std_logic_vector(63 downto 0);
  cin_i :    in std_logic;
  clk_i :    in std_logic;
  resetb_i : in std_logic;
  sel_i :    in std_logic;
  cout_o :   out std_logic;
  s_o:       out std_logic_vector(63 downto 0));

end entity adder_synch_x64;


architecture adder_synch_x64_arch of adder_synch_x64 is

  component adder_gen
    generic (
  	N : natural := 64); -- N is the number of adder = the maximal number of bits of added numbers

    port (
    a_i:  in std_logic_vector(N-1 downto 0);
    b_i:  in std_logic_vector(N-1 downto 0);
    ci_i: in std_logic;
    s_o:  out std_logic_vector(N-1 downto 0);
    co_o: out std_logic);
  end component adder_gen;

  component reg
    generic (
      N : natural := 64);

    port (
      clk_i    : in std_logic;
      d_i      : in std_logic_vector(N-1 downto 0);
      resetb_i : in std_logic;
      sel_i    : in std_logic;
      q_o      : out std_logic_vector(N-1 downto 0));
  end component reg;

  signal a_s : std_logic_vector(63 downto 0);
  signal b_s : std_logic_vector(63 downto 0);
  signal s_s : std_logic_vector(63 downto 0);
  signal c_s : std_logic;

begin  -- adder_synch_arch

    adder_gen_1 : adder_gen
    generic map (
    N => 64)

    port map (
    a_i => a_s,
    b_i => b_s,
    ci_i => cin_i,
    s_o => s_s,
    co_o => cout_o);

    reg_a : reg
    generic map (
    N => 64)

    port map (
    clk_i => clk_i,
    d_i => a_i,
    resetb_i => resetb_i,
    sel_i => sel_i,
    q_o => a_s);

    reg_b : reg
    generic map (
    N => 64)

    port map (
    clk_i => clk_i,
    d_i => b_i,
    resetb_i => resetb_i,
    sel_i => sel_i,
    q_o => b_s);

    reg_s : reg
    generic map (
    N => 64)

    port map (
    clk_i => clk_i,
    d_i => s_s,
    resetb_i => resetb_i,
    sel_i => sel_i,
    q_o => s_o);

end adder_synch_x64_arch;

configuration adder_synch_x64_conf of adder_synch_x64 is

  for adder_synch_x64_arch --architecture name

    for all : adder_gen --component name
      use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
    end for;

    for all : reg
      use entity lib_rtl.reg(reg_arch);
    end for;

  end for;

end adder_synch_x64_conf;
