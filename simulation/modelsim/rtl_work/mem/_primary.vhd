library verilog;
use verilog.vl_types.all;
library work;
entity mem is
    port(
        clk             : in     vl_logic;
        load_cc         : in     vl_logic;
        ctrl            : in     work.lc3b_types.lc3b_control_word;
        ex_mem_alu_out  : in     vl_logic_vector(15 downto 0);
        ex_mem_pc_out   : in     vl_logic_vector(15 downto 0);
        ex_mem_trap_out : in     vl_logic_vector(15 downto 0);
        mem_rdata       : in     vl_logic_vector(15 downto 0);
        ex_mem_sr2real_out: in     vl_logic_vector(15 downto 0);
        wb_regfilemux_out: in     vl_logic_vector(15 downto 0);
        mem_wb_dest_out : in     vl_logic_vector(2 downto 0);
        mem_resp        : in     vl_logic;
        marmux_out      : out    vl_logic_vector(15 downto 0);
        mdrmux_out      : out    vl_logic_vector(15 downto 0);
        branch_enable   : out    vl_logic;
        indirect_reg_out: out    vl_logic
    );
end mem;
