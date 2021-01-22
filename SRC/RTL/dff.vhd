library ieee;
use ieee.std_logic_1164.all;

entity dff is

  port (
    clk_i    : in std_logic;
    d_i      : in std_logic;
    resetb_i : in std_logic;
    sel_i    : in std_logic;
    q_o      : out std_logic);

end entity dff;

architecture dff_arch of dff is
signal q_s : std_logic;
begin  -- dff_arch
  seq0: process (clk_i, resetb_i, sel_i)
  begin  -- process seq0
    if resetb_i = '0' then              -- asynchronous reset (active low)
      q_s <= '0';
    elsif (clk_i'event and clk_i = '1') then  -- rising clock edge
        if (sel_i = '1') then
          q_s <= d_i;
        else
          q_s <= q_s;
        end if;
    end if;
end process seq0;

  q_o <= q_s;

end dff_arch;
