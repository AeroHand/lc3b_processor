library verilog;
use verilog.vl_types.all;
entity if_id is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        if_plus2_out    : in     vl_logic_vector(15 downto 0);
        imem_rdata      : in     vl_logic_vector(15 downto 0);
        if_id_pc_out    : out    vl_logic_vector(15 downto 0);
        if_id_instr_out : out    vl_logic_vector(15 downto 0)
    );
end if_id;
