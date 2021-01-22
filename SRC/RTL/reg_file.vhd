library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library LIB_RTL;

entity reg_file is
  generic (
    N_reg : natural); --2^N = number of registers x64

  port (
    clk_i    : in std_logic;
    resetb_i : in std_logic;
    en_write_i   : in std_logic;
    addr_read1_i : in std_logic_vector(N_reg-1 downto 0);
    addr_read2_i : in std_logic_vector(N_reg-1 downto 0);
    addr_write_i : in std_logic_vector(N_reg-1 downto 0);
    data_write_i : in std_logic_vector(63 downto 0);
    data_read1_o : out std_logic_vector(63 downto 0);
    data_read2_o : out std_logic_vector(63 downto 0));

end entity reg_file;

architecture reg_file_arch of reg_file is

  component reg
    generic (
      N : natural); --number of D flip flop

    port (
      clk_i    : in std_logic;
      d_i      : in std_logic_vector(N-1 downto 0);
      resetb_i : in std_logic;
      sel_i    : in std_logic;
      q_o      : out std_logic_vector(N-1 downto 0));
  end component reg;

  component decoder
  generic (
    N : natural); --number of input bits

  port (
    a_i     : in std_logic_vector(N-1 downto 0);
    s_o     : out std_logic_vector(2**N-1 downto 0));
  end component decoder;

component and_gate
  port (
    a_i, b_i : in std_logic;
    s_o : out std_logic);
end component and_gate;

component generic_mux
    generic (
        N:    natural := 4; --2^N = number of entries
        W: natural := 64 --width of each entry
    );
    port (
        a_i : in std_logic_vector ((2**N)*W-1 downto 0);
        sel_i : in std_logic_vector(N-1 downto 0);
        s_o : out std_logic_vector (W-1 downto 0)
    );
end component generic_mux;

signal decoder_to_and : std_logic_vector(2**N_reg - 1 downto 0) := (others => '0');
signal and_to_reg : std_logic_vector(2**N_reg - 1 downto 0) := (others => '0');
signal reg_to_mux : std_logic_vector(2**N_reg * 64 - 1 downto 0) := (others => '0');
begin

  decoder_1 : decoder
  generic map (
  N => N_reg)
  port map (
  a_i => addr_write_i,
  s_o => decoder_to_and);

  and_gate_gen : for i in 0 to (integer'(2) ** N_reg - 1) generate -- l'étiquette du for generate est nécessaire
    OP1 : and_gate
    port map(
      a_i => en_write_i,
      b_i => decoder_to_and(i),
      s_o => and_to_reg(i));
  end generate and_gate_gen;

  reg_gen : for i in 0 to (integer'(2) ** N_reg - 1) generate -- l'étiquette du for generate est nécessaire
    OP2 : reg
    generic map (
      N => 64
    )
    port map (
      clk_i => clk_i,
      d_i  => data_write_i,
      resetb_i => resetb_i,
      sel_i => and_to_reg(i),
      q_o => reg_to_mux(64 * (i+1) - 1 downto 64 * i));
  end generate reg_gen;

  generic_mux_1 : generic_mux
    generic map(
        N => N_reg, --2^N = number of entries
        W => 64) --width of each entry
    port map(
        a_i => reg_to_mux,
        sel_i => addr_read1_i,
        s_o => data_read1_o);

  generic_mux_2 : generic_mux
    generic map(
        N => N_reg, --2^N = number of entries
        W => 64) --width of each entry
    port map(
        a_i => reg_to_mux,
        sel_i => addr_read2_i,
        s_o => data_read2_o);

end reg_file_arch;

configuration reg_file_conf of reg_file is

  for reg_file_arch --architecture name

    for all : decoder --component name
      use entity lib_rtl.decoder(decoder_arch); --model choice
    end for;

    for and_gate_gen
      for OP1 : and_gate
        use entity lib_rtl.and_gate(and_gate_arch);
      end for;
    end for;

    for reg_gen
      for OP2 : reg
        use entity lib_rtl.reg(reg_arch);
      end for;
    end for;

    for all : generic_mux
      use entity lib_rtl.generic_mux(generic_mux_arch);
    end for;

  end for;

end reg_file_conf;
