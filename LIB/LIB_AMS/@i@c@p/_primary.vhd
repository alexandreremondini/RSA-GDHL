library verilog;
use verilog.vl_types.all;
entity ICP is
    port(
        PAD             : in     vl_logic;
        Y               : out    vl_logic
    );
end ICP;
