library verilog;
use verilog.vl_types.all;
entity NAND28_3B is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Q               : out    vl_logic
    );
end NAND28_3B;
