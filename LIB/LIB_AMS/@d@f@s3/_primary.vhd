library verilog;
use verilog.vl_types.all;
entity DFS3 is
    port(
        C               : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        SD              : in     vl_logic;
        SE              : in     vl_logic
    );
end DFS3;
