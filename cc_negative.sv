module cc_negative
(
    input clk,
    input load,
    input [2:0] d,
    output logic [2:0] q
);

logic [2:0] data;

/* Altera device registers are 0 at power on. Specify this
 * so that Modelsim works as expected.
 */
initial
begin
    data[0] = 1'b0;
	 data[1] = 1'b1;
	 data[2] = 1'b0;
end

always_ff @(negedge clk)
begin
    if (load)
    begin
        data = d;
    end
end

always_comb
begin
    q = data;
end

endmodule : cc_negative
