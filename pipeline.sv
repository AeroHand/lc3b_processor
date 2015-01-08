import lc3b_types::*;

module pipeline
(
	input clk,

	output logic [15:0] mem_address,
	output logic [15:0] mem_wdata,
	input [15:0] mem_rdata,
	
	output logic mem_read,
	output logic mem_write,
	output logic [1:0] mem_byte_enable,
	
	input mem_resp,
	
	output logic [15:0] imem_address,
	output logic [15:0] imem_wdata,
	input [15:0] imem_rdata,
	
	output logic imem_read,
	output logic imem_write,
	output logic [1:0] imem_byte_enable,
	
	input imem_resp

);

//internal signals
//group by modules!!!!

logic [15:0] plus2_out;
logic [15:0] if_id_pc_out;
logic [3:0] id_ex_opcode_out;
logic [15:0] id_ex_trap_out;
logic [2:0] id_ex_dest_out;
lc3b_control_word  id_ex_ctrl_out;
logic [2:0] ex_mem_dest_out;
logic [3:0] ex_mem_opcode_out;
lc3b_control_word  ex_mem_ctrl_out;
logic [3:0] mem_wb_opcode_out;
logic [15:0] mem_wb_mar_out;
lc3b_control_word  mem_wb_ctrl_out;
logic [3:0] if_id_opcode_out;
lc3b_control_word  id_ctrl_out;
logic [15:0] ex_mem_bradj_out;
lc3b_control_word ctrl;
logic [15:0] mem_wb_alu_out;
logic [15:0] mem_wb_mdr_out;
logic [15:0] mem_wb_bradj_out;
logic [15:0] mem_wb_pc_out;
logic [2:0] mem_wb_dest_out;
logic [15:0] regfilemux_out;
logic [15:0] id_ex_pc_out;
logic [15:0] id_ex_adj_out;
logic [15:0] id_ex_sr1_out;
logic [15:0] id_ex_sr2_out;
logic [15:0] addpcadj_out;
logic [15:0] alu_out;
logic [15:0] instruction;
logic [15:0] adjtrap_out;
logic [15:0] adjmux_out;
logic [15:0] alumux_out;
logic [15:0] sr1_out;
logic [15:0] sr2_out;
logic [15:0] ex_mem_alu_out;
logic [15:0] ex_mem_pc_out;
logic [15:0] ex_mem_trap_out;
logic [15:0] ex_mem_sr1_out;
logic [15:0] id_ex_sr2real_out;
logic [15:0] ex_mem_sr2real_out;
logic [15:0] orig_sr1_out;
logic [15:0] orig_sr2_out;
logic [2:0] id_ex_sr1;
logic [2:0] id_ex_sr2;
logic [2:0] forward1;
logic [2:0] forward2;
logic branch_enable;
logic branch;
logic load;
logic indirect_reg_out;
logic pc_mux_not_zero;

//modules

assign mem_read = (ex_mem_ctrl_out.mem_read && !(ex_mem_ctrl_out.in_sti && indirect_reg_out));
assign mem_write = (ex_mem_ctrl_out.mem_write && !(ex_mem_ctrl_out.in_sti && !(indirect_reg_out)));
assign mem_byte_enable[0] = (!(ex_mem_ctrl_out.in_byte) || !(mem_address[0]));
assign mem_byte_enable[1] = (!(ex_mem_ctrl_out.in_byte) || (mem_address[0]));

assign imem_byte_enable = 2'b11;
assign imem_wdata = 16'b0000000000000000;
assign imem_read = 1;
assign imem_write = 0;

assign branch = (branch_enable && ex_mem_ctrl_out.in_branch);

assign load = ((!(ex_mem_ctrl_out.in_indirect) || indirect_reg_out) && !(ex_mem_ctrl_out.in_mem && !(mem_resp)) && imem_resp);

assign pc_mux_not_zero = ((ex_mem_ctrl_out.pcmux_sel[0]) || (ex_mem_ctrl_out.pcmux_sel[1]) || (ex_mem_ctrl_out.pcmux_sel[2]) || branch);

