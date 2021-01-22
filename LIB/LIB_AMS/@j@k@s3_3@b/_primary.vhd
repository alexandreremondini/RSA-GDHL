library verilog;
use verilog.vl_types.all;
entity JKS3_3B is
    port(
        C               : in     vl_logic;
        J               : in     vl_logic;
        K               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SD              : in     vl_logic;
        SE              : in     vl_logic
    );
end JKS3_3B;
