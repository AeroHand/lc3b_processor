import lc3b_types::*;

module victim_datapath
(
    input clk,

    /* control signals */

    input write,
	 input L1_dirty,
	 input in_get,
	 input lc3b_word mem_address,
	 input lc3b_memband mem_wdata,
	 input lc3b_memband pmem_rdata,
	 input pmem_write,
	 input lc3b_word load_address,
	 output lc3b_word pmem_address,
	 output lc3b_memband pmem_wdata,
	 output logic tag_match,
	 output logic tag_match_buffer_out,
	 output lc3b_memband mem_rdata,
	 output logic valid,
	 output logic valid_buffer_out,
	 output logic dirty,
	 output logic dirty_buffer_out
);

/* declare internal signals */

logic [2:0] tagcomp_out;
logic [1:0] lru_out;
logic [1:0] indexmux_out;
lc3b_memband data_out;
lc3b_memband data_buffer_out;
logic [11:0] tag0_out;
logic [11:0] tag1_out;
logic [11:0] tag2_out;
logic [11:0] tag3_out;
logic [11:0] tag_out;
logic [11:0] mem_tag;
logic [11:0] load_mem_tag;

assign pmem_wdata = data_out;

assign mem_tag = mem_address[15:4];

assign tag_match = tagcomp_out[2];

assign load_mem_tag = load_address[15:4];

mux2 #(.width(16)) pmem_address_mux
(
	 .sel(pmem_write),
	 .a(mem_address),
	 .b({tag_out, 4'b0000}),
	 .f(pmem_address)
);

outarray4 #(.width(12)) tag
(
    .clk(clk),
	 .write(write),
	 .index(indexmux_out),
	 .datain(mem_tag),
	 .dataout(tag_out),
	 .data0(tag0_out),
	 .data1(tag1_out),
	 .data2(tag2_out),
	 .data3(tag3_out)
);

array4 data
(
    .clk(clk),
	 .write(write),
	 .index(indexmux_out),
	 .datain(mem_wdata),
	 .dataout(data_out)
);

array4 #(.width(1)) validarr
(
    .clk(clk),
	 .write(write),
	 .index(indexmux_out),
	 .datain(1'b1),
	 .dataout(valid)
);

array4 #(.width(1)) dirtyarr
(
    .clk(clk),
	 .write(write),
	 .index(indexmux_out),
	 .datain(L1_dirty),
	 .dataout(dirty)
);

lru_stack lru_stack
(
    .clk(clk),
	 .write(write),
	 .index(indexmux_out),
	 .lru(lru_out)
);

mux2 #(.width(2)) indexmux
(
	 .sel(tagcomp_out[2]),
	 .a(lru_out),
	 .b(tagcomp_out[1:0]),
	 .f(indexmux_out)
);

mux2 #(.width(128)) mem_rdata_mux
(
	 .sel(in_get),
	 .a(data_buffer_out),
	 .b(pmem_rdata),
	 .f(mem_rdata)
);

tagcomp4 tagcomp4
(
	 .a(tag0_out),
	 .b(tag1_out),
	 .c(tag2_out),
	 .d(tag3_out),
	 .q(load_mem_tag),
	 .f(tagcomp_out)
);

flipflop_positive #(.width(128)) data_buffer
(
    .clk(clk),
    .load(write),
    .d(data_out),
    .q(data_buffer_out)
);

flipflop_positive #(.width(1)) tag_match_buffer
(
    .clk(clk),
    .load(write),
    .d(tag_match),
    .q(tag_match_buffer_out)
);

flipflop_positive #(.width(1)) valid_buffer
(
    .clk(clk),
    .load(write),
    .d(valid),
    .q(valid_buffer_out)
);

flipflop_positive #(.width(1)) dirty_buffer
(
    .clk(clk),
    .load(write),
    .d(dirty),
    .q(dirty_buffer_out)
);

endmodule : victim_datapath
