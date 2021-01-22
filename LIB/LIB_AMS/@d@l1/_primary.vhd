library verilog;
use verilog.vl_types.all;
entity DL1 is
    port(
        D               : in     vl_logic;
        GN              : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic
    );
end DL1;
