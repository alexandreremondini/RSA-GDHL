library verilog;
use verilog.vl_types.all;
entity DFE1_3B is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        E               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic
    );
end DFE1_3B;
