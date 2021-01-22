library verilog;
use verilog.vl_types.all;
entity DLC3_3B is
    port(
        D               : in     vl_logic;
        GN              : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic
    );
end DLC3_3B;
