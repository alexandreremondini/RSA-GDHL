library verilog;
use verilog.vl_types.all;
entity TFC3_3B is
    port(
        C               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic
    );
end TFC3_3B;
