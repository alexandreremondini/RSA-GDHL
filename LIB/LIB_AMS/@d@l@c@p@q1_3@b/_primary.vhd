library verilog;
use verilog.vl_types.all;
entity DLCPQ1_3B is
    port(
        D               : in     vl_logic;
        GN              : in     vl_logic;
        Q               : out    vl_logic;
        RN              : in     vl_logic;
        SN              : in     vl_logic
    );
end DLCPQ1_3B;
