library verilog;
use verilog.vl_types.all;
library work;
entity control_rom is
    port(
        opcode          : in     vl_logic_vector(3 downto 0);
        useimm5         : in     vl_logic;
        useJSR          : in     vl_logic;
        shf_D           : in     vl_logic;
        ctrl            : out    work.lc3b_types.lc3b_control_word
    );
end control_rom;
