library verilog;
use verilog.vl_types.all;
entity NOR24_3B is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Q               : out    vl_logic
    );
end NOR24_3B;
