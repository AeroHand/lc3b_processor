//top level entity for ex/mem flip flops

import lc3b_types::*;

module mem_wb
(
	//inputs/outputs here

	input clk,
	input load,

	input [15:0] ex_mem_pc_out,
	input [3:0] ex_mem_opcode_out,
	input [15:0] mem_marmux_out,
	input [15:0] mem_mdrmux_out,
	input [15:0] ex_mem_alu_out,
	input lc3b_control_word  ex_mem_ctrl_out,
	input [15:0] ex_mem_bradj_out,
	input [2:0] ex_mem_dest_out,

	output logic [15:0] mem_wb_pc_out,
	output logic [3:0] mem_wb_opcode_out,
	output logic [15:0] mem_wb_mar_out,
	output logic [15:0] mem_wb_mdr_out,
	output logic [15:0] mem_wb_alu_out,
	output lc3b_control_word  mem_wb_ctrl_out,
	output logic [2:0] mem_wb_dest_out,
	output logic [15:0] mem_wb_bradj_out
);

//internal signals here

//modules here

//make regfile outs negative edge triggered! and cc too

//neg vs. pos???????

flipflop_positive mem_wb_pc_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_pc_out),
	.q(mem_wb_pc_out)
);

flipflop_positive mem_wb_bradj_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_bradj_out),
	.q(mem_wb_bradj_out)
);

flipflop_positive #(.width(4)) mem_wb_opcode_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_opcode_out),
	.q(mem_wb_opcode_out)
);

flipflop_positive mem_wb_mar_ff
(
	.clk(clk),
	.load(load),
	.d(mem_marmux_out),
	.q(mem_wb_mar_out)
);

flipflop_positive mem_wb_mdr_ff
(
	.clk(clk),
	.load(load),
	.d(mem_mdrmux_out),
	.q(mem_wb_mdr_out)
);

flipflop_positive mem_wb_alu_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_alu_out),
	.q(mem_wb_alu_out)
);

flipflop_positive #(.width(43)) mem_wb_ctrl_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_ctrl_out),
	.q(mem_wb_ctrl_out)
);

flipflop_positive #(.width(3)) mem_wb_dest_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_dest_out),
	.q(mem_wb_dest_out)
);

endmodule : mem_wb