library verilog;
use verilog.vl_types.all;
entity DFP1_3B is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SN              : in     vl_logic
    );
end DFP1_3B;
