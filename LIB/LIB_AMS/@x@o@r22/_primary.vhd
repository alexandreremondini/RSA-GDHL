library verilog;
use verilog.vl_types.all;
entity XOR22 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Q               : out    vl_logic
    );
end XOR22;
