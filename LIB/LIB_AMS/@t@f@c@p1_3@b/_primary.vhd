library verilog;
use verilog.vl_types.all;
entity TFCP1_3B is
    port(
        C               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic;
        SN              : in     vl_logic
    );
end TFCP1_3B;
