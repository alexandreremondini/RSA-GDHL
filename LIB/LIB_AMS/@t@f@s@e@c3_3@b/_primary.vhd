library verilog;
use verilog.vl_types.all;
entity TFSEC3_3B is
    port(
        C               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic;
        SD              : in     vl_logic;
        SE              : in     vl_logic;
        T               : in     vl_logic
    );
end TFSEC3_3B;
