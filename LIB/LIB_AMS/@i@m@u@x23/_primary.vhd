library verilog;
use verilog.vl_types.all;
entity IMUX23 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Q               : out    vl_logic;
        S               : in     vl_logic
    );
end IMUX23;
