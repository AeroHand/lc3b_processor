//top level entity for write back stage

import lc3b_types::*;

module wb
(
	//inputs/outputs here

	input lc3b_control_word ctrl,
	input [15:0] mem_wb_mar_out,
	input [15:0] mem_wdata,
	input [15:0] mem_wb_alu_out,
	input [15:0] mem_wb_mdr_out,
	input [15:0] mem_wb_bradj_out,
	input [15:0] mem_wb_pc_out,

	output logic [15:0] regfilemux_out
);

//internal signals here

logic [15:0] zext8_out;
logic [7:0] wdatamux_out;


//modules here

mux2 #(.width(8)) wdatamux
(
	.sel(mem_wb_mar_out[0]),
	.a(mem_wdata[7:0]),
	.b(mem_wdata[15:8]),
	.f(wdatamux_out)
);

mux8 #(.width(16)) regfilemux
(
	.sel(ctrl.regfilemux_sel),
	.a(mem_wb_alu_out),
	.b(mem_wb_mdr_out),
	.c(mem_wb_bradj_out),
	.d(mem_wb_pc_out),
	.e(zext8_out),
	.g(16'b0000000000000000),
	.h(16'b0000000000000000),
	.i(16'b0000000000000000),
	.f(regfilemux_out)
);

zext #(.width(8)) zext8
(
	.in(wdatamux_out),
	.out(zext8_out)
);

endmodule : wb