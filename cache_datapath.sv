import lc3b_types::*;

module cache_datapath
(
    input clk,

    /* control signals */

    input write0,
	 input write1,
	 input wdirty0,
	 input wdirty1,
	 input dirty0_val,
	 input dirty1_val,
	 input inrw1,
	 input inw1,
	 input logic [1:0] mem_byte_enable,
	 input lc3b_word mem_address,
	 input lc3b_memband pmem_rdata,
	 input lc3b_word mem_wdata,
	 input pmem_write,
	 output lc3b_word pmem_address,
	 output lc3b_memband pmem_wdata,
	 output lru_out,
	 output tag_match,
	 output lc3b_word mem_rdata,
	 output valid,
	 output dirty,
	 output whichtag
	 
);

/* declare internal signals */

logic [1:0] tagcomp_out;
lc3b_memband data0_out;
lc3b_memband data1_out;
lc3b_memband datamux_out;
logic valid0_out;
logic valid1_out;
logic dirty0_out;
logic dirty1_out;
lc3b_c_tag tag0_out;
lc3b_c_tag tag1_out;
lc3b_c_tag mem_tag;
lc3b_c_index mem_index;
lc3b_c_offset mem_offset;
logic [8:0] tagmux_out;
lc3b_memband writemux_out;
lc3b_memband write_calc_out;




assign mem_tag = mem_address[15:7];
assign mem_index = mem_address[6:4];
assign mem_offset = mem_address[3:1];

assign tag_match = tagcomp_out[1];

assign whichtag = tagcomp_out[0];

mux2 #(.width(16)) pmem_address_mux
(
	 .sel(pmem_write),
	 .a(mem_address),
	 .b({tagmux_out, mem_index, 4'b0000}),
	 .f(pmem_address)
);

mux2 #(.width(9)) tagmux
(
    .sel(lru_out),
	 .a(tag0_out),
	 .b(tag1_out),
	 .f(tagmux_out)
);

mux2 #(.width(128)) datamux
(
    .sel(tagcomp_out[0]),
	 .a(data0_out),
	 .b(data1_out),
	 .f(datamux_out)
);

mux2 #(.width(128)) writedatamux
(
    .sel(lru_out),
	 .a(data0_out),
	 .b(data1_out),
	 .f(pmem_wdata)
);

mux2 #(.width(1)) validmux
(
    .sel(tagcomp_out[0]),
	 .a(valid0_out),
	 .b(valid1_out),
	 .f(valid)
);

mux2 #(.width(1)) dirtymux
(
    .sel(lru_out),
	 .a(dirty0_out),
	 .b(dirty1_out),
	 .f(dirty)
);

mux2 #(.width(128)) writemux
(
	 .sel(inw1),
	 .a(pmem_rdata),
	 .b(write_calc_out),
	 .f(writemux_out)
);

array #(.width(9)) tag0
(
    .clk(clk),
	 .write(write0),
	 .index(mem_index),
	 .datain(mem_tag),
	 .dataout(tag0_out)
);

array #(.width(9)) tag1
(
    .clk(clk),
	 .write(write1),
	 .index(mem_index),
	 .datain(mem_tag),
	 .dataout(tag1_out)
);

array data0
(
    .clk(clk),
	 .write(write0),
	 .index(mem_index),
	 .datain(writemux_out),
	 .dataout(data0_out)
);

array data1
(
    .clk(clk),
	 .write(write1),
	 .index(mem_index),
	 .datain(writemux_out),
	 .dataout(data1_out)
);

array #(.width(1)) valid0
(
    .clk(clk),
	 .write(write0),
	 .index(mem_index),
	 .datain(1'b1),
	 .dataout(valid0_out)
);

array #(.width(1)) valid1
(
    .clk(clk),
	 .write(write1),
	 .index(mem_index),
	 .datain(1'b1),
	 .dataout(valid1_out)
);

array #(.width(1)) dirty0
(
    .clk(clk),
	 .write(wdirty0),
	 .index(mem_index),
	 .datain(dirty0_val),
	 .dataout(dirty0_out)
);

array #(.width(1)) dirty1
(
    .clk(clk),
	 .write(wdirty1),
	 .index(mem_index),
	 .datain(dirty1_val),
	 .dataout(dirty1_out)
);

array #(.width(1)) lru
(
    .clk(clk),
	 .write(inrw1),
	 .index(mem_index),
	 .datain(!tagcomp_out[0]),
	 .dataout(lru_out)
);

tagcomp tagcomp
(
	 .a(tag0_out),
	 .b(tag1_out),
	 .q(mem_tag),
	 .f(tagcomp_out)
);

off_addr_calc off_addr_calc
(
    .sel(mem_offset),
	 .datain(datamux_out),
	 .dataout(mem_rdata)
);

write_calc write_calc
(
	 .sel(mem_offset),
	 .selbyte(mem_byte_enable),
	 .datain(datamux_out),
	 .newdata(mem_wdata),
	 .dataout(write_calc_out)
);

endmodule : cache_datapath
