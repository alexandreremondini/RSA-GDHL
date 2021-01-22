library verilog;
use verilog.vl_types.all;
entity TFEP3_3B is
    port(
        C               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SN              : in     vl_logic;
        T               : in     vl_logic
    );
end TFEP3_3B;
