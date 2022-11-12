transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/MEGA/SDSU/2022\ Fall/Electrical\ Engineering\ 475/Arm\ Processor/arm32bit {D:/MEGA/SDSU/2022 Fall/Electrical Engineering 475/Arm Processor/arm32bit/src1mux.sv}
vlog -sv -work work +incdir+D:/MEGA/SDSU/2022\ Fall/Electrical\ Engineering\ 475/Arm\ Processor/arm32bit {D:/MEGA/SDSU/2022 Fall/Electrical Engineering 475/Arm Processor/arm32bit/testbench.sv}
vlog -sv -work work +incdir+D:/MEGA/SDSU/2022\ Fall/Electrical\ Engineering\ 475/Arm\ Processor/arm32bit {D:/MEGA/SDSU/2022 Fall/Electrical Engineering 475/Arm Processor/arm32bit/X_mux.sv}
vlog -sv -work work +incdir+D:/MEGA/SDSU/2022\ Fall/Electrical\ Engineering\ 475/Arm\ Processor/arm32bit {D:/MEGA/SDSU/2022 Fall/Electrical Engineering 475/Arm Processor/arm32bit/Y_mux.sv}

