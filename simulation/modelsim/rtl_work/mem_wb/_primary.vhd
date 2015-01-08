library verilog;
use verilog.vl_types.all;
library work;
entity mem_wb is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        ex_mem_pc_out   : in     vl_logic_vector(15 downto 0);
        ex_mem_opcode_out: in     vl_logic_vector(3 downto 0);
        mem_marmux_out  : in     vl_logic_vector(15 downto 0);
        mem_mdrmux_out  : in     vl_logic_vector(15 downto 0);
        ex_mem_alu_out  : in     vl_logic_vector(15 downto 0);
        ex_mem_ctrl_out : in     work.lc3b_types.lc3b_control_word;
        ex_mem_bradj_out: in     vl_logic_vector(15 downto 0);
        ex_mem_dest_out : in     vl_logic_vector(2 downto 0);
        mem_wb_pc_out   : out    vl_logic_vector(15 downto 0);
        mem_wb_opcode_out: out    vl_logic_vector(3 downto 0);
        mem_wb_mar_out  : out    vl_logic_vector(15 downto 0);
        mem_wb_mdr_out  : out    vl_logic_vector(15 downto 0);
        mem_wb_alu_out  : out    vl_logic_vector(15 downto 0);
        mem_wb_ctrl_out : out    work.lc3b_types.lc3b_control_word;
        mem_wb_dest_out : out    vl_logic_vector(2 downto 0);
        mem_wb_bradj_out: out    vl_logic_vector(15 downto 0)
    );
end mem_wb;
