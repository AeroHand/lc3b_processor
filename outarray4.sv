import lc3b_types::*;

module outarray4 #(parameter width = 128)
(
    input clk,
    input write,
    input [1:0] index,
    input [width-1:0] datain,
    output logic [width-1:0] dataout,
	 output logic [width-1:0] data0,
	 output logic [width-1:0] data1,
	 output logic [width-1:0] data2,
	 output logic [width-1:0] data3
);

logic [width-1:0] data [3:0];

/* Initialize array */
initial
begin
    for (int i = 0; i < $size(data); i++)
    begin
        data[i] = 1'b0;
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[index] = datain;
    end
end

assign dataout = data[index];
assign data0 = data[0];
assign data1 = data[1];
assign data2 = data[2];
assign data3 = data[3];


endmodule : outarray4