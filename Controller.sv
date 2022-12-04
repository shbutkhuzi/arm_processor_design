module Controller(
	input clk,
	input [31:0] instruction,
	input [3:0] current_flags, // NZCV
	output reg wen_ARd, wen_data_mem, update_flags,
	output reg [7:0] ALU_ctrl,
	output reg reg_file_ctrl_BL,
	output reg Y_mux_sel, X_mux_sel,
	output reg [1:0] src1mux_sel
);

logic update_flags_en = 0;
logic exec_inst_en = 0;

assign update_flags = clk & update_flags_en;

always_comb begin
	case(instruction[31:28])
		4'b0000: exec_inst_en <=  current_flags[2] ? 1 : 0;
		4'b0001: exec_inst_en <= ~current_flags[2] ? 1 : 0;
		4'b0010: exec_inst_en <=  current_flags[1] ? 1 : 0;
		4'b0011: exec_inst_en <= ~current_flags[1] ? 1 : 0;
		4'b0100: exec_inst_en <=  current_flags[3] ? 1 : 0;
		4'b0101: exec_inst_en <= ~current_flags[3] ? 1 : 0;
		4'b0110: exec_inst_en <=  current_flags[0] ? 1 : 0;
		4'b0111: exec_inst_en <= ~current_flags[0] ? 1 : 0;
		4'b1000: exec_inst_en <=  ( current_flags[1] & ~current_flags[2]) ? 1 : 0;
		4'b1001: exec_inst_en <=  (~current_flags[1] |  current_flags[2]) ? 1 : 0;
		4'b1010: exec_inst_en <= ~( current_flags[3] ^  current_flags[0]) ? 1 : 0;
		4'b1011: exec_inst_en <=  ( current_flags[3] ^  current_flags[0]) ? 1 : 0;
		4'b1100: exec_inst_en <=(~( current_flags[3] ^  current_flags[0])) & (~current_flags[2]) ? 1 : 0;
		4'b1101: exec_inst_en <=  ( current_flags[3] ^  current_flags[0])  |   current_flags[2]  ? 1 : 0;
		4'b1110: exec_inst_en <= 1;
	default: exec_inst_en = 0;
	endcase
end

always_comb begin
	case(exec_inst_en)
		1'b0: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= 0; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 3; end
		1'b1: case(instruction[27:26])
					// Data Processing Instructions
					2'b00: begin
								case(instruction[24:21])
									4'b0000: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b0001: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b0010: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b0011: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b0100: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b0101: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b0110: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b0111: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1000: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 1;               reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1001: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 1;               reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1010: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 1;               reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1011: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 1;               reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1100: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1101: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1110: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									4'b1111: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
								default: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= 0; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 3; end
								endcase
							 end
					// Memory instructions
					2'b01: begin
								case(instruction[20])
									1'b0: begin wen_ARd <= 0; wen_data_mem <= 1; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
									1'b1: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 1; Y_mux_sel <= 0; src1mux_sel <= 0; end
								default: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= 0; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 3; end
								endcase
							 end
					// Branch
					2'b10: begin
								case(instruction[24])
									1'b0: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 1; src1mux_sel <= 2; end
									1'b1: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 1; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 1; src1mux_sel <= 2; end
								default: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= 0; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 3; end
								endcase
							 end
					// Multiply
					2'b11: begin
								case(instruction[23:21])
									3'b000: begin wen_ARd <= 1; wen_data_mem <= 0; update_flags_en <= instruction[20]; reg_file_ctrl_BL <= 0; ALU_ctrl <= instruction[27:20]; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 0; end
								default: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= 0; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 3; end
								endcase
							 end
				default: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= 0; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 3; end
				endcase
	default: begin wen_ARd <= 0; wen_data_mem <= 0; update_flags_en <= 0; reg_file_ctrl_BL <= 0; ALU_ctrl <= 0; X_mux_sel <= 0; Y_mux_sel <= 0; src1mux_sel <= 3; end
	endcase
end

endmodule