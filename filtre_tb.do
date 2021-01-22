onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /filtre_tb/Filter_IN_s
add wave -noupdate /filtre_tb/Clk_s
add wave -noupdate /filtre_tb/Resetb_s
add wave -noupdate /filtre_tb/ADC_Busy_s
add wave -noupdate /filtre_tb/Filter_out_s
add wave -noupdate /filtre_tb/ADC_Convstb_s
add wave -noupdate /filtre_tb/ADC_Rd_csb_s
add wave -noupdate /filtre_tb/dut/fsm_1/Etat_present
add wave -noupdate /filtre_tb/dut/fsm_1/Etat_futur
add wave -noupdate /filtre_tb/dut/dl_1/inter_s(0)
add wave -noupdate /filtre_tb/dut/dl_1/inter_s(1)
add wave -noupdate /filtre_tb/dut/dl_1/inter_s(2)
add wave -noupdate /filtre_tb/dut/dl_1/inter_s(3)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4746 ns} 0}
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
WaveRestoreZoom {1020 ns} {9420 ns}
