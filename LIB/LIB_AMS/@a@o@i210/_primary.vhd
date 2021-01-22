library verilog;
use verilog.vl_types.all;
entity AOI210 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        Q               : out    vl_logic
    );
end AOI210;
