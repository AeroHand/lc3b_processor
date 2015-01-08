library verilog;
use verilog.vl_types.all;
library work;
entity ex_mem is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        pc_mux_not_zero : in     vl_logic;
        id_ex_opcode_out: in     vl_logic_vector(3 downto 0);
        id_ex_trap_out  : in     vl_logic_vector(15 downto 0);
        id_ex_sr1_out   : in     vl_logic_vector(15 downto 0);
        id_ex_sr2real_out: in     vl_logic_vector(15 downto 0);
        id_ex_dest_out  : in     vl_logic_vector(2 downto 0);
        id_ex_ctrl_out  : in     work.lc3b_types.lc3b_control_word;
        id_ex_pc_out    : in     vl_logic_vector(15 downto 0);
        ex_addpcadj_out : in     vl_logic_vector(15 downto 0);
        ex_alu_out      : in     vl_logic_vector(15 downto 0);
        ex_mem_pc_out   : out    vl_logic_vector(15 downto 0);
        ex_mem_opcode_out: out    vl_logic_vector(3 downto 0);
        ex_mem_trap_out : out    vl_logic_vector(15 downto 0);
        ex_mem_alu_out  : out    vl_logic_vector(15 downto 0);
        ex_mem_sr1_out  : out    vl_logic_vector(15 downto 0);
        ex_mem_sr2real_out: out    vl_logic_vector(15 downto 0);
        ex_mem_dest_out : out    vl_logic_vector(2 downto 0);
        ex_mem_ctrl_out : out    work.lc3b_types.lc3b_control_word;
        ex_mem_bradj_out: out    vl_logic_vector(15 downto 0)
    );
end ex_mem;
