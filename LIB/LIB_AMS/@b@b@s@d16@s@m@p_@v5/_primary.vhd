library verilog;
use verilog.vl_types.all;
entity BBSD16SMP_V5 is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : inout  vl_logic;
        Y               : out    vl_logic
    );
end BBSD16SMP_V5;
