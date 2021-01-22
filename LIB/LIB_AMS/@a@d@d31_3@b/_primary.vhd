library verilog;
use verilog.vl_types.all;
entity ADD31_3B is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        CI              : in     vl_logic;
        CO              : out    vl_logic;
        S               : out    vl_logic
    );
end ADD31_3B;
