library verilog;
use verilog.vl_types.all;
entity BBSD24P_V5 is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : inout  vl_logic;
        Y               : out    vl_logic
    );
end BBSD24P_V5;