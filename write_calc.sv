import lc3b_types::*;

module write_calc
(
	 input lc3b_c_offset sel,
	 input logic [1:0] selbyte,
    input lc3b_memband datain,
	 input lc3b_word newdata,
    output lc3b_memband dataout
);

always_comb
begin
	case(selbyte)
	
		2'b11: begin
			case(sel)
				3'b111:	dataout = {newdata, datain[111:0]};
				3'b110:	dataout = {datain[127:112], newdata, datain[95:0]};
				3'b101:	dataout = {datain[127:96], newdata, datain[79:0]};
				3'b100:	dataout = {datain[127:80], newdata, datain[63:0]};
				3'b011:	dataout = {datain[127:64], newdata, datain[47:0]};
				3'b010:	dataout = {datain[127:48], newdata, datain[31:0]};
				3'b001:	dataout = {datain[127:32], newdata, datain[15:0]};
				default:	dataout = {datain[127:16], newdata};
			endcase
		end
		
		2'b10: begin
			case(sel)
				3'b111:	dataout = {newdata[15:8], datain[119:0]};
				3'b110:	dataout = {datain[127:112], newdata[15:8], datain[103:0]};
				3'b101:	dataout = {datain[127:96], newdata[15:8], datain[87:0]};
				3'b100:	dataout = {datain[127:80], newdata[15:8], datain[71:0]};
				3'b011:	dataout = {datain[127:64], newdata[15:8], datain[55:0]};
				3'b010:	dataout = {datain[127:48], newdata[15:8], datain[39:0]};
				3'b001:	dataout = {datain[127:32], newdata[15:8], datain[23:0]};
				default:	dataout = {datain[127:16], newdata[15:8], datain[7:0]};
			endcase
		end
		
		2'b01: begin
			case(sel)
				3'b111:	dataout = {datain[127:120], newdata[7:0], datain[111:0]};
				3'b110:	dataout = {datain[127:104], newdata[7:0], datain[95:0]};
				3'b101:	dataout = {datain[127:88], newdata[7:0], datain[79:0]};
				3'b100:	dataout = {datain[127:72], newdata[7:0], datain[63:0]};
				3'b011:	dataout = {datain[127:56], newdata[7:0], datain[47:0]};
				3'b010:	dataout = {datain[127:40], newdata[7:0], datain[31:0]};
				3'b001:	dataout = {datain[127:24], newdata[7:0], datain[15:0]};
				default:	dataout = {datain[127:8], newdata[7:0]};
			endcase
		end
		
		default:	dataout = datain;
		
	endcase
end

endmodule : write_calc