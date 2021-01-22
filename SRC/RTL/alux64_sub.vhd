library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_sub is

  port (
  a_i :      in std_logic_vector(63 downto 0);
  b_i :      in std_logic_vector(63 downto 0);
  co_o :     out std_logic;
  s_o:       out std_logic_vector(63 downto 0));

end entity alux64_sub;


architecture alux64_sub_arch of alux64_sub is

  component inverter
    port (
    e_i :      in std_logic;
    s_o :      out std_logic);
  end component inverter;

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

  component inverterx64
    port (
    e_i :      in std_logic_vector(63 downto 0);
    s_o :      out std_logic_vector(63 downto 0));
  end component inverterx64;

  component and_gate
    port (
      a_i, b_i : in std_logic;
      s_o : out std_logic);
  end component and_gate;

  signal inverterx64_adder_s : std_logic_vector(63 downto 0) :=(others=>'0');
  signal adder_adder_s : std_logic_vector(63 downto 0) :=(others=>'0');
  signal carry_adderab_s : std_logic :='0';
  signal carry_adderab_inverted_s : std_logic :='0';
  signal carry_adder1_s : std_logic :='0';
  signal carry_adder1_inverted_s : std_logic :='0';

begin  -- adder_synch_arch

    inverterx64_1 : inverterx64
    port map (
    e_i => b_i,
    s_o => inverterx64_adder_s
    );

    adder_gen_add1 : adder_gen
    generic map (
    N => 64)

    port map (
    a_i => x"0000000000000001", --add one to the inverted b
    b_i => inverterx64_adder_s,
    ci_i => '0',
    s_o => adder_adder_s,
    co_o => carry_adder1_s);

    adder_gen_ab : adder_gen
    generic map (
    N => 64)

    port map (
    a_i => a_i, --add a_i and inverted b_i
    b_i => adder_adder_s,
    ci_i => '0',
    co_o => carry_adderab_s,
    s_o => s_o);

    inverter_carryab : inverter
    port map ( --carry value is 0 if a - b < 0, need to invert it so.
      e_i => carry_adderab_s,
      s_o => carry_adderab_inverted_s);

    inverter_carryadd1 : inverter
    port map ( --this carry value is '1' ONLY if b_i = 0x0000000000000000, particular value because return 1 in final adder carry
      e_i => carry_adder1_s,
      s_o => carry_adder1_inverted_s);

    and_gate_carry : and_gate
    port map (
      a_i => carry_adder1_inverted_s,
      b_i => carry_adderab_inverted_s,
      s_o => co_o);

end alux64_sub_arch;

configuration alux64_sub_conf of alux64_sub is

  for alux64_sub_arch --architecture name

    for all : adder_gen --component name
      use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
    end for;

    for all : and_gate --component name
      use entity lib_rtl.and_gate(and_gate_arch); --model choice
    end for;

    for all : inverterx64 --component name
      use entity lib_rtl.inverterx64(inverterx64_arch); --model choice
    end for;

  end for;

end alux64_sub_conf;
