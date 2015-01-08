//top level entity for instruction fetch stage

import lc3b_types::*;

module ifetch
(
	input clk,
	
	input branch,

	input lc3b_control_word ctrl,
	input [15:0] if_id_pc_out,
	input [15:0] ex_mem_pc_out,
	input [15:0] id_ex_sr1_out,
	input [15:0] ex_mem_bradj_out,
	input [15:0] mem_wb_mdr_out,
	
	output logic [15:0] pcmux_out,

	output logic [15:0] pcplus2_out
);

logic [15:0] branchmux_out;


mux2 #(.width(16)) branchmux
(
	.sel(branch),
	.a(if_id_pc_out),
	.b(ex_mem_bradj_out),
	.f(branchmux_out)
);

mux8 #(.width(16)) pcmux
(
	.sel(ctrl.pcmux_sel),
	.a(branchmux_out),
	.b(branchmux_out),
	.c(id_ex_sr1_out),
	.d(ex_mem_bradj_out),
	.e(mem_wb_mdr_out),
	.g(16'b0000000000000000),
	.h(16'b0000000000000000),
	.i(16'b0000000000000000),
	.f(pcmux_out)
);


plus2 plus2_unit
(
	.in(pcmux_out),
	.out(pcplus2_out)
);

endmodule : ifetch