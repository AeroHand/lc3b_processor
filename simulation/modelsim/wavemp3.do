onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp3_tb/dut/id_stage/reg_file/load
add wave -noupdate -expand /mp3_tb/dut/id_stage/reg_file/data
add wave -noupdate /mp3_tb/dut/wb_stage/regfilemux/f
add wave -noupdate /mp3_tb/dut/ex_stage/alu_unit/f
add wave -noupdate /mp3_tb/dut/id_stage/ctrlrom_unit/ctrl.opcode
add wave -noupdate /mp3_tb/dut/mem_stage/cccomp/br_enable
add wave -noupdate /mp3_tb/dut/id_stage/regfilemux_out
add wave -noupdate /mp3_tb/dut/if_stage/pcmux_out
add wave -noupdate /mp3_tb/dut/if_stage/pcmux/sel
add wave -noupdate /mp3_tb/dut/mem_stage/cccomp/nzp_vals
add wave -noupdate /mp3_tb/dut/mem_stage/cccomp/dest_reg
add wave -noupdate /mp3_tb/dut/mem_stage/marmux/sel
add wave -noupdate /mp3_tb/dut/mem_stage/marmux/f
add wave -noupdate /mp3_tb/dut/mem_stage/cc_reg/data
add wave -noupdate /mp3_tb/dut/mem_stage/cccomp/nzp_vals
add wave -noupdate /mp3_tb/dut/mem_stage/cccomp/dest_reg
add wave -noupdate /mp3_tb/dut/mem_stage/cc_reg/load
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {257561 ps} 0}
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
WaveRestoreZoom {210674 ps} {389958 ps}
