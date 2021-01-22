library verilog;
use verilog.vl_types.all;
entity BBT24SP is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : inout  vl_logic;
        Y               : out    vl_logic
    );
end BBT24SP;
