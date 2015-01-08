import lc3b_types::*;

module off_addr_calc
(
	 input lc3b_c_offset sel,
    input lc3b_memband datain,
    output logic [15:0] dataout
);

always_comb
begin
    case(sel)
			3'b111:	dataout = datain[127:112];
			3'b110:	dataout = datain[111:96];
			3'b101:	dataout = datain[95:80];
			3'b100:	dataout = datain[79:64];
			3'b011:	dataout = datain[63:48];
			3'b010:	dataout = datain[47:32];
			3'b001:	dataout = datain[31:16];
			default:	dataout = datain[15:0];
	 endcase
end

endmodule : off_addr_calc