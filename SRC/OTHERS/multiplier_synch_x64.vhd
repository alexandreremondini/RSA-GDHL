library IEEE;
use IEEE.std_logic_1164.all;
library LIB_RTL;

entity multiplier_synch_x64 is

  generic (
    width : positive := 64);             -- number of full_adder and mux

  port (
  a_i:  in std_logic_vector(width-1 downto 0);
  b_i:  in std_logic_vector(width-1 downto 0);
  clk_i : in std_logic;
  resetb_i : in std_logic;
  sel_i : in std_logic;
  s_o:  out std_logic_vector(width*2-1 downto 0));

end entity multiplier_synch_x64;


architecture multiplier_synch_x64_arch of multiplier_synch_x64 is

  component adder_gen
    generic (
  	N : natural := width); -- N is the number of adder = the maximal number of bits of added numbers
    port (
    a_i:  in std_logic_vector(N-1 downto 0);
    b_i:  in std_logic_vector(N-1 downto 0);
    ci_i: in std_logic;
    s_o:  out std_logic_vector(N-1 downto 0);
    co_o: out std_logic);
  end component adder_gen;

  component reg
    generic (
      N : natural := width);
    port (
      clk_i    : in std_logic;
      d_i      : in std_logic_vector(N-1 downto 0);
      resetb_i : in std_logic;
      sel_i    : in std_logic;
      q_o      : out std_logic_vector(N-1 downto 0));
  end component reg;

  component generic_mux is
    generic (
        N: natural := 4; --2^N = number of entries
        W: natural := 64); --width of each entry
    port (
        a_i : in std_logic_vector ((2**N)*W-1 downto 0);
        sel_i : in std_logic_vector(N-1 downto 0);
        s_o : out std_logic_vector (W-1 downto 0)
    );
  end component generic_mux;

  signal a_s : std_logic_vector(width-1 downto 0);
  signal b_s : std_logic_vector(width-1 downto 0);
  signal s_s : std_logic_vector(width*2-1 downto 0);
  signal mux_adder_s : std_logic_vector((width**2)-1 downto 0);       --64 internal signals between the 64 mux and 64 adders of 64 bits each
  signal adder_adder_s : std_logic_vector((width-1)*(width+1) - 1 downto 0);       -- 511 internal signals between the 64 adders of 64 + 1(carry) bits each
  signal mux_entry_s : std_logic_vector(2*width-1 downto 0):= (others=>'0'); -- for generic mux
begin  -- adder_synch_arch
  mux_entry_s(width-1 downto 0) <= a_i;
    adder_gen_first : adder_gen
    generic map (
    N => width)
    port map (
    a_i => (others => '0'), --specific to the first adder
    b_i => mux_adder_s(width-1 downto 0), --first slice of "width" bits between the first mux to first adder
    ci_i => '0', --carry in is not considered
    s_o => adder_adder_s(width-1 downto 0), --first slice of the adder to adder signal. The LSB is the LSB of the final result
    co_o => adder_adder_s(width)); --the carry is the MSB of the next adder input (a_i)

    s_s(0) <= adder_adder_s(0);

    adder_gen_middle : for i in 1 to width-2 generate -- generate 510 adders
      adder_gen_1 : adder_gen
      generic map (
      N => width)
      port map (
      a_i => adder_adder_s(i * (width + 1) - 1 downto (i - 1) * (width + 1) + 1), -- MSB = c_out of the previous adder / others = "width - 1" bits of s_o from previous adder (from MSB)
      b_i => mux_adder_s((i + 1) * width - 1 downto i * width), --slice of the signal dedicated from the mux to actual adder
      ci_i => '0', --carry in is not considered
      s_o => adder_adder_s((i + 1) * (width + 1) - 2 downto i * (width + 1)), --first slice of the adder to adder signal
      co_o => adder_adder_s((i + 1) * (width + 1) - 1)); --first bit of the internal carries signal

      s_s(i) <= adder_adder_s(i * (width + 1));
    end generate adder_gen_middle;

    adder_gen_last : adder_gen
    generic map (
    N => width)
    port map (
    a_i => adder_adder_s((width-1)*(width+1) - 1 downto (width-2)*(width+1) + 1),
    b_i => mux_adder_s(width**2-1 downto width**2 - width),
    ci_i => '0', --carry in is not considered
    s_o => s_s(2*width-2 downto width-1), --first slice of the adder to adder signal
    co_o => s_s(2*width-1)); --first bit of the internal carries signal

    mux_gen : for i in 0 to width-1 generate --generate 64 mux
      mux_1 : generic_mux
      generic map (
      N => 1,
      W => width)
      port map (
      sel_i(0) => b_i(i),
      a_i => mux_entry_s,
      s_o => mux_adder_s((i+1)*width-1 downto i*width));
    end generate mux_gen;

    reg_a : reg
    generic map (
    N => width)
    port map (
    clk_i => clk_i,
    d_i => a_i,
    resetb_i => resetb_i,
    sel_i => sel_i,
    q_o => a_s);

    reg_b : reg
    generic map (
    N => width)
    port map (
    clk_i => clk_i,
    d_i => b_i,
    resetb_i => resetb_i,
    sel_i => sel_i,
    q_o => b_s);

    reg_s : reg
    generic map (
    N => 2*width)
    port map (
    clk_i => clk_i,
    d_i => s_s,
    resetb_i => resetb_i,
    sel_i => sel_i,
    q_o => s_o);

end multiplier_synch_x64_arch;

configuration multiplier_synch_x64_conf of multiplier_synch_x64 is

  for multiplier_synch_x64_arch --architecture name

    for all : reg
      use entity lib_rtl.reg(reg_arch);
    end for;

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

    for all : adder_gen --component name
      use entity lib_rtl.adder_gen(adder_gen_arch); --model choice
    end for;

  end for;

end multiplier_synch_x64_conf;
