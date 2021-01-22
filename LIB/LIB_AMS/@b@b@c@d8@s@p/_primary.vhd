library verilog;
use verilog.vl_types.all;
entity BBCD8SP is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : inout  vl_logic;
        Y               : out    vl_logic
    );
end BBCD8SP;
