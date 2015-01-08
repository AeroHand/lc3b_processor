onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mp2_tb/clk
add wave -noupdate /mp2_tb/pmem_resp
add wave -noupdate /mp2_tb/pmem_read
add wave -noupdate /mp2_tb/pmem_write
add wave -noupdate /mp2_tb/pmem_address
add wave -noupdate /mp2_tb/pmem_rdata
add wave -noupdate /mp2_tb/pmem_wdata
add wave -noupdate /mp2_tb/dut/cpu/mem_address
add wave -noupdate /mp2_tb/dut/cpu/cpu_datapath/pc/out
add wave -noupdate /mp2_tb/dut/cpu/cpu_datapath/mdr/out
add wave -noupdate /mp2_tb/dut/cpu/mem_read
add wave -noupdate /mp2_tb/dut/cpu/mem_write
add wave -noupdate /mp2_tb/dut/cpu/mem_resp
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/inrw1
add wave -noupdate -expand /mp2_tb/dut/cpu/cpu_datapath/regfile/data
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/tag0/dataout
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/tag1/dataout
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/mem_tag
add wave -noupdate /mp2_tb/dut/cache/cache_datapath/mem_offset
add wave -noupdate /mp2_tb/dut/cache/lru_out
add wave -noupdate -expand /mp2_tb/dut/cache/cache_datapath/data1/data
add wave -noupdate -expand /mp2_tb/dut/cache/cache_datapath/data0/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1447642 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 382
configure wave -valuecolwidth 320
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
WaveRestoreZoom {1318977 ps} {1791158 ps}
