//top level entity for mp3 - contains if/id/ex/mem/wb/flip flops/connections between entities

import lc3b_types::*;

module mp3
(
	input clk,

	output logic [15:0] mem_address,
	output logic [127:0] mem_wdata,
	input [127:0] mem_rdata,
	
	output logic mem_read,
	output logic mem_write,
	
	input mem_resp
);

logic i_mem_resp;
logic i_mem_read;
logic i_mem_write;
logic [1:0] i_mem_byte_enable;
logic [15:0] i_mem_address;
logic [15:0] i_mem_rdata;
logic [15:0] i_mem_wdata;

logic d_mem_resp;
logic d_mem_read;
logic d_mem_write;
logic [1:0] d_mem_byte_enable;
logic [15:0] d_mem_address;
logic [15:0] d_mem_rdata;
logic [15:0] d_mem_wdata;

logic inst_mem_resp;
logic inst_mem_read;
logic inst_mem_write;
logic [15:0] inst_mem_address;
logic [127:0] inst_mem_wdata;

logic dat_mem_resp;
logic dat_mem_read;
logic dat_mem_write;
logic [15:0] dat_mem_address;
logic [127:0] dat_mem_wdata;

logic v_mem_resp;
logic v_mem_read;
logic v_mem_write;
logic [15:0] v_mem_address;
logic [127:0] v_mem_rdata;
logic [127:0] v_mem_wdata;
logic v_dirty;

logic L2_mem_resp;
logic L2_mem_read;
logic L2_mem_write;
logic [1:0] L2_mem_byte_enable;
logic [15:0] L2_mem_address;
logic [127:0] L2_mem_rdata;
logic [127:0] L2_mem_wdata;

logic [15:0] L2_mem_address_out;
logic [127:0] L2_mem_wdata_out;

logic dirty_back;
logic in_get;

assign L2_mem_byte_enable = 2'b11;


pipeline pipeline
(
	 .clk,
    .mem_resp(d_mem_resp),
    .mem_rdata(d_mem_rdata),
    .mem_read(d_mem_read),
    .mem_write(d_mem_write),
    .mem_byte_enable(d_mem_byte_enable),
    .mem_address(d_mem_address),
    .mem_wdata(d_mem_wdata),
	 .imem_read(i_mem_read),
    .imem_write(i_mem_write),
    .imem_byte_enable(i_mem_byte_enable),
    .imem_address(i_mem_address),
    .imem_wdata(i_mem_wdata),
    .imem_resp(i_mem_resp),
    .imem_rdata(i_mem_rdata)
);

cache inst_cache
(
	 .clk(clk),
    .pmem_address(inst_mem_address),
	 .pmem_rdata(L2_mem_rdata),
	 .pmem_wdata(inst_mem_wdata),
	 .mem_wdata(i_mem_wdata),
	 .mem_rdata(i_mem_rdata),
	 .mem_address(i_mem_address),
	 .mem_read(i_mem_read),
	 .mem_write(i_mem_write),
	 .mem_byte_enable(i_mem_byte_enable),
	 .mem_resp(i_mem_resp),
	 .pmem_read(inst_mem_read),
	 .pmem_write(inst_mem_write),
	 .pmem_resp(inst_mem_resp)
);

d_cache dat_cache
(
	 .clk(clk),
    .pmem_address(v_mem_address),
	 .pmem_rdata(v_mem_rdata),
	 .pmem_wdata(v_mem_wdata),
	 .mem_wdata(d_mem_wdata),
	 .mem_rdata(d_mem_rdata),
	 .mem_address(d_mem_address),
	 .mem_read(d_mem_read),
	 .mem_write(d_mem_write),
	 .mem_byte_enable(d_mem_byte_enable),
	 .mem_resp(d_mem_resp),
	 .pmem_read(v_mem_read),
	 .pmem_write(v_mem_write),
	 .pmem_resp(v_mem_resp),
	 .dirty_prev(v_dirty),
	 .dirty_back(dirty_back),
	 .in_get(in_get)
);

victim victim
(
	 .clk(clk),
    .pmem_address(dat_mem_address),
	 .pmem_rdata(L2_mem_rdata),
	 .pmem_wdata(dat_mem_wdata),
	 .mem_wdata(v_mem_wdata),
	 .mem_rdata(v_mem_rdata),
	 .mem_address(v_mem_address),
	 .mem_read(v_mem_read),
	 .mem_write(v_mem_write),
	 .mem_resp(v_mem_resp),
	 .pmem_read(dat_mem_read),
	 .pmem_write(dat_mem_write),
	 .pmem_resp(dat_mem_resp),
	 .load_address(d_mem_address),
	 .L1_dirty(v_dirty),
	 .dirty_buffer_out(dirty_back),
	 .write_dirty(in_get)
);

cache2 L2_cache
(
	 .clk(clk),
    .pmem_address(mem_address),
	 .pmem_rdata(mem_rdata),
	 .pmem_wdata(mem_wdata),
	 .mem_wdata(L2_mem_wdata_out),
	 .mem_rdata(L2_mem_rdata),
	 .mem_address(L2_mem_address_out),
	 .mem_read(L2_mem_read),
	 .mem_write(L2_mem_write),
	 .mem_byte_enable(L2_mem_byte_enable),
	 .mem_resp(L2_mem_resp),
	 .pmem_read(mem_read),
	 .pmem_write(mem_write),
	 .pmem_resp(mem_resp)
);

arbiter arbiter
(
	 .clk(clk),
	 .i_mem_read(inst_mem_read),
	 .d_mem_read(dat_mem_read),
	 .d_mem_write(dat_mem_write),
	 .mem_resp(L2_mem_resp),
	 .i_mem_resp(inst_mem_resp),
	 .d_mem_resp(dat_mem_resp),
	 .a_mem_read(L2_mem_read),
	 .a_mem_write(L2_mem_write)
);

mux2 #(.width(16)) mem_address_mux
(
	.sel(dat_mem_read || dat_mem_write),
	.a(inst_mem_address),
	.b(dat_mem_address),
	.f(L2_mem_address)
);

mux2 #(.width(128)) mem_wdata_mux
(
	.sel(dat_mem_read || dat_mem_write),
	.a(inst_mem_wdata),
	.b(dat_mem_wdata),
	.f(L2_mem_wdata)
);

flipflop_positive #(.width(128)) L2_wdata_buffer
(
    .clk(clk),
    .load(1'b1),
    .d(L2_mem_wdata),
    .q(L2_mem_wdata_out)
);

flipflop_positive #(.width(16)) L2_add_buffer
(
    .clk(clk),
    .load(1'b1),
    .d(L2_mem_address),
    .q(L2_mem_address_out)
);



endmodule : mp3