ifetch if_stage
(
	.clk(clk),
	.branch(branch),
	.ctrl(ex_mem_ctrl_out),
	.if_id_pc_out(if_id_pc_out),
	.ex_mem_pc_out(ex_mem_pc_out),
	.id_ex_sr1_out(ex_mem_sr1_out),
	.ex_mem_bradj_out(ex_mem_bradj_out),
	.mem_wb_mdr_out(mem_wdata),
	.pcmux_out(imem_address),
	.pcplus2_out(plus2_out)
);

id id_stage
(
	.clk(clk),
	.ctrl(ctrl),
	.ctrlwb(mem_wb_ctrl_out),
	.regfilemux_out(regfilemux_out),
	.instruction(instruction),
	.destb(mem_wb_dest_out),
	.adjtrap_out(adjtrap_out),
	.adjmux_out(adjmux_out),
	.alumux_out(alumux_out),
	.sr1_out(sr1_out),
	.sr2_out(sr2_out)
);

ex ex_stage
(
	.ctrl(id_ex_ctrl_out),
	.id_ex_pc_out(id_ex_pc_out),
	.id_ex_adj_out(id_ex_adj_out),
	.id_ex_sr1_out(id_ex_sr1_out),
	.id_ex_sr2_out(id_ex_sr2_out),
	.id_ex_sr2real_out(id_ex_sr2real_out),
	.addpcadj_out(addpcadj_out),
	.alu_out(alu_out)
);

mem mem_stage
(
	.clk(clk),
	.load_cc(mem_wb_ctrl_out.load_cc),
	.ctrl(ex_mem_ctrl_out),
	.ex_mem_alu_out(ex_mem_alu_out),
	.ex_mem_pc_out(ex_mem_pc_out),
	.ex_mem_trap_out(ex_mem_trap_out),
	.mem_rdata(mem_rdata),
	.ex_mem_sr2real_out(ex_mem_sr2real_out),
	.wb_regfilemux_out(regfilemux_out),
	.mem_wb_dest_out(ex_mem_dest_out),
	.mem_resp(mem_resp),
	.marmux_out(mem_address),
	.mdrmux_out(mem_wdata),
	.branch_enable(branch_enable),
	.indirect_reg_out(indirect_reg_out)
);

wb wb_stage
(
	.ctrl(mem_wb_ctrl_out),
	.mem_wb_mar_out(mem_wb_mar_out),
	.mem_wdata(mem_wb_mdr_out),
	.mem_wb_alu_out(mem_wb_alu_out),
	.mem_wb_mdr_out(mem_wb_mdr_out),
	.mem_wb_bradj_out(mem_wb_bradj_out),
	.mem_wb_pc_out(mem_wb_pc_out),
	.regfilemux_out(regfilemux_out)
);

if_id if_id_ff
(
	.clk(clk),
	.load(load),
	.if_plus2_out(plus2_out),
	.if_id_pc_out(if_id_pc_out),
	.imem_rdata(imem_rdata),
	.if_id_instr_out(instruction)
);

id_ex id_ex_ff
(
	.clk(clk),
	.load(load),
	.pc_mux_not_zero(pc_mux_not_zero),
	.if_id_pc_out(if_id_pc_out),
	.if_id_opcode_out(instruction[15:12]),
	.id_adjmux_out(adjmux_out),
	.id_trap_out(adjtrap_out),
	.id_sr1_out(sr1_out),
	.id_sr2real_out(sr2_out),
	.id_sr2_out(alumux_out),
	.id_dest_out(instruction[11:9]),
	.id_sr1_num_out(instruction[8:6]),
	.id_sr2_num_out(instruction[2:0]),
	.id_ctrl_out(ctrl),
	.id_ex_pc_out(id_ex_pc_out),
	.id_ex_opcode_out(id_ex_opcode_out),
	.id_ex_adj_out(id_ex_adj_out),
	.id_ex_trap_out(id_ex_trap_out),
	.id_ex_sr1_out(orig_sr1_out),
	.id_ex_sr2real_out(orig_sr2_out),
	.id_ex_sr2_out(id_ex_sr2_out),
	.id_ex_dest_out(id_ex_dest_out),
	.id_ex_sr1_num_out(id_ex_sr1),
	.id_ex_sr2_num_out(id_ex_sr2),
	.id_ex_ctrl_out(id_ex_ctrl_out)
);

