library verilog;
use verilog.vl_types.all;
entity DLPQ1_3B is
    port(
        D               : in     vl_logic;
        GN              : in     vl_logic;
        Q               : out    vl_logic;
        SN              : in     vl_logic
    );
end DLPQ1_3B;
