library verilog;
use verilog.vl_types.all;
entity NAND23 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Q               : out    vl_logic
    );
end NAND23;