ex_mem ex_mem_ff
(
	.clk(clk),
	.load(load),
	.pc_mux_not_zero(pc_mux_not_zero),
	.id_ex_opcode_out(id_ex_opcode_out),
	.id_ex_trap_out(id_ex_trap_out),
	.id_ex_sr1_out(id_ex_sr1_out),
	.id_ex_sr2real_out(id_ex_sr2real_out),
	.id_ex_dest_out(id_ex_dest_out),
	.id_ex_ctrl_out(id_ex_ctrl_out),
	.id_ex_pc_out(id_ex_pc_out),
	.ex_addpcadj_out(addpcadj_out),
	.ex_alu_out(alu_out),
	.ex_mem_pc_out(ex_mem_pc_out),
	.ex_mem_opcode_out(ex_mem_opcode_out),
	.ex_mem_trap_out(ex_mem_trap_out),
	.ex_mem_alu_out(ex_mem_alu_out),
	.ex_mem_sr1_out(ex_mem_sr1_out),
	.ex_mem_sr2real_out(ex_mem_sr2real_out),
	.ex_mem_dest_out(ex_mem_dest_out),
	.ex_mem_ctrl_out(ex_mem_ctrl_out),
	.ex_mem_bradj_out(ex_mem_bradj_out)
);

mem_wb mem_wb_ff
(
	.clk(clk),
	.load(load),
	.ex_mem_pc_out(ex_mem_pc_out),
	.ex_mem_opcode_out(ex_mem_opcode_out),
	.mem_marmux_out(mem_address),
	.mem_mdrmux_out(mem_wdata),
	.ex_mem_alu_out(ex_mem_alu_out),
	.ex_mem_ctrl_out(ex_mem_ctrl_out),
	.ex_mem_bradj_out(ex_mem_bradj_out),
	.ex_mem_dest_out(ex_mem_dest_out),
	.mem_wb_pc_out(mem_wb_pc_out),
	.mem_wb_opcode_out(mem_wb_opcode_out),
	.mem_wb_mar_out(mem_wb_mar_out),
	.mem_wb_mdr_out(mem_wb_mdr_out),
	.mem_wb_alu_out(mem_wb_alu_out),
	.mem_wb_ctrl_out(mem_wb_ctrl_out),
	.mem_wb_bradj_out(mem_wb_bradj_out),
	.mem_wb_dest_out(mem_wb_dest_out)
);

mux8 #(.width(16)) forward1mux
(
	.sel(forward1),
	.a(orig_sr1_out),
	.b(ex_mem_alu_out),
	.c(mem_wdata),
	.d(regfilemux_out),
	.e(ex_mem_pc_out),
	.g(ex_mem_bradj_out),
	.h(16'b0000000000000000),
	.i(16'b0000000000000000),
	.f(id_ex_sr1_out)
);

mux8 #(.width(16)) forward2mux
(
	.sel(forward2),
	.a(orig_sr2_out),
	.b(ex_mem_alu_out),
	.c(mem_wdata),
	.d(regfilemux_out),
	.e(ex_mem_pc_out),
	.g(ex_mem_bradj_out),
	.h(16'b0000000000000000),
	.i(16'b0000000000000000),
	.f(id_ex_sr2real_out)
);

forward_unit forward_unit
(
	.ex_mem_regwrite(ex_mem_ctrl_out.load_regfile),
	.id_ex_sr1(id_ex_sr1),
	.id_ex_sr2(id_ex_sr2),
	.id_ex_in_add_reg(id_ex_ctrl_out.in_add_reg),
	.id_ex_dr(id_ex_dest_out),
	.ex_mem_dr(ex_mem_dest_out),
	.id_ex_in_st(id_ex_ctrl_out.in_st),
	.ex_mem_in_ld(ex_mem_ctrl_out.in_ld),
	.ex_mem_set_r7(ex_mem_ctrl_out.set_r7),
	.ex_mem_in_lea(ex_mem_ctrl_out.in_lea),
	.mem_wb_regwrite(mem_wb_ctrl_out.load_regfile),
	.mem_wb_dr(mem_wb_dest_out),
	.forward1(forward1),
	.forward2(forward2)
);

endmodule : pipeline