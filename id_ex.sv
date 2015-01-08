//top level entity for id/ex flip flops

import lc3b_types::*;

module id_ex
(
	//inputs/outputs here

	input clk,
	input load,

	input pc_mux_not_zero,
	
	input [15:0] if_id_pc_out,
	input [3:0] if_id_opcode_out,

	input [15:0] id_adjmux_out,
	input [15:0] id_trap_out,
	input [15:0] id_sr1_out,
	input [15:0] id_sr2_out,
	input [15:0] id_sr2real_out,
	input [2:0] id_dest_out,
	input lc3b_control_word  id_ctrl_out,
	
	input [2:0] id_sr1_num_out,
	input [2:0] id_sr2_num_out,
	
	output logic [2:0] id_ex_sr1_num_out,
	output logic [2:0] id_ex_sr2_num_out,

	output logic [15:0] id_ex_pc_out,
	output logic [3:0] id_ex_opcode_out,
	output logic [15:0] id_ex_adj_out,
	output logic [15:0] id_ex_trap_out,
	output logic [15:0] id_ex_sr1_out,
	output logic [15:0] id_ex_sr2_out,
	output logic [15:0] id_ex_sr2real_out,
	output logic [2:0] id_ex_dest_out,
	output lc3b_control_word  id_ex_ctrl_out
);

logic [43:0] id_ex_ctrl_mux_out;
logic [2:0] id_ex_dest_mux_out;

//internal signals here

//modules here

//make regfile outs negative edge triggered! and cc too

//neg vs. pos???????

flipflop_positive id_ex_pc_ff
(
	.clk(clk),
	.load(load),
	.d(if_id_pc_out),
	.q(id_ex_pc_out)
);

flipflop_positive #(.width(4)) id_ex_opcode_ff
(
	.clk(clk),
	.load(load),
	.d(if_id_opcode_out),
	.q(id_ex_opcode_out)
);

flipflop_positive id_ex_adj_ff
(
	.clk(clk),
	.load(load),
	.d(id_adjmux_out),
	.q(id_ex_adj_out)
);

flipflop_positive id_ex_trap_ff
(
	.clk(clk),
	.load(load),
	.d(id_trap_out),
	.q(id_ex_trap_out)
);

flipflop_positive id_ex_sr1_ff
(
	.clk(clk),
	.load(load),
	.d(id_sr1_out),
	.q(id_ex_sr1_out)
);


flipflop_positive id_ex_sr2_ff
(
	.clk(clk),
	.load(load),
	.d(id_sr2_out),
	.q(id_ex_sr2_out)
);

flipflop_positive id_ex_sr2real_ff
(
	.clk(clk),
	.load(load),
	.d(id_sr2real_out),
	.q(id_ex_sr2real_out)
);

flipflop_positive #(.width(3)) id_ex_dest_ff
(
	.clk(clk),
	.load(load),
	.d(id_ex_dest_mux_out),
	.q(id_ex_dest_out)
);

flipflop_positive #(.width(3)) id_ex_sr1_num_ff
(
	.clk(clk),
	.load(load),
	.d(id_sr1_num_out),
	.q(id_ex_sr1_num_out)
);

flipflop_positive #(.width(3)) id_ex_sr2_num_ff
(
	.clk(clk),
	.load(load),
	.d(id_sr2_num_out),
	.q(id_ex_sr2_num_out)
);

flipflop_positive #(.width(44)) id_ex_ctrl_ff
(
	.clk(clk),
	.load(load),
	.d(id_ex_ctrl_mux_out),
	.q(id_ex_ctrl_out)
);

mux2 #(.width(44)) id_ex_ctrl_mux
(
	.sel(pc_mux_not_zero),
	.a(id_ctrl_out),
	.b(44'b00000000000000000000000000000000000000000000),
	.f(id_ex_ctrl_mux_out)
);

mux2 #(.width(3)) id_ex_dest_mux
(
	.sel(pc_mux_not_zero),
	.a(id_dest_out),
	.b(3'b000),
	.f(id_ex_dest_mux_out)
);


endmodule : id_ex