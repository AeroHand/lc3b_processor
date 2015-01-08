import lc3b_types::*;

module d_cache
(
    input clk,
    output lc3b_word pmem_address,
	 input lc3b_memband pmem_rdata,
	 output lc3b_memband pmem_wdata,
	 input lc3b_word mem_wdata,
	 output lc3b_word mem_rdata,
	 input lc3b_word mem_address,
	 input mem_read,
	 input mem_write,
	 input lc3b_mem_wmask mem_byte_enable,
	 output mem_resp,
	 output pmem_read,
	 output pmem_write,
	 input pmem_resp,
	 output logic dirty_prev,
	 input dirty_back,
	 input in_get
);

logic write0;
logic write1;
logic wdirty0;
logic wdirty1;
logic dirty0_val;
logic dirty1_val;
logic lru_out;
logic tag_match;
logic inrw1;
logic inw1;
logic valid;
logic whichtag;
logic load_buf;
logic dirty;

/* Instantiate MP 0 top level blocks here */

d_cache_datapath d_cache_datapath
(
    .clk(clk),
	 .write0(write0),
	 .write1(write1),
	 .wdirty0(wdirty0),
	 .wdirty1(wdirty1),
	 .dirty0_val(dirty0_val),
	 .dirty1_val(dirty1_val),
	 .inrw1(inrw1),
	 .inw1(inw1),
	 .mem_byte_enable(mem_byte_enable),
	 .mem_address(mem_address),
	 .pmem_rdata(pmem_rdata),
	 .mem_wdata(mem_wdata),
	 .pmem_write(pmem_write),
	 .pmem_address(pmem_address),
	 .pmem_wdata(pmem_wdata),
	 .lru_out(lru_out),
	 .tag_match(tag_match),
	 .mem_rdata(mem_rdata),
	 .valid(valid),
	 .dirty(dirty),
	 .whichtag(whichtag),
	 .dirty_prev(dirty_prev),
	 .dirty_back(dirty_back),
	 .in_get(in_get),
	 .load_buf(load_buf)
);

d_cache_control d_cache_control
(
    .clk(clk),
	 .lru_out(lru_out),
	 .mem_read(mem_read),
	 .mem_write(mem_write),
	 .tag_match(tag_match),
	 .valid(valid),
	 .dirty(dirty),
	 .whichtag(whichtag),
	 .write0(write0),
	 .write1(write1),
	 .wdirty0(wdirty0),
	 .wdirty1(wdirty1),
	 .dirty0_val(dirty0_val),
	 .dirty1_val(dirty1_val),
	 .mem_resp(mem_resp),
	 .inrw1(inrw1),
	 .inw1(inw1),
	 .load_buf(load_buf),
	 .pmem_resp(pmem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write)
);

endmodule : d_cache
