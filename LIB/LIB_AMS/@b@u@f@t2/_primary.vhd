library verilog;
use verilog.vl_types.all;
entity BUFT2 is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        Q               : out    vl_logic
    );
end BUFT2;
