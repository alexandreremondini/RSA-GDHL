library verilog;
use verilog.vl_types.all;
entity BBS8SMP is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : inout  vl_logic;
        Y               : out    vl_logic
    );
end BBS8SMP;
