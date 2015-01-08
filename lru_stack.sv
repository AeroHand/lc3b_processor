import lc3b_types::*;

module lru_stack
(
    input clk,
    input write,
	 input [1:0] index,
    output logic [1:0] lru
);

logic [1:0] data [3:0];
logic [1:0] tempdata [3:0];

/* Initialize array */
initial
begin
    data[0] = 2'b00;
	 data[1] = 2'b01;
	 data[2] = 2'b10;
	 data[3] = 2'b11;
end

always_comb
begin
    if (index == data[0])
    begin
        tempdata[0] = data[1];
		  tempdata[1] = data[2];
		  tempdata[2] = data[3];
		  tempdata[3] = data[0];
    end
	 
	 else if (index == data[1])
    begin
        tempdata[0] = data[0];
		  tempdata[1] = data[2];
		  tempdata[2] = data[3];
		  tempdata[3] = data[1];
    end
	 
	 else if (index == data[2])
    begin
        tempdata[0] = data[0];
		  tempdata[1] = data[1];
		  tempdata[2] = data[3];
		  tempdata[3] = data[2];
    end
	 
	 else
    begin
        tempdata[0] = data[0];
		  tempdata[1] = data[1];
		  tempdata[2] = data[2];
		  tempdata[3] = data[3];
    end
end

always_ff @(posedge clk)
begin
    if (write == 1)
    begin
        data[0] <= tempdata[0];
		  data[1] <= tempdata[1];
		  data[2] <= tempdata[2];
		  data[3] <= tempdata[3];
    end
end

assign lru = data[0];

endmodule : lru_stack