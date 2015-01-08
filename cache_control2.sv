import lc3b_types::*; /* Import types defined in lc3b_types.sv */

module cache_control2
(
    /* Input and output port declarations */
	 
	 input clk,

    /* Datapath controls */

    input [1:0] lru_out,
	 input mem_read,
	 input mem_write,
	 input tag_match,
	 input valid,
	 input dirty,
	 input [1:0] whichtag,
	 output logic write0,
	 output logic write1,
	 output logic write2,
	 output logic write3,
	 output logic wdirty0,
	 output logic wdirty1,
	 output logic wdirty2,
	 output logic wdirty3,
	 output logic dirty0_val,
	 output logic dirty1_val,
	 output logic dirty2_val,
	 output logic dirty3_val,
	 output logic mem_resp,
	 output logic inrw1,
	 output logic inw1,
    

    /* Memory signals */

    input pmem_resp,
    output logic pmem_read,
    output logic pmem_write
);

enum int unsigned {
    /* List of states */
	 init,
	 check_line,
	 store_line,
	 get_line,
	 rw1
} state, next_state;

always_comb
begin : state_actions
    /* Default output assignments */
	 
	 write0 = 1'b0;
	 write1 = 1'b0;
	 write2 = 1'b0;
	 write3 = 1'b0;
	 wdirty0 = 1'b0;
	 wdirty1 = 1'b0;
	 wdirty2 = 1'b0;
	 wdirty3 = 1'b0;
	 dirty0_val = 1'b0;
	 dirty1_val = 1'b0;
	 dirty2_val = 1'b0;
	 dirty3_val = 1'b0;
	 pmem_read = 1'b0;
	 pmem_write = 1'b0;
	 mem_resp = 1'b0;
	 inrw1 = 1'b0;
	 inw1 = 1'b0;
	 
    /* Actions for each state */
	 
	 case(state)
        check_line: begin
				if(tag_match && (mem_read || mem_write) && valid) begin
					mem_resp = 1;
					inrw1 = 1;
					if (mem_write) begin
						inw1 = 1;
						if(whichtag == 1) begin
							write1 = 1;
							wdirty1 = 1;
							dirty1_val = 1;
						end
						else if(whichtag == 2) begin
							write2 = 1;
							wdirty2 = 1;
							dirty2_val = 1;
						end
						else if(whichtag == 3) begin
							write3 = 1;
							wdirty3 = 1;
							dirty3_val = 1;
						end
						else begin
							write0 = 1;
							wdirty0 = 1;
							dirty0_val = 1;
						end
					end
				end
		  end
		  
		  store_line: begin
				pmem_write = 1;
				if(lru_out == 1) begin
					wdirty1 = 1;
					dirty1_val = 0;
				end
				else if(lru_out == 2) begin
					wdirty2 = 1;
					dirty2_val = 0;
				end
				else if(lru_out == 3) begin
					wdirty3 = 1;
					dirty3_val = 0;
				end
				else begin
					wdirty0 = 1;
					dirty0_val = 0;
				end
		  end
		  
		  get_line: begin
				pmem_read = 1;
				if(pmem_resp) begin
					if(lru_out == 1)
						write1 = 1;
					else if(lru_out == 2)
						write2 = 1;
					else if(lru_out == 3)
						write3 = 1;
					else
						write0 = 1;
				end
		  end
		  
		  rw1: begin
				mem_resp = 1;
				inrw1 = 1;
				if (mem_write) begin
					inw1 = 1;
					if(whichtag == 1) begin
						write1 = 1;
						wdirty1 = 1;
						dirty1_val = 1;
					end
					else if(whichtag == 2) begin
						write2 = 1;
						wdirty2 = 1;
						dirty2_val = 1;
					end
					else if(whichtag == 3) begin
						write3 = 1;
						wdirty3 = 1;
						dirty3_val = 1;
					end
					else begin
						write0 = 1;
						wdirty0 = 1;
						dirty0_val = 1;
					end
				end
		  end
		  
		  init: /*Do nothing */;
		    
        default: /* Do nothing */;

    endcase
end

always_comb
begin : next_state_logic
    /* Next state information and conditions (if any)
     * for transitioning between states */
	 next_state = state;
	 
    case(state)
	 
		  init: begin
				if(mem_read || mem_write)
					next_state = check_line;
		  end 
		  
        check_line: begin
				if(tag_match && (mem_read || mem_write) && valid)
					next_state = init;
				else if(mem_read || mem_write) begin
					if (!dirty)
						next_state = get_line;
					else
						next_state = store_line;
				end
		  end
		  
		  store_line: if (pmem_resp) next_state = get_line;
		  
		  get_line: if (pmem_resp) next_state = rw1;
		  
		  rw1: next_state = init;

        default: next_state = init;

    endcase
end

always_ff @(posedge clk)
begin: next_state_assignment
    /* Assignment of next state on clock edge */
	 state <= next_state;
end

endmodule : cache_control2
