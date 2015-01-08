library verilog;
use verilog.vl_types.all;
entity off_addr_calc is
    port(
        sel             : in     vl_logic_vector(2 downto 0);
        datain          : in     vl_logic_vector(127 downto 0);
        dataout         : out    vl_logic_vector(15 downto 0)
    );
end off_addr_calc;
