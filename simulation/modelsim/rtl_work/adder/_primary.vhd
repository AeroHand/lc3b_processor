library verilog;
use verilog.vl_types.all;
entity adder is
    port(
        pc_val          : in     vl_logic_vector(15 downto 0);
        extended9_val   : in     vl_logic_vector(15 downto 0);
        br_address      : out    vl_logic_vector(15 downto 0)
    );
end adder;
