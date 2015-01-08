import lc3b_types::*;

module adder
(
	 input lc3b_word pc_val,
	 input lc3b_word extended9_val,
    output lc3b_word br_address
);
//assign out = in + 4'h2;

always_comb
begin
	 br_address = pc_val + extended9_val;
end

endmodule : adder