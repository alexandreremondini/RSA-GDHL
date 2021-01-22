library ieee;
use ieee.std_logic_1164.all;

entity reg is
  generic (
    N : natural);

  port (
    clk_i    : in std_logic;
    d_i      : in std_logic_vector(N-1 downto 0);
    resetb_i : in std_logic;
    sel_i    : in std_logic;
    q_o      : out std_logic_vector(N-1 downto 0));

end entity reg;

architecture reg_arch of reg is

  component dff is
    port (
      clk_i    : in std_logic;
      d_i      : in std_logic;
      resetb_i : in std_logic;
      sel_i    : in std_logic;
      q_o      : out std_logic);
  end component dff;

--signal d_s : std_logic_vector(nb_bits_g-1 downto 0);
begin  -- reg_arch
  dff_gen : for i in 0 to N-1 generate -- l'étiquette du for generate est nécessaire
    OP1 : dff
    port map (
      clk_i    => clk_i,
      d_i    => d_i(i),
      resetb_i  => resetb_i,
      sel_i    => sel_i,
      q_o => q_o(i));
  end generate dff_gen;

end reg_arch;
