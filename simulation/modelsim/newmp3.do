onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp3_tb/clk
add wave -noupdate /mp3_tb/mem_resp
add wave -noupdate /mp3_tb/mem_read
add wave -noupdate /mp3_tb/mem_write
add wave -noupdate /mp3_tb/mem_byte_enable
add wave -noupdate /mp3_tb/mem_address
add wave -noupdate /mp3_tb/mem_rdata
add wave -noupdate /mp3_tb/mem_wdata
add wave -noupdate /mp3_tb/imem_resp
add wave -noupdate /mp3_tb/imem_read
add wave -noupdate /mp3_tb/imem_write
add wave -noupdate /mp3_tb/imem_byte_enable
add wave -noupdate /mp3_tb/imem_address
add wave -noupdate /mp3_tb/imem_rdata
add wave -noupdate /mp3_tb/imem_wdata
add wave -noupdate /mp3_tb/dut/id_stage/reg_file/load
add wave -noupdate -expand /mp3_tb/dut/id_stage/reg_file/data
add wave -noupdate /mp3_tb/dut/wb_stage/regfilemux/f
add wave -noupdate /mp3_tb/dut/ex_stage/alu_unit/f
add wave -noupdate /mp3_tb/dut/id_stage/ctrlrom_unit/ctrl.opcode
add wave -noupdate /mp3_tb/dut/mem_stage/cccomp/br_enable
add wave -noupdate /mp3_tb/dut/id_stage/regfilemux_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {41354 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 338
configure wave -valuecolwidth 188
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
WaveRestoreZoom {0 ps} {358567 ps}
