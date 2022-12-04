module PROCESSOR(
	input clk
);

logic [31:0] instruction;
logic [3:0] new_flags, current_flags;
logic wen_ARd, wen_data_mem, update_flags;
logic [7:0] ALU_ctrl;
logic reg_file_ctrl_BL;
logic Y_mux_sel, X_mux_sel;
logic [1:0] src1mux_sel;
logic [31:0] Rn, Rs, Rm, Rd, Rd_data, PC_out, PC_next, ALU_result, data_mem_out, src1, src2;
logic [3:0] ARd;

Controller Controller_inst0(clk, instruction, current_flags, wen_ARd, wen_data_mem, update_flags, ALU_ctrl, reg_file_ctrl_BL, Y_mux_sel, X_mux_sel, src1mux_sel);
inst_mem   inst_mem_inst0(PC_out[5:0], instruction);
reg_file   reg_file_inst0(clk, wen_ARd, instruction[19:16], instruction[11:8], instruction[3:0], ARd, Rn, Rs, Rm, Rd, Rd_data, PC_out, PC_next, reg_file_ctrl_BL);
data_mem   data_mem_inst0(clk, wen_data_mem, ALU_result[5:0], Rd, data_mem_out);
src2shift  src2shift_inst0(Rs, Rm, instruction[27:0], src2);
ALU        ALU_inst0(src1, src2, ALU_result, ALU_ctrl, new_flags, current_flags);
flags      flags_inst0(update_flags, new_flags, current_flags);
PCinc		  PCinc_inst0(PC_out, PC_next);

X_mux      X_mux_inst0(ALU_result, data_mem_out, X_mux_sel, Rd_data);
Y_mux		  Y_mux_inst0(instruction[15:12], Y_mux_sel, ARd);
src1mux	  src1mux_inst0(Rn, Rs, PC_out, src1mux_sel, src1);


endmodule