library verilog;
use verilog.vl_types.all;
entity JKP3_3B is
    port(
        C               : in     vl_logic;
        J               : in     vl_logic;
        K               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SN              : in     vl_logic
    );
end JKP3_3B;
