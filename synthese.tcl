#if not aldready defined
set PROJECT_NAME "."
set synth_dir "$PROJECT_NAME/SYNTH"
set rtl_dir "$PROJECT_NAME/SRC/RTL"
set synth2_dir "$PROJECT_NAME/SRC/GATES"
set top_name "filtre"
set clock_name "clk_i"

#liste des fichiers � analyser dans l'ordre

#compl�ter
set rtl_list [ list \
			$rtl_dir/rom.vhd\
			$rtl_dir/reg.vhd\
			$rtl_dir/mul.vhd\
			$rtl_dir/fsm.vhd\
			$rtl_dir/dl.vhd\
			$rtl_dir/cpt.vhd\
		  $rtl_dir/filtre.vhd\
		  ]
#analyse des fichiers
analyze -library LIB_RTL  -format vhdl $rtl_list

#elaboration des fichiers analys�es
elaborate $top_name -architecture ${top_name}_arch -library LIB_RTL

#sauvegarde apr�s analyse et elaboration
write -format ddc -hierarchy -output $synth_dir/DDC/${top_name}_elab.ddc

#contraintes
set_operating_conditions -library c35_CORELIB nom_pvt
set_wire_load_model -name 10k -library c35_CORELIB
set cycleTime 40
create_clock -name "clock" -period $cycleTime -waveform { 20 40  } $clock_name
#sauvegarde apr�s analyse et elaboration
write -format ddc -hierarchy -output $synth_dir/DDC/${top_name}_const.ddc

#synth�se
compile -map_effort high -area_effort medium -incremental_mapping

#sauvegarde apr�s analyse et elaboration
write -format ddc -hierarchy -output $synth_dir/DDC/${top_name}_synth.ddc

#generation du code vhdl
change_names -rules vhdl -verbose -hierarchy -log_changes $synth_dir/RPT/${top_name}_rename_vhdl.txt
write -format vhdl -hierarchy -output $synth2_dir/${top_name}_synth.vhd

#generation du code verilog
change_names -rules verilog -verbose -hierarchy -log_changes $synth_dir/RPT/${top_name}_rename_verilog.txt

write -format verilog -hierarchy -output $synth2_dir/${top_name}_synth.v
#generation du fichier sdf

write_sdf -version 2.1 $synth_dir/SDF/${top_name}_synth.sdf

#generation des rapports
report_design -nosplit  > $synth_dir/RPT/${top_name}_report_design.txt

report_hierarchy  > $synth_dir/RPT/${top_name}_report_hierarchy.txt

report_reference -hierarchy -nosplit > $synth_dir/RPT/${top_name}_report_reference.txt

report_port -nosplit -verbose >  $synth_dir/RPT/${top_name}_report_port.txt

report_area -nosplit -hierarchy >  $synth_dir/RPT/${top_name}_report_area.txt

report_clock -nosplit >  $synth_dir/RPT/${top_name}_report_clock.txt


# a completer
