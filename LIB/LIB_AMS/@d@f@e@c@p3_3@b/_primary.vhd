library verilog;
use verilog.vl_types.all;
entity DFECP3_3B is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        E               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic;
        SN              : in     vl_logic
    );
end DFECP3_3B;
