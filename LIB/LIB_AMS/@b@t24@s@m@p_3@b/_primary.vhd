library verilog;
use verilog.vl_types.all;
entity BT24SMP_3B is
    port(
        A               : in     vl_logic;
        EN              : in     vl_logic;
        PAD             : out    vl_logic
    );
end BT24SMP_3B;
