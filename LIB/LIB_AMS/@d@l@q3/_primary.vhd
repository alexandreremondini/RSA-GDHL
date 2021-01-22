library verilog;
use verilog.vl_types.all;
entity DLQ3 is
    port(
        D               : in     vl_logic;
        GN              : in     vl_logic;
        Q               : out    vl_logic
    );
end DLQ3;
