library verilog;
use verilog.vl_types.all;
entity tagcomp is
    port(
        a               : in     vl_logic_vector(8 downto 0);
        b               : in     vl_logic_vector(8 downto 0);
        q               : in     vl_logic_vector(8 downto 0);
        f               : out    vl_logic_vector(1 downto 0)
    );
end tagcomp;
