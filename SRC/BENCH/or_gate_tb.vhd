-------------------------------------------------------------------------------
-- Title      : or_gate_tb.vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : or_gate_tb.vhd
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

entity or_gate_tb is

end entity or_gate_tb;

architecture or_gate_tb_arch of or_gate_tb is

  component or_gate is
    port (
      a_i, b_i : in std_logic;
      s_o : out std_logic);
  end component or_gate;

  signal a_s, b_s, s_s : std_logic;


begin  -- architecture or_gate_tb_arch

  dut : or_gate
    port map(
      a_i => a_s,
      b_i => b_s,
      s_o => s_s);

  a_s <= '0', '1' after 10 ns, '0' after 20 ns;
  b_s <= '0', '1' after 15 ns, '0' after 25 ns;

end architecture or_gate_tb_arch;

configuration or_gate_tb_conf of or_gate_tb is
	for or_gate_tb_arch
		for dut : or_gate
			use entity lib_rtl.or_gate(or_gate_arch);
		end for;
	end for;
end configuration or_gate_tb_conf;
