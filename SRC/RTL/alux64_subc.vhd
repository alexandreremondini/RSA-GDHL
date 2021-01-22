library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_subc is

  port (
  a_i :      in std_logic_vector(63 downto 0);
  b_i :      in std_logic_vector(63 downto 0);
  ci_i:      in std_logic;
  co_o :     out std_logic;
  s_o:       out std_logic_vector(63 downto 0));

end entity alux64_subc;


architecture alux64_subc_arch of alux64_subc is

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

  component inverter
    port (
    e_i :      in std_logic;
    s_o :      out std_logic);
  end component inverter;

  component or_gate is
    port (
      a_i, b_i : in std_logic;
      s_o : out std_logic);
  end component or_gate;

  component and_gate
    port (
      a_i, b_i : in std_logic;
      s_o : out std_logic);
  end component and_gate;

  signal addercarry_inverter : std_logic_vector(63 downto 0) :=(others=>'0'); --first adder (add input carry sub to substracted number) to inverter
  signal inverter_adder_s : std_logic_vector(63 downto 0) :=(others=>'0'); --inverter to second adder (add 1 to inverted substracted number)
  signal adder_adder_s : std_logic_vector(63 downto 0) :=(others=>'0'); -- second adder (add 1) to final adder (add a_i and comp 2 b_i)
  signal carry_addercarry_s : std_logic :='0'; --output carry of the first adder
  signal carry_ab_s : std_logic :='0'; --output carry of the final adder to inverter
  signal carry_ab_inverted_s : std_logic :='0'; --output carry of the final adder to or gate

  signal carry_or_gate_s : std_logic :='0';
  signal carry_adder1_s : std_logic :='0';
  signal carry_adder1_inverted_s : std_logic :='0';

begin  -- adder_synch_arch

    adder_gen_carry : adder_gen
    generic map ( --just to add sub input carry
    N => 64)

    port map (
    a_i => (others=>'0'),
    b_i => b_i,
    ci_i => ci_i,
    co_o => carry_addercarry_s, --if b_i = 0xFFFF... when we add 1, we must keep it as a sub carry
    s_o => addercarry_inverter);

    inverterx64_1 : inverterx64
    port map (
    e_i => addercarry_inverter,
    s_o => inverter_adder_s);

    adder_gen_add1 : adder_gen
    generic map (
    N => 64)

    port map (
    a_i => x"0000000000000001",--add one to the inverted b
    b_i => inverter_adder_s,
    ci_i => '0',
    s_o => adder_adder_s,
    co_o => carry_adder1_s);

    inverter_carryadd1 : inverter
    port map ( --this carry value is '1' ONLY if b_i = 0x0000000000000000, particular value because return 1 in final adder carry
    e_i => carry_adder1_s,
    s_o => carry_adder1_inverted_s);

    adder_gen_ab : adder_gen
    generic map (
    N => 64)

    port map (
    a_i => a_i,
    b_i => adder_adder_s,
    ci_i => '0', --sub carry have been added previously
    co_o => carry_ab_s,
    s_o => s_o);

    inverter_carryab : inverter
    port map ( --carry value is 0 if a - b < 0, need to invert it so.
      e_i => carry_ab_s,
      s_o => carry_ab_inverted_s);

    and_gate_carry : and_gate
      port map ( --this final adder is needed because output sub carry can come from the first adder or the final adder
        a_i => carry_ab_inverted_s, --carry value is 0 if a - b < 0, need to invert it so.
        b_i => carry_adder1_inverted_s,
        s_o => carry_or_gate_s);

    or_gate_carry : or_gate
    port map (
      a_i => carry_addercarry_s,
      b_i => carry_or_gate_s,
      s_o => co_o);


end alux64_subc_arch;

configuration alux64_subc_conf of alux64_subc is

  for alux64_subc_arch --architecture name

    for all : adder_gen --component name
      use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
    end for;

    for all : or_gate --component name
      use entity lib_rtl.or_gate(or_gate_arch); --model choice
    end for;

    for all : and_gate --component name
      use entity lib_rtl.and_gate(and_gate_arch); --model choice
    end for;

    for all : inverterx64 --component name
      use entity lib_rtl.inverterx64(inverterx64_arch); --model choice
    end for;

  end for;

end alux64_subc_conf;
