import lc3b_types::*;

module tagcomp4other
(
    input [8:0] a,
	 input [8:0] b,
	 input [8:0] c,
	 input [8:0] d,
	 input [8:0] q,
    output logic [2:0] f
);

always_comb
begin

    if (a == q)
        f = 3'b100;
    else if (b == q)
        f = 3'b101;
	 else if (c == q)
        f = 3'b110;
	 else if (d == q)
        f = 3'b111;
	 else
	     f = 3'b000;

end

endmodule : tagcomp4other