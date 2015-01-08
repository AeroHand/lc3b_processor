import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module victim_control
(
    /* Input and output port declarations */
	 
	 input clk,

    /* Datapath controls */

	 input mem_read,
	 input mem_write,
	 input tag_match,
	 input tag_match_buffer_out,
	 input valid,
	 input valid_buffer_out,
	 input dirty,
	 output logic write,
	 output logic mem_resp,
	 output logic in_get,
	 output logic write_dirty,
    

    /* Memory signals */

    input pmem_resp,
    output logic pmem_read,
    output logic pmem_write
);

enum int unsigned {
    /* List of states */
	 check_line,
	 store_line,
	 get_line
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	 
	 write = 1'b0;
	 in_get = 1'b0;
	 pmem_read = 1'b0;
	 pmem_write = 1'b0;
	 mem_resp = 1'b0;
	 write_dirty = 1'b0;
	 
    /* Actions for each state */
	 
	 case(state)
        check_line: begin
				if(mem_write && !(!tag_match)) begin
					mem_resp = 1;
					write = 1;
				end
				else if(mem_read && valid_buffer_out && tag_match_buffer_out) begin
				   write_dirty = 1;
					mem_resp = 1;
				end
		  end
		  
		  store_line: begin
				pmem_write = 1;
				if(pmem_resp) begin
				   mem_resp = 1;
					write = 1;
				end
		  end
		  
		  get_line: begin
				pmem_read = 1;
				in_get = 1;
				if(pmem_resp) begin
				   mem_resp = 1;
				end
		  end
		    
        default: /* Do nothing */;

    endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	 next_state = state;
	 
    case(state)
        check_line: begin
				if((!tag_match) && mem_write )
					next_state = store_line;
				else if(((!valid_buffer_out) || (!tag_match_buffer_out)) && mem_read)
					next_state = get_line;
		  end
		  
		  store_line: if (pmem_resp) next_state = check_line;
		  
		  get_line: if (pmem_resp) next_state = check_line;

        default: next_state = check_line;

    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : victim_control
