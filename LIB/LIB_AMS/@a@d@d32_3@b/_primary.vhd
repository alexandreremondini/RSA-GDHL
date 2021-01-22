library verilog;
use verilog.vl_types.all;
entity ADD32_3B is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        CI              : in     vl_logic;
        CO              : out    vl_logic;
        S               : out    vl_logic
    );
end ADD32_3B;
