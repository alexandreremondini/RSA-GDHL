library verilog;
use verilog.vl_types.all;
entity DFSE1_3B is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        E               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SD              : in     vl_logic;
        SE              : in     vl_logic
    );
end DFSE1_3B;
