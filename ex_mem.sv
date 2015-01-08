//top level entity for ex/mem flip flops

import lc3b_types::*;

module ex_mem
(
	//inputs/outputs here

	input clk,
	input load,
	
	input pc_mux_not_zero,

	input [3:0] id_ex_opcode_out,
	input [15:0] id_ex_trap_out,
	input [15:0] id_ex_sr1_out,
	input [15:0] id_ex_sr2real_out,
	input [2:0] id_ex_dest_out,
	input lc3b_control_word  id_ex_ctrl_out,
	input [15:0] id_ex_pc_out,

	input [15:0] ex_addpcadj_out,
	input [15:0] ex_alu_out,

	output logic [15:0] ex_mem_pc_out,
	output logic [3:0] ex_mem_opcode_out,
	output logic [15:0] ex_mem_trap_out,
	output logic [15:0] ex_mem_alu_out,
	output logic [15:0] ex_mem_sr1_out,
	output logic [15:0] ex_mem_sr2real_out,
	output logic [2:0] ex_mem_dest_out,
	output lc3b_control_word  ex_mem_ctrl_out,
	output logic [15:0] ex_mem_bradj_out
);

logic [42:0] ex_mem_ctrl_mux_out;
logic [2:0] ex_mem_dest_mux_out;

//internal signals here

//modules here

//make regfile outs negative edge triggered! and cc too

//neg vs. pos???????

flipflop_positive ex_mem_pc_ff
(
	.clk(clk),
	.load(load),
	.d(id_ex_pc_out),
	.q(ex_mem_pc_out)
);

flipflop_positive ex_mem_bradj_ff
(
	.clk(clk),
	.load(load),
	.d(ex_addpcadj_out),
	.q(ex_mem_bradj_out)
);

flipflop_positive #(.width(4)) ex_mem_opcode_ff
(
	.clk(clk),
	.load(load),
	.d(id_ex_opcode_out),
	.q(ex_mem_opcode_out)
);

flipflop_positive ex_mem_trap_ff
(
	.clk(clk),
	.load(load),
	.d(id_ex_trap_out),
	.q(ex_mem_trap_out)
);

flipflop_positive ex_mem_alu_ff
(
	.clk(clk),
	.load(load),
	.d(ex_alu_out),
	.q(ex_mem_alu_out)
);


flipflop_positive ex_mem_sr1_ff
(
	.clk(clk),
	.load(load),
	.d(id_ex_sr1_out),
	.q(ex_mem_sr1_out)
);

flipflop_positive ex_mem_sr2real_ff
(
	.clk(clk),
	.load(load),
	.d(id_ex_sr2real_out),
	.q(ex_mem_sr2real_out)
);

flipflop_positive #(.width(3)) ex_mem_dest_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_dest_mux_out),
	.q(ex_mem_dest_out)
);

flipflop_positive #(.width(43)) ex_mem_ctrl_ff
(
	.clk(clk),
	.load(load),
	.d(ex_mem_ctrl_mux_out),
	.q(ex_mem_ctrl_out)
);

mux2 #(.width(43)) ex_mem_ctrl_mux
(
	.sel(pc_mux_not_zero),
	.a(id_ex_ctrl_out),
	.b(43'b0000000000000000000000000000000000000000000),
	.f(ex_mem_ctrl_mux_out)
);

mux2 #(.width(3)) ex_mem_dest_mux
(
	.sel(pc_mux_not_zero),
	.a(id_ex_dest_out),
	.b(3'b000),
	.f(ex_mem_dest_mux_out)
);

endmodule : ex_mem