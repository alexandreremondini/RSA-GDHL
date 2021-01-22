library verilog;
use verilog.vl_types.all;
entity TFSEP3 is
    port(
        C               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SD              : in     vl_logic;
        SE              : in     vl_logic;
        SN              : in     vl_logic;
        T               : in     vl_logic
    );
end TFSEP3;
