import lc3b_types::*;

module victim
(
    input clk,
    output lc3b_word pmem_address,
	 input lc3b_memband pmem_rdata,
	 output lc3b_memband pmem_wdata,
	 input lc3b_memband mem_wdata,
	 output lc3b_memband mem_rdata,
	 input lc3b_word mem_address,
	 input mem_read,
	 input mem_write,
	 output mem_resp,
	 output pmem_read,
	 output pmem_write,
	 input pmem_resp,
	 input lc3b_word load_address,
	 input L1_dirty,
	 output logic dirty_buffer_out,
	 output logic write_dirty
);

logic write;
logic tag_match;
logic valid;
logic tag_match_buffer_out;
logic valid_buffer_out;
logic in_get;
logic dirty;

/* Instantiate MP 0 top level blocks here */

victim_datapath victim_datapath
(
    .clk(clk),
	 .write(write),
	 .L1_dirty(L1_dirty),
	 .in_get(in_get),
	 .mem_address(mem_address),
	 .load_address(load_address),
	 .pmem_rdata(pmem_rdata),
	 .mem_wdata(mem_wdata),
	 .pmem_write(pmem_write),
	 .pmem_address(pmem_address),
	 .pmem_wdata(pmem_wdata),
	 .tag_match(tag_match),
	 .tag_match_buffer_out(tag_match_buffer_out),
	 .mem_rdata(mem_rdata),
	 .valid(valid),
	 .valid_buffer_out(valid_buffer_out),
	 .dirty(dirty),
	 .dirty_buffer_out(dirty_buffer_out)
);

victim_control victim_control
(
    .clk(clk),
	 .mem_read(mem_read),
	 .mem_write(mem_write),
	 .tag_match(tag_match),
	 .tag_match_buffer_out(tag_match_buffer_out),
	 .valid(valid),
	 .valid_buffer_out(valid_buffer_out),
	 .dirty(dirty),
	 .write(write),
	 .mem_resp(mem_resp),
	 .in_get(in_get),
	 .write_dirty(write_dirty),
	 .pmem_resp(pmem_resp),
    .pmem_read(pmem_read),
    .pmem_write(pmem_write)
);

endmodule : victim
