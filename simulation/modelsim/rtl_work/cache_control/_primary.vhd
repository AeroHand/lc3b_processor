library verilog;
use verilog.vl_types.all;
entity cache_control is
    port(
        clk             : in     vl_logic;
        lru_out         : in     vl_logic;
        mem_read        : in     vl_logic;
        mem_write       : in     vl_logic;
        tag_match       : in     vl_logic;
        valid           : in     vl_logic;
        dirty           : in     vl_logic;
        whichtag        : in     vl_logic;
        write0          : out    vl_logic;
        write1          : out    vl_logic;
        wdirty0         : out    vl_logic;
        wdirty1         : out    vl_logic;
        dirty0_val      : out    vl_logic;
        dirty1_val      : out    vl_logic;
        mem_resp        : out    vl_logic;
        inrw1           : out    vl_logic;
        inw1            : out    vl_logic;
        pmem_resp       : in     vl_logic;
        pmem_read       : out    vl_logic;
        pmem_write      : out    vl_logic
    );
end cache_control;
