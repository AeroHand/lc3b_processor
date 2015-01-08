library verilog;
use verilog.vl_types.all;
entity nzp_comparator is
    port(
        nzp_vals        : in     vl_logic_vector(2 downto 0);
        dest_reg        : in     vl_logic_vector(2 downto 0);
        br_enable       : out    vl_logic
    );
end nzp_comparator;
