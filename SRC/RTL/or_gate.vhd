-------------------------------------------------------------------------------
-- Title      : or_gate.vhd
-- Project    :
-------------------------------------------------------------------------------
-- File       : or_gate.vhd
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

entity or_gate is
  port (
    a_i, b_i : in std_logic;
    s_o : out std_logic);
end entity or_gate;

architecture or_gate_arch of or_gate is

begin  -- architecture or_gate_arch
  s_o <= a_i or b_i;
end architecture or_gate_arch;
