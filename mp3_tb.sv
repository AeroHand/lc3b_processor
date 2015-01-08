module mp3_tb;

timeunit 1ns;
timeprecision 1ns;

logic clk;
logic resp;
logic read;
logic write;
logic [15:0] address;
logic [127:0] rdata;
logic [127:0] wdata;

/* Clock generator */
initial clk = 0;
always #5 clk = ~clk;

mp3 dut
(
	.clk(clk),
	.mem_address(address),
	.mem_wdata(wdata),
	.mem_rdata(rdata),	
	.mem_read(read),
	.mem_write(write),	
	.mem_resp(resp)
);

physical_memory phys_mem
(
    .clk(clk),
    .read(read),
    .write(write),
    .address(address),
    .wdata(wdata),
    .resp(resp),
    .rdata(rdata)
);

endmodule : mp3_tb
