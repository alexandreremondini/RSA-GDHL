library verilog;
use verilog.vl_types.all;
entity DF1_3B is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic
    );
end DF1_3B;
