library verilog;
use verilog.vl_types.all;
entity DLCQ3_3B is
    port(
        D               : in     vl_logic;
        GN              : in     vl_logic;
        Q               : out    vl_logic;
        RN              : in     vl_logic
    );
end DLCQ3_3B;
