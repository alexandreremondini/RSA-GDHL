library verilog;
use verilog.vl_types.all;
entity ICDP is
    port(
        PAD             : in     vl_logic;
        Y               : out    vl_logic
    );
end ICDP;
