import lc3b_types::*;

module nzp_comparator
(
    input lc3b_nzp nzp_vals,
	input lc3b_reg dest_reg,
    output logic br_enable
);


always_comb
begin
	if((dest_reg[0] & nzp_vals[0]) || (dest_reg[1] & nzp_vals[1]) || (dest_reg[2] & nzp_vals[2]))
		br_enable = 1;
	else
		br_enable = 0;
end

endmodule : nzp_comparator