library verilog;
use verilog.vl_types.all;
entity ADD21_3B is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        CO              : out    vl_logic;
        S               : out    vl_logic
    );
end ADD21_3B;
