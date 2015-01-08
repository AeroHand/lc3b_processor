onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp2_tb/clk
add wave -noupdate /mp2_tb/dut/cache/mem_read
add wave -noupdate /mp2_tb/dut/cache/mem_resp
add wave -noupdate /mp2_tb/dut/cpu/cpu_control/regfilemux_sel
add wave -noupdate /mp2_tb/dut/cache/cache_control/state
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/data0/data
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/data1/data
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/lru/data
add wave -noupdate -expand /mp2_tb/dut/cpu/cpu_datapath/regfile/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20931091 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5250 ns}
