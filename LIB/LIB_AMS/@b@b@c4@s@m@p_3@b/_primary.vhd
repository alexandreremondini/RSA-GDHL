library verilog;
use verilog.vl_types.all;
entity BBC4SMP_3B is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : inout  vl_logic;
        Y               : out    vl_logic
    );
end BBC4SMP_3B;
