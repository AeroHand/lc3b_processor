onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp3_tb/clk
add wave -noupdate /mp3_tb/resp
add wave -noupdate /mp3_tb/read
add wave -noupdate /mp3_tb/write
add wave -noupdate /mp3_tb/address
add wave -noupdate /mp3_tb/rdata
add wave -noupdate /mp3_tb/wdata
add wave -noupdate -expand /mp3_tb/dut/pipeline/id_stage/reg_file/data
add wave -noupdate /mp3_tb/dut/pipeline/if_stage/pcmux/f
add wave -noupdate /mp3_tb/dut/pipeline/if_id_ff/imem_rdata
add wave -noupdate /mp3_tb/dut/pipeline/ex_stage/addpcadj/br_address
add wave -noupdate /mp3_tb/dut/pipeline/if_stage/pcmux/sel
add wave -noupdate /mp3_tb/dut/pipeline/if_stage/branchmux/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22801 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
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
WaveRestoreZoom {0 ps} {146072 ps}
