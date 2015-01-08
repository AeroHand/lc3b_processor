import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module arbiter
(
	input clk,

	input i_mem_read,
	input d_mem_read,
	input d_mem_write,
	input mem_resp,
	output logic i_mem_resp,
	output logic d_mem_resp,
	output logic a_mem_read,
	output logic a_mem_write

);

enum int unsigned {
    /* List of states */
    wwait,
    instruction_fetch,
    data_fetch

} state, next_state;

always_comb
begin : state_actions
	/* Default output assignments */
	i_mem_resp = 0;
	d_mem_resp = 0;
	a_mem_read = 0;
	a_mem_write = 0;

    /* Actions for each state */
	case(state)
		wwait:
			begin
				if(d_mem_read) begin
					a_mem_read = 1;
				end
				else if (d_mem_write) begin
					a_mem_write = 1;
				end
				else if (i_mem_read) begin
					a_mem_read = 1;
				end
			end
		instruction_fetch:
			begin
				i_mem_resp = 1;
			end
		data_fetch:
			begin
				d_mem_resp = 1;
			end
	endcase
end

always_comb
begin : next_state_resp_logic
    next_state = state;
    case(state)
    	wwait:
    		begin
				if((d_mem_read == 1 || d_mem_write == 1) && mem_resp)
					next_state = data_fetch;
				else if(i_mem_read && mem_resp)
					next_state = instruction_fetch;
    		end
	instruction_fetch: next_state = wwait;
	data_fetch: next_state = wwait;
    	default:
    		next_state = wwait;
    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
        state <= next_state;
end

endmodule : arbiter














