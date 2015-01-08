library verilog;
use verilog.vl_types.all;
entity cache_datapath_2 is
    port(
        clk             : in     vl_logic;
        write0          : in     vl_logic;
        write1          : in     vl_logic;
        wdirty0         : in     vl_logic;
        wdirty1         : in     vl_logic;
        dirty0_val      : in     vl_logic;
        dirty1_val      : in     vl_logic;
        inrw1           : in     vl_logic;
        inw1            : in     vl_logic;
        mem_byte_enable : in     vl_logic_vector(1 downto 0);
        mem_address     : in     vl_logic_vector(15 downto 0);
        pmem_rdata      : in     vl_logic_vector(127 downto 0);
        mem_wdata       : in     vl_logic_vector(127 downto 0);
        pmem_write      : in     vl_logic;
        pmem_address    : out    vl_logic_vector(15 downto 0);
        pmem_wdata      : out    vl_logic_vector(127 downto 0);
        lru_out         : out    vl_logic;
        tag_match       : out    vl_logic;
        mem_rdata       : out    vl_logic_vector(127 downto 0);
        valid           : out    vl_logic;
        dirty           : out    vl_logic;
        whichtag        : out    vl_logic
    );
end cache_datapath_2;
