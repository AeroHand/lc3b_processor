import lc3b_types::*;

module tagcomp
(
    input lc3b_c_tag a,
	 input lc3b_c_tag b,
	 input lc3b_c_tag q,
    output logic [1:0] f
);

always_comb
begin

    if (a == q)
        f = 2'b10;
    else if (b == q)
        f = 2'b11;
	 else
	     f = 2'b00;

end

endmodule : tagcomp