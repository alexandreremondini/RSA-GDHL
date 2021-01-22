-------------------------------------------------------------------------------
-- Title      : full_adder_tb.vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : full_adder_tb.vhd
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

library LIB_RTL;

entity full_adder_tb is

end entity full_adder_tb;

architecture full_adder_tb_arch of full_adder_tb is

  component full_adder is
    port (
      a_i, b_i, cin_i : in std_logic;
      s_o, cout_o	    : out std_logic);
  end component full_adder;

  signal a_s, b_s, cin_s, s_s, cout_s : std_logic;


begin  -- architecture full_adder_tb_arch

  dut : full_adder
    port map(
      a_i => a_s,
      b_i => b_s,
      cin_i => cin_s,
      s_o => s_s,
      cout_o => cout_s);

  a_s <= '0', '1' after 1 ns, '0' after 2 ns, '1' after 3 ns, '0' after 4 ns, '1' after 5 ns, '0' after 6 ns, '1' after 7 ns ;
  b_s <= '0', '1' after 2 ns, '0' after 4 ns, '1' after 6 ns ;
  cin_s <= '0', '1' after 4 ns ;

end architecture full_adder_tb_arch;

configuration full_adder_tb_conf of full_adder_tb is
	for full_adder_tb_arch
		for dut : full_adder
			use entity LIB_RTL.full_adder(full_adder_arch);
		end for;
	end for;
end configuration full_adder_tb_conf;
