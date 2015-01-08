library verilog;
use verilog.vl_types.all;
library work;
entity ex is
    port(
        id_ex_pc_out    : in     vl_logic_vector(15 downto 0);
        id_ex_adj_out   : in     vl_logic_vector(15 downto 0);
        ctrl            : in     work.lc3b_types.lc3b_control_word;
        id_ex_sr1_out   : in     vl_logic_vector(15 downto 0);
        id_ex_sr2_out   : in     vl_logic_vector(15 downto 0);
        id_ex_sr2real_out: in     vl_logic_vector(15 downto 0);
        addpcadj_out    : out    vl_logic_vector(15 downto 0);
        alu_out         : out    vl_logic_vector(15 downto 0)
    );
end ex;
