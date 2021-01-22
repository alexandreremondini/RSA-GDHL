library verilog;
use verilog.vl_types.all;
entity BUF8 is
    port(
        A               : in     vl_logic;
        Q               : out    vl_logic
    );
end BUF8;
