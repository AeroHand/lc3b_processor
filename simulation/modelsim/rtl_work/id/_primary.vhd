library verilog;
use verilog.vl_types.all;
library work;
entity id is
    port(
        clk             : in     vl_logic;
        regfilemux_out  : in     vl_logic_vector(15 downto 0);
        instruction     : in     vl_logic_vector(15 downto 0);
        destb           : in     vl_logic_vector(2 downto 0);
        adjtrap_out     : out    vl_logic_vector(15 downto 0);
        adjmux_out      : out    vl_logic_vector(15 downto 0);
        alumux_out      : out    vl_logic_vector(15 downto 0);
        ctrl            : out    work.lc3b_types.lc3b_control_word;
        ctrlwb          : in     work.lc3b_types.lc3b_control_word;
        sr1_out         : out    vl_logic_vector(15 downto 0);
        sr2_out         : out    vl_logic_vector(15 downto 0)
    );
end id;
