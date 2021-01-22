library verilog;
use verilog.vl_types.all;
entity JKSCP1_3B is
    port(
        C               : in     vl_logic;
        J               : in     vl_logic;
        K               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic;
        SD              : in     vl_logic;
        SE              : in     vl_logic;
        SN              : in     vl_logic
    );
end JKSCP1_3B;
