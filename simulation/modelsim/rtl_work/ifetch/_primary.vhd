library verilog;
use verilog.vl_types.all;
library work;
entity ifetch is
    port(
        clk             : in     vl_logic;
        branch          : in     vl_logic;
        ctrl            : in     work.lc3b_types.lc3b_control_word;
        if_id_pc_out    : in     vl_logic_vector(15 downto 0);
        ex_mem_pc_out   : in     vl_logic_vector(15 downto 0);
        id_ex_sr1_out   : in     vl_logic_vector(15 downto 0);
        ex_mem_bradj_out: in     vl_logic_vector(15 downto 0);
        mem_wb_mdr_out  : in     vl_logic_vector(15 downto 0);
        pcmux_out       : out    vl_logic_vector(15 downto 0);
        pcplus2_out     : out    vl_logic_vector(15 downto 0)
    );
end ifetch;
