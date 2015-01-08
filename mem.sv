//top level entity for memory stage

import lc3b_types::*;

module mem
(
	input clk,
	input load_cc,
	input lc3b_control_word ctrl,
	input [15:0] ex_mem_alu_out,
	input [15:0] ex_mem_pc_out,
	input [15:0] ex_mem_trap_out,
	input [15:0] mem_rdata,
	input [15:0] ex_mem_sr2real_out,
	input [15:0] wb_regfilemux_out,
	input [2:0] mem_wb_dest_out,
	input mem_resp,

	output logic [15:0] marmux_out,
	output logic [15:0] mdrmux_out,
	output logic branch_enable,
	output logic indirect_reg_out
);

logic [2:0] gencc_out;
logic [2:0] mem_cc_out;

logic [15:0] marmux_ind_out;
logic [15:0] mdrmux_ind_out;

logic [15:0] indirect_mdr_out;

logic [15:0] ex_mem_sr2concat_out;


logic mdrmux_ind_sel;

assign mdrmux_ind_sel = (indirect_reg_out && ctrl.in_sti);

mux2 #(.width(16)) marmux_ind
(
	.sel(indirect_reg_out),
	.a(ex_mem_alu_out),
	.b(indirect_mdr_out),
	.f(marmux_ind_out)
);

mux2 #(.width(16)) mdrmux_ind
(
	.sel(mdrmux_ind_sel),
	.a(mem_rdata),
	.b(ex_mem_sr2real_out),
	.f(mdrmux_ind_out)
);

mux4 #(.width(16)) marmux
(
	.sel(ctrl.marmux_sel),
	.a(marmux_ind_out),
	.b(ex_mem_pc_out),
	.c(indirect_mdr_out),
	.d(ex_mem_trap_out),
	.f(marmux_out)
);

mux4 #(.width(16)) mdrmux
(
	.sel(ctrl.mdrmux_sel),
	.a(ex_mem_alu_out),
	.b(mdrmux_ind_out),
	.c(ex_mem_sr2concat_out),
	.d(ex_mem_sr2real_out),
	.f(mdrmux_out)
);

gencc gencc_unit
(
	.in(wb_regfilemux_out),
	.out(gencc_out)
);

cc_negative cc_reg
(
	.clk(clk),
	.load(load_cc),
	.d(gencc_out),
	.q(mem_cc_out)
);

nzp_comparator cccomp
(
	.nzp_vals(mem_cc_out),
	.dest_reg(mem_wb_dest_out),
	.br_enable(branch_enable)
);

flipflop_positive #(.width(1)) indirect_reg
(
	.clk(clk),
	.load(ctrl.in_indirect && mem_resp),
	.d(!(indirect_reg_out)),
	.q(indirect_reg_out)
);

flipflop_positive #(.width(16)) indirect_mdr
(
	.clk(clk),
	.load(ctrl.in_indirect && mem_resp),
	.d(mdrmux_out),
	.q(indirect_mdr_out)
);

concat sr2concat
(
	.in(ex_mem_sr2real_out),
	.out(ex_mem_sr2concat_out)
);

endmodule : mem