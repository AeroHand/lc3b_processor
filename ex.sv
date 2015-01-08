//top level entity for execute stage

import lc3b_types::*;

module ex
(
	//inputs/outputs here
	
	input [15:0] id_ex_pc_out,
	input [15:0] id_ex_adj_out,
	input lc3b_control_word ctrl,
	input [15:0] id_ex_sr1_out,
	input[15:0] id_ex_sr2_out,
	input [15:0] id_ex_sr2real_out,

	output logic [15:0] addpcadj_out,
	output logic [15:0] alu_out
);

//internal signals here

//modules here

logic sr2mux_sel;
logic [15:0] sr2mux_out;

assign sr2mux_sel = (ctrl.alumux_sel[0] || ctrl.alumux_sel[1] || ctrl.alumux_sel[2]);

adder addpcadj
(
    .pc_val(id_ex_pc_out),
    .extended9_val(id_ex_adj_out),
    .br_address(addpcadj_out)
);

alu alu_unit
(
	.aluop(ctrl.aluop),
	.a(id_ex_sr1_out),
	.b(sr2mux_out),
	.f(alu_out)
);

mux2 #(.width(16)) sr2mux
(
	.sel(sr2mux_sel),
	.a(id_ex_sr2real_out),
	.b(id_ex_sr2_out),
	.f(sr2mux_out)
);

endmodule : ex