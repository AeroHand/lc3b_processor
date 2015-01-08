library verilog;
use verilog.vl_types.all;
entity mp3 is
    port(
        clk             : in     vl_logic;
        mem_address     : out    vl_logic_vector(15 downto 0);
        mem_wdata       : out    vl_logic_vector(127 downto 0);
        mem_rdata       : in     vl_logic_vector(127 downto 0);
        mem_read        : out    vl_logic;
        mem_write       : out    vl_logic;
        mem_resp        : in     vl_logic
    );
end mp3;
