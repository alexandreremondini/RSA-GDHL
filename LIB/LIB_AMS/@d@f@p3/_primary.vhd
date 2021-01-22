library verilog;
use verilog.vl_types.all;
entity DFP3 is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SN              : in     vl_logic
    );
end DFP3;
