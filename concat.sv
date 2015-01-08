module concat #(parameter width = 16)
(
    input logic [width-1:0] in,
    output logic [width-1:0] out
);

always_comb
begin
	out = {in[7:0], in[7:0]};
end

endmodule : concat