library verilog;
use verilog.vl_types.all;
entity cc_negative is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        d               : in     vl_logic_vector(2 downto 0);
        q               : out    vl_logic_vector(2 downto 0)
    );
end cc_negative;
