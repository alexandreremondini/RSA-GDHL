library verilog;
use verilog.vl_types.all;
entity MAJ32 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        Q               : out    vl_logic
    );
end MAJ32;
