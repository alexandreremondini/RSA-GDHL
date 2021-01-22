library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity alux64_mul is

  port (
  a_i:  in std_logic_vector(63 downto 0);
  b_i:  in std_logic_vector(63 downto 0);
  sel_high_i : in std_logic; -- if set to 1 return 64 MSB of the result, otherwise 64 LSB
  s_o:  out std_logic_vector(63 downto 0));

end entity alux64_mul;


architecture alux64_mul_arch of alux64_mul is

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

  component generic_mux is
    generic (
        N: natural := 1; --2^N = number of entries
        W: natural := 64); --64 of each entry
    port (
        a_i : in std_logic_vector ((2**N)*W-1 downto 0);
        sel_i : in std_logic_vector(N-1 downto 0);
        s_o : out std_logic_vector (W-1 downto 0)
    );
  end component generic_mux;

  signal a_s : std_logic_vector(63 downto 0);
  signal b_s : std_logic_vector(63 downto 0);
  signal s_s : std_logic_vector(127 downto 0);
  signal mux_adder_s : std_logic_vector((64**2)-1 downto 0);       --64 internal signals between the 64 mux and 64 adders of 64 bits each
  signal adder_adder_s : std_logic_vector((64-1)*(64+1) - 1 downto 0);       -- 511 internal signals between the 64 adders of 64 + 1(carry) bits each
  signal mux_entry_s : std_logic_vector(2*64-1 downto 0):= (others=>'0'); -- for generic mux
begin  -- adder_synch_arch

  mux_entry_s(127 downto 64) <= a_i;

    adder_gen_first : adder_gen
    generic map (
    N => 64)
    port map (
    a_i => (others => '0'), --specific to the first adder 64 bits
    b_i => mux_adder_s(63 downto 0), --first slice of 64 bits between the first mux to first adder
    ci_i => '0', --carry in is not considered
    s_o => adder_adder_s(63 downto 0), --first slice of the adder to adder signal. The LSB is the LSB of the final result
    co_o => adder_adder_s(64)); --the carry is the MSB of the next adder input => adder_adder_s(64 downto 1)

    s_s(0) <= adder_adder_s(0); --LSB of the final result !

    adder_gen_middle : for i in 1 to 62 generate -- generate 62 intermediate adders 64 bits
      adder_gen_1 : adder_gen
      generic map (
      N => 64)
      port map (
      a_i => adder_adder_s(i * 65 - 1 downto (i - 1) * 65 + 1), -- MSB = c_out of the previous adder / others = "64 - 1" bits of s_o from previous adder (from MSB)
      b_i => mux_adder_s((i + 1) * 64 - 1 downto i * 64), --slice of the signal dedicated from the mux to actual adder
      ci_i => '0', --carry in is not considered
      s_o => adder_adder_s((i + 1) * 65 - 2 downto i * 65), -- slice of the adder to adder signal
      co_o => adder_adder_s((i + 1) * 65 - 1)); --first bit of the internal carries signal

      s_s(i) <= adder_adder_s(i * 65);
    end generate adder_gen_middle;

    adder_gen_last : adder_gen
    generic map (
    N => 64)
    port map (
    a_i => adder_adder_s((64 - 1) * (64 + 1) - 1 downto (64 - 2) * (64 + 1) + 1),
    b_i => mux_adder_s(64**2 - 1 downto 64**2 - 64),
    ci_i => '0', --carry in is not considered
    s_o => s_s(2 * 64 - 2 downto 64 - 1), --last slice of the adder to adder signal
    co_o => s_s(2 * 64 - 1)); --first bit of the internal carries signal

    mux_gen : for i in 0 to 63 generate --generate 64 mux
      mux_1 : generic_mux
      generic map (
      N => 1,
      W => 64)
      port map (
      sel_i(0) => b_i(i),
      a_i => mux_entry_s,
      s_o => mux_adder_s((i + 1) * 64 - 1 downto i * 64));
    end generate mux_gen;

    mux_high_low : generic_mux
    generic map (
    N => 1,
    W => 64)
    port map (
    sel_i(0) => sel_high_i,
    a_i => s_s,
    s_o => s_o);


end alux64_mul_arch;

configuration alux64_mul_conf of alux64_mul is

  for alux64_mul_arch --architecture name

    for mux_gen
      for mux_1 : generic_mux
        use entity lib_rtl.generic_mux(generic_mux_arch);
      end for;
    end for;

    for adder_gen_middle
      for adder_gen_1 : adder_gen --component name
        use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
      end for;
    end for;

    for all : generic_mux --component name
      use entity lib_rtl.generic_mux(generic_mux_arch); --model choice
    end for;

    for all : adder_gen --component name
      use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
    end for;

  end for;

end alux64_mul_conf;
