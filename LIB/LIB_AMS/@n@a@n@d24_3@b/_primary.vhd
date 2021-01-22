library verilog;
use verilog.vl_types.all;
entity NAND24_3B is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Q               : out    vl_logic
    );
end NAND24_3B;
