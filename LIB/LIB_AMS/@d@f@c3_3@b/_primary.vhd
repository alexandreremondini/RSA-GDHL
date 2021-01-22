library verilog;
use verilog.vl_types.all;
entity DFC3_3B is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        RN              : in     vl_logic
    );
end DFC3_3B;
