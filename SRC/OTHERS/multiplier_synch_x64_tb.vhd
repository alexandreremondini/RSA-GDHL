-------------------------------------------------------------------------------
-- Title      : multiplier_synch_64_tb.vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : multiplier_synch_64_tb.vhd
-- Author     :   JBRIGAUD
-- Company    :
-- Created    : 2020-10-04
-- Last update: 2020-10-06
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
--
-------------------------------------------------------------------------------
-- Copyright (c) 2020
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2020-10-04  1.0      jbrigaud        Created
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library LIB_RTL;

entity multiplier_synch_x64_tb is

end entity multiplier_synch_x64_tb;

architecture multiplier_synch_x64_tb_arch of multiplier_synch_x64_tb is

  component multiplier_synch_x64 is
    generic (
    width : positive := 64);
    port (
    a_i:  in std_logic_vector(width-1 downto 0);
    b_i:  in std_logic_vector(width-1 downto 0);
    clk_i : in std_logic;
    resetb_i : in std_logic;
    sel_i : in std_logic;
    s_o:  out std_logic_vector(width*2-1 downto 0));
  end component multiplier_synch_x64;

  constant W : integer := 64;
  signal a_s   : std_logic_vector(W-1 downto 0) := (others => '0');
  signal clk_s : std_logic := '0';
  signal b_s : std_logic_vector(W-1 downto 0) := (others => '0');
  signal resetb_s    : std_logic := '0';
  signal sel_s  : std_logic := '0';
  signal s_s : std_logic_vector(W*2-1 downto 0) := (others => '0');


begin  -- architecture multiplier_synch_64_tb_arch

  dut : multiplier_synch_x64
    generic map(
    width => W)
    port map(
    a_i => a_s,
    b_i => b_s,
    clk_i => clk_s,
    resetb_i => resetb_s,
    sel_i => sel_s,
    s_o => s_s);

  a_s <= (others => '1'), x"FFFFFFFFFFFFFFFF" after 45 ns, x"AAAAAAAAAAAAAAAA" after 65 ns;
  b_s <= (others => '1'), x"8000000000000000" after 45 ns, x"0000000000000002" after 65 ns;
  clk_s    <= not clk_s after 10 ns;
  sel_s <= '0', '1' after 25 ns, '0' after 35 ns, '1' after 45 ns, '0' after 55 ns, '1' after 65 ns, '0' after 75 ns;
  resetb_s <= '1', '0' after 100 ns, '1' after 105 ns;

end architecture multiplier_synch_x64_tb_arch;

configuration multiplier_synch_x64_tb_conf of multiplier_synch_x64_tb is
	for multiplier_synch_x64_tb_arch
		for dut : multiplier_synch_x64
			use entity LIB_RTL.multiplier_synch_x64(multiplier_synch_x64_arch);
		end for;
	end for;
end configuration multiplier_synch_x64_tb_conf;
