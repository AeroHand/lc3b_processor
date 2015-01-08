library verilog;
use verilog.vl_types.all;
library work;
entity wb is
    port(
        ctrl            : in     work.lc3b_types.lc3b_control_word;
        mem_wb_mar_out  : in     vl_logic_vector(15 downto 0);
        mem_wdata       : in     vl_logic_vector(15 downto 0);
        mem_wb_alu_out  : in     vl_logic_vector(15 downto 0);
        mem_wb_mdr_out  : in     vl_logic_vector(15 downto 0);
        mem_wb_bradj_out: in     vl_logic_vector(15 downto 0);
        mem_wb_pc_out   : in     vl_logic_vector(15 downto 0);
        regfilemux_out  : out    vl_logic_vector(15 downto 0)
    );
end wb;
