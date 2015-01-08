import lc3b_types::*;

module forward_unit
(
	//inputs/outputs here

	input logic ex_mem_regwrite,
	input logic [2:0] id_ex_sr1,
	input logic [2:0] id_ex_sr2,
	input logic [2:0] id_ex_dr,
	input logic [2:0] ex_mem_dr,
	input logic id_ex_in_st,
	input logic ex_mem_in_ld,
	input logic ex_mem_set_r7,
	input logic ex_mem_in_lea,
	input logic mem_wb_regwrite,
	input logic [2:0] mem_wb_dr,
	
	output logic [2:0] forward1,
	output logic [2:0] forward2
);

always_comb
begin
	if((3'b111 == id_ex_sr1) && ex_mem_set_r7)
		forward1 = 3'b100;
	else if(ex_mem_in_lea && (ex_mem_dr == id_ex_sr1))
		forward1 = 3'b101;
	else if(ex_mem_regwrite && (ex_mem_dr == id_ex_sr1) && !(ex_mem_in_ld))
		forward1 = 3'b001;
	else if(ex_mem_regwrite && (ex_mem_dr == id_ex_sr1))
		forward1 = 3'b010;
	else if(mem_wb_regwrite && (mem_wb_dr == id_ex_sr1))
		forward1 = 3'b011;
	else
		forward1 = 3'b000;
		
	if((3'b111 == id_ex_sr2) && ex_mem_set_r7)
		forward2 = 3'b100;
	else if(ex_mem_in_lea && (ex_mem_dr == id_ex_sr2))
		forward2 = 3'b101;
	else if(ex_mem_regwrite && ((ex_mem_dr == id_ex_sr2) || (id_ex_in_st && (ex_mem_dr == id_ex_dr))) && !(ex_mem_in_ld))
		forward2 = 3'b001;
	else if(ex_mem_regwrite && (ex_mem_dr == id_ex_sr2) || (id_ex_in_st && (ex_mem_dr == id_ex_dr)))
		forward2 = 3'b010;
	else if(mem_wb_regwrite && (mem_wb_dr == id_ex_sr2) || (id_ex_in_st && (mem_wb_dr == id_ex_dr)))
		forward2 = 3'b011;
	else
		forward2 = 3'b000;
end

endmodule : forward_unit
