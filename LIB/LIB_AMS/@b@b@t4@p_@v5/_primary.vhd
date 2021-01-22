library verilog;
use verilog.vl_types.all;
entity BBT4P_V5 is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : inout  vl_logic;
        Y               : out    vl_logic
    );
end BBT4P_V5;
