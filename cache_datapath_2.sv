import lc3b_types::*;

module cache_datapath_2
(
    input clk,

    /* control signals */

    input write0,
	 input write1,
	 input write2,
	 input write3,
	 input wdirty0,
	 input wdirty1,
	 input wdirty2,
	 input wdirty3,
	 input dirty0_val,
	 input dirty1_val,
	 input dirty2_val,
	 input dirty3_val,
	 input inrw1,
	 input inw1,
	 input logic [1:0] mem_byte_enable,
	 input lc3b_word mem_address,
	 input lc3b_memband pmem_rdata,
	 input lc3b_memband mem_wdata,
	 input pmem_write,
	 output lc3b_word pmem_address,
	 output lc3b_memband pmem_wdata,
	 output logic [1:0] lru_out,
	 output logic tag_match,
	 output lc3b_memband mem_rdata,
	 output logic valid,
	 output logic dirty,
	 output logic [1:0] whichtag
	 
);

/* declare internal signals */

logic [2:0] tagcomp_out;
lc3b_memband data0_out;
lc3b_memband data1_out;
lc3b_memband data2_out;
lc3b_memband data3_out;
logic valid0_out;
logic valid1_out;
logic valid2_out;
logic valid3_out;
logic dirty0_out;
logic dirty1_out;
logic dirty2_out;
logic dirty3_out;
lc3b_c_tag tag0_out;
lc3b_c_tag tag1_out;
lc3b_c_tag tag2_out;
lc3b_c_tag tag3_out;
lc3b_c_tag mem_tag;
lc3b_c_index mem_index;
logic [8:0] tagmux_out;
lc3b_memband writemux_out;
lc3b_memband write_calc_out;
logic [1:0] lru_out0;
logic [1:0] lru_out1;
logic [1:0] lru_out2;
logic [1:0] lru_out3;
logic [1:0] lru_out4;
logic [1:0] lru_out5;
logic [1:0] lru_out6;
logic [1:0] lru_out7;




assign mem_tag = mem_address[15:7];
assign mem_index = mem_address[6:4];

assign tag_match = tagcomp_out[2];

assign whichtag = tagcomp_out[1:0];

mux2 #(.width(16)) pmem_address_mux
(
	 .sel(pmem_write),
	 .a(mem_address),
	 .b({tagmux_out, mem_index, 4'b0000}),
	 .f(pmem_address)
);

mux4 #(.width(9)) tagmux
(
    .sel(lru_out),
	 .a(tag0_out),
	 .b(tag1_out),
	 .c(tag2_out),
	 .d(tag3_out),
	 .f(tagmux_out)
);

mux4 #(.width(128)) datamux
(
    .sel(tagcomp_out[1:0]),
	 .a(data0_out),
	 .b(data1_out),
	 .c(data2_out),
	 .d(data3_out),
	 .f(mem_rdata)
);

mux4 #(.width(128)) writedatamux
(
    .sel(lru_out),
	 .a(data0_out),
	 .b(data1_out),
	 .c(data2_out),
	 .d(data3_out),
	 .f(pmem_wdata)
);

mux4 #(.width(1)) validmux
(
    .sel(tagcomp_out[1:0]),
	 .a(valid0_out),
	 .b(valid1_out),
	 .c(valid2_out),
	 .d(valid3_out),
	 .f(valid)
);

mux4 #(.width(1)) dirtymux
(
    .sel(lru_out),
	 .a(dirty0_out),
	 .b(dirty1_out),
	 .c(dirty2_out),
	 .d(dirty3_out),
	 .f(dirty)
);

mux2 #(.width(128)) writemux
(
	 .sel(inw1),
	 .a(pmem_rdata),
	 .b(mem_wdata),
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

array #(.width(9)) tag2
(
    .clk(clk),
	 .write(write2),
	 .index(mem_index),
	 .datain(mem_tag),
	 .dataout(tag2_out)
);

array #(.width(9)) tag3
(
    .clk(clk),
	 .write(write3),
	 .index(mem_index),
	 .datain(mem_tag),
	 .dataout(tag3_out)
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

array data2
(
    .clk(clk),
	 .write(write2),
	 .index(mem_index),
	 .datain(writemux_out),
	 .dataout(data2_out)
);

array data3
(
    .clk(clk),
	 .write(write3),
	 .index(mem_index),
	 .datain(writemux_out),
	 .dataout(data3_out)
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

array #(.width(1)) valid2
(
    .clk(clk),
	 .write(write2),
	 .index(mem_index),
	 .datain(1'b1),
	 .dataout(valid2_out)
);

array #(.width(1)) valid3
(
    .clk(clk),
	 .write(write3),
	 .index(mem_index),
	 .datain(1'b1),
	 .dataout(valid3_out)
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

array #(.width(1)) dirty2
(
    .clk(clk),
	 .write(wdirty2),
	 .index(mem_index),
	 .datain(dirty2_val),
	 .dataout(dirty2_out)
);

array #(.width(1)) dirty3
(
    .clk(clk),
	 .write(wdirty3),
	 .index(mem_index),
	 .datain(dirty3_val),
	 .dataout(dirty3_out)
);

lru_stack lru_stack0
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b000)),
	 .index(lru_out0),
	 .lru(lru_out0)
);

lru_stack lru_stack1
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b001)),
	 .index(lru_out1),
	 .lru(lru_out1)
);

lru_stack lru_stack2
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b010)),
	 .index(lru_out2),
	 .lru(lru_out2)
);

lru_stack lru_stack3
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b011)),
	 .index(lru_out3),
	 .lru(lru_out3)
);

lru_stack lru_stack4
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b100)),
	 .index(lru_out4),
	 .lru(lru_out4)
);

lru_stack lru_stack5
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b101)),
	 .index(lru_out5),
	 .lru(lru_out5)
);

lru_stack lru_stack6
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b110)),
	 .index(lru_out6),
	 .lru(lru_out6)
);

lru_stack lru_stack7
(
    .clk(clk),
	 .write(inrw1 && (mem_index == 3'b111)),
	 .index(lru_out7),
	 .lru(lru_out7)
);

mux8 #(.width(2)) lrumux
(
	 .sel(mem_index),
	 .a(lru_out0),
	 .b(lru_out1),
	 .c(lru_out2),
	 .d(lru_out3),
	 .e(lru_out4),
	 .g(lru_out5),
	 .h(lru_out6),
	 .i(lru_out7),
	 .f(lru_out)
);

tagcomp4other tagcomp4other
(
	 .a(tag0_out),
	 .b(tag1_out),
	 .c(tag2_out),
	 .d(tag3_out),
	 .q(mem_tag),
	 .f(tagcomp_out)
);


endmodule : cache_datapath_2
