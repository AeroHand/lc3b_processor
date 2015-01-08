library verilog;
use verilog.vl_types.all;
library work;
entity id_ex is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        pc_mux_not_zero : in     vl_logic;
        if_id_pc_out    : in     vl_logic_vector(15 downto 0);
        if_id_opcode_out: in     vl_logic_vector(3 downto 0);
        id_adjmux_out   : in     vl_logic_vector(15 downto 0);
        id_trap_out     : in     vl_logic_vector(15 downto 0);
        id_sr1_out      : in     vl_logic_vector(15 downto 0);
        id_sr2_out      : in     vl_logic_vector(15 downto 0);
        id_sr2real_out  : in     vl_logic_vector(15 downto 0);
        id_dest_out     : in     vl_logic_vector(2 downto 0);
        id_ctrl_out     : in     work.lc3b_types.lc3b_control_word;
        id_sr1_num_out  : in     vl_logic_vector(2 downto 0);
        id_sr2_num_out  : in     vl_logic_vector(2 downto 0);
        id_ex_sr1_num_out: out    vl_logic_vector(2 downto 0);
        id_ex_sr2_num_out: out    vl_logic_vector(2 downto 0);
        id_ex_pc_out    : out    vl_logic_vector(15 downto 0);
        id_ex_opcode_out: out    vl_logic_vector(3 downto 0);
        id_ex_adj_out   : out    vl_logic_vector(15 downto 0);
        id_ex_trap_out  : out    vl_logic_vector(15 downto 0);
        id_ex_sr1_out   : out    vl_logic_vector(15 downto 0);
        id_ex_sr2_out   : out    vl_logic_vector(15 downto 0);
        id_ex_sr2real_out: out    vl_logic_vector(15 downto 0);
        id_ex_dest_out  : out    vl_logic_vector(2 downto 0);
        id_ex_ctrl_out  : out    work.lc3b_types.lc3b_control_word
    );
end id_ex;
