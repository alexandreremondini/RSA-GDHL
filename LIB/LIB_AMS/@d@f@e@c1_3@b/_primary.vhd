library verilog;
use verilog.vl_types.all;
entity DFEC1_3B is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        E               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic
    );
end DFEC1_3B;
