library verilog;
use verilog.vl_types.all;
entity DLP1_3B is
    port(
        D               : in     vl_logic;
        GN              : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SN              : in     vl_logic
    );
end DLP1_3B;
