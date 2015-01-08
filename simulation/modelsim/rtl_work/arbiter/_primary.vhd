library verilog;
use verilog.vl_types.all;
entity arbiter is
    port(
        clk             : in     vl_logic;
        i_mem_read      : in     vl_logic;
        d_mem_read      : in     vl_logic;
        d_mem_write     : in     vl_logic;
        mem_resp        : in     vl_logic;
        i_mem_resp      : out    vl_logic;
        d_mem_resp      : out    vl_logic;
        a_mem_read      : out    vl_logic;
        a_mem_write     : out    vl_logic
    );
end arbiter;
