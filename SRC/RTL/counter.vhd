library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
  generic(
    N : natural);
  port(
    resetb_i : in std_logic;
  	enable_i : in std_logic;
    init_i : in std_logic;
  	clk_i : in std_logic;
  	count_o : out std_logic_vector(N-1 downto 0));
end entity counter;

architecture counter_arch of counter is
signal counter_s : std_logic_vector(N-1 downto 0);
begin
	P0 : process(clk_i, resetb_i, enable_i)
	begin
		if (resetb_i = '0') then
			counter_s <= (others=>'0');
		elsif (clk_i'event and clk_i = '1') then
      if (init_i = '1') then
        counter_s <= (others=>'0');
			elsif (enable_i = '1') then
				counter_s <= std_logic_vector(unsigned(counter_s) + 1);
			end if;
		end if;
	end process P0;

	count_o <= counter_s;

end architecture counter_arch;
