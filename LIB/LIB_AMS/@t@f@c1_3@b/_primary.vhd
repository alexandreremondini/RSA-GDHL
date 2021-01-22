library verilog;
use verilog.vl_types.all;
entity TFC1_3B is
    port(
        C               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic
    );
end TFC1_3B;
