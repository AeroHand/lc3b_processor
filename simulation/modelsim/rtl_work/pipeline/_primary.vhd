library verilog;
use verilog.vl_types.all;
entity pipeline is
    port(
        clk             : in     vl_logic;
        mem_address     : out    vl_logic_vector(15 downto 0);
        mem_wdata       : out    vl_logic_vector(15 downto 0);
        mem_rdata       : in     vl_logic_vector(15 downto 0);
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_byte_enable : out    vl_logic_vector(1 downto 0);
        mem_resp        : in     vl_logic;
        imem_address    : out    vl_logic_vector(15 downto 0);
        imem_wdata      : out    vl_logic_vector(15 downto 0);
        imem_rdata      : in     vl_logic_vector(15 downto 0);
        imem_read       : out    vl_logic;
        imem_write      : out    vl_logic;
        imem_byte_enable: out    vl_logic_vector(1 downto 0);
        imem_resp       : in     vl_logic
    );
end pipeline;
