library verilog;
use verilog.vl_types.all;
entity forward_unit is
    port(
        ex_mem_regwrite : in     vl_logic;
        id_ex_sr1       : in     vl_logic_vector(2 downto 0);
        id_ex_sr2       : in     vl_logic_vector(2 downto 0);
        id_ex_dr        : in     vl_logic_vector(2 downto 0);
        ex_mem_dr       : in     vl_logic_vector(2 downto 0);
        id_ex_in_st     : in     vl_logic;
        ex_mem_in_ld    : in     vl_logic;
        ex_mem_set_r7   : in     vl_logic;
        ex_mem_in_lea   : in     vl_logic;
        mem_wb_regwrite : in     vl_logic;
        mem_wb_dr       : in     vl_logic_vector(2 downto 0);
        forward1        : out    vl_logic_vector(2 downto 0);
        forward2        : out    vl_logic_vector(2 downto 0)
    );
end forward_unit;
