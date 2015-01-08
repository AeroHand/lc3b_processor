transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/mux8.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/if_id.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/concat.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/plus2.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/mux4.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/mux2.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/lc3b_types.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/flipflop_positive.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/arbiter.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/cache_control.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/cc_negative.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/forward_unit.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/write_calc.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/tagcomp.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/off_addr_calc.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/cache_datapath.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/cache.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/array.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/sext.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/ifetch.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/zext.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/mem_wb.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/id_ex.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/gencc.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/ex_mem.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/adjz.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/adj.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/regfile.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/nzp_comparator.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/alu.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/adder.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/id.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/ex.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/mem.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/wb.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/control_rom.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/pipeline.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/cache_datapath_2.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/cache2.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/mp3.sv}

vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/mp3_tb.sv}
vlog -sv -work work +incdir+/home/britto1/ece411/mp3curr {/home/britto1/ece411/mp3curr/physical_memory.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiii_ver -L rtl_work -L work -voptargs="+acc"  mp3_tb

add wave *
view structure
view signals
run 200 ns
