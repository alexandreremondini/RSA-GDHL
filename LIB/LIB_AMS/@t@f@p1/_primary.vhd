library verilog;
use verilog.vl_types.all;
entity TFP1 is
    port(
        C               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SN              : in     vl_logic
    );
end TFP1;
