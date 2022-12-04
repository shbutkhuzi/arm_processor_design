module ALU(
	input [31:0] src1,
	input [31:0] src2,
	output reg [31:0] Rd_out,
	input [7:0] ctrl_cmd,
	output reg [3:0] new_flags,
	input [3:0] current_flags	// NZCV
);

logic [31:0] A[4], B[4], S[4];
logic cout[4];
logic fin_carry;
logic [3:0] flags_to_set_flags = 0; // for NZCV correspondingly
logic add_sub = 0;

MyAdder MyAdder_inst0(A[0], B[0], S[0], cout[0]);
MyAdder MyAdder_inst1(A[1], B[1], S[1], cout[1]);
MyAdder MyAdder_inst2(A[2], B[2], S[2], cout[2]);
MyAdder MyAdder_inst3(A[3], B[3], S[3], cout[3]);

always @(ctrl_cmd, src1, src2, current_flags, S[0], S[1], S[2], S[3], cout[0], cout[1], cout[2], cout[3]) begin
	case(ctrl_cmd[7:6])
		// Data Processing Instructions
		2'b00: begin
					case(ctrl_cmd[4:1])
						// Bitwise AND
						4'b0000: begin Rd_out <= src1 & src2; flags_to_set_flags <= 4'b1110; end
						// Bitwise XOR
						4'b0001: begin Rd_out <= src1 ^ src2; flags_to_set_flags <= 4'b1110; end
						// Subtract
						4'b0010: begin A[1] <= ~src2; B[1] <= 1; A[0] <= src1; B[0] <= S[1]; Rd_out <= S[0]; fin_carry <= cout[0]; flags_to_set_flags <= 4'b1111; add_sub <= 0; end
						// Reverse Subtract
						4'b0011: begin A[1] <= ~src1; B[1] <= 1; A[0] <= src2; B[0] <= S[1]; Rd_out <= S[0]; fin_carry <= cout[0]; flags_to_set_flags <= 4'b1111; add_sub <= 0; end
						// Add
						4'b0100: begin A[0] <= src1; B[0] <= src2; Rd_out <= S[0]; fin_carry <= cout[0]; flags_to_set_flags <= 4'b1111; add_sub <= 1; end
						// Add with Carry
						4'b0101: begin A[0] <= src1; B[0] <= src2; A[1] <= S[0]; B[1] <= {28'h0000000, 3'b000, current_flags[1]}; Rd_out <= S[1]; fin_carry <= cout[1]; flags_to_set_flags <= 4'b1111; add_sub <= 1; end
						//Subtract with Carry
						4'b0110: begin A[0] <= ~src2; B[0] <= 1; A[1] <= 1; B[1] <= {28'h0000000, 3'b000, current_flags[1]}; A[2] <= S[0]; B[2] <= S[1]; A[3] <= src1; B[3] <= S[2]; Rd_out <= S[3]; fin_carry <= cout[3]; flags_to_set_flags <= 4'b1111; add_sub <= 0; end
						// Reverse Sub w/ Carry
						4'b0111: begin A[0] <= ~src1; B[0] <= 1; A[1] <= 1; B[1] <= {28'h0000000, 3'b000, current_flags[1]}; A[2] <= S[0]; B[2] <= S[1]; A[3] <= src2; B[3] <= S[2]; Rd_out <= S[3]; fin_carry <= cout[3]; flags_to_set_flags <= 4'b1111; add_sub <= 0; end
						// Test
						4'b1000: begin Rd_out <= src1 & src2; flags_to_set_flags <= 4'b1110; end
						// Test Equivalence
						4'b1001: begin Rd_out <= src1 ^ src2; flags_to_set_flags <= 4'b1110; end
						// Compare
						4'b1010: begin A[1] <= ~src2; B[1] <= 1; A[0] <= src1; B[0] <= S[1]; Rd_out <= S[0]; fin_carry <= cout[0]; flags_to_set_flags <= 4'b1111; add_sub <= 0; end
						// Compare Negative
						4'b1011: begin A[0] <= src1; B[0] <= src2; Rd_out <= S[0]; fin_carry <= cout[0]; flags_to_set_flags <= 4'b1111; add_sub <= 1; end
						// Bitwise OR
						4'b1100: begin Rd_out <= src1 | src2; flags_to_set_flags <= 4'b1110; end
						// Move
						4'b1101: begin Rd_out <= src2; flags_to_set_flags <= 4'b1110; end
						// Bitwise Clear
						4'b1110: begin Rd_out <= src1 & ~src2; flags_to_set_flags <= 4'b1110; end
						// Bitwise NOT
						4'b1111: begin Rd_out <= ~src1; flags_to_set_flags <= 4'b1110; end
						default: Rd_out <= 0;
					endcase
				 end
		// Memory instructions
		2'b01: begin
					case(ctrl_cmd[2])
						// Address for store and load register
						1'b0: begin A[0] <= src1; B[0] <= src2; Rd_out <= S[0]; fin_carry <= cout[0]; flags_to_set_flags <= 4'b0000; end
						default: Rd_out <= 0;
					endcase
				 end
		// Branch
		2'b10: begin A[0] <= src1; B[0] <= src2; Rd_out <= S[0]; fin_carry <= cout[0]; flags_to_set_flags <= 4'b0000; end
		// Multiply
		2'b11: begin
					case(ctrl_cmd[3:1])
						// Multiply
						3'b000: begin Rd_out <= src1 * src2; flags_to_set_flags <= 4'b1100; end // :)
						default: Rd_out <= 0;
					endcase
				 end
		default: Rd_out <= 0;
	endcase
end

always_comb begin
	// Zero
	if (Rd_out == 0 && flags_to_set_flags[2] == 1) new_flags[2] <= 1;
	else new_flags[2] <= 0;
	// Negative
	if (Rd_out[31] == 1 && flags_to_set_flags[3] == 1) new_flags[3] <= 1;
	else new_flags[3] <= 0;
	// Carry
	if (fin_carry == 1 && flags_to_set_flags[1] == 1) new_flags[1] <= 1;
	else new_flags[1] <= 0;
	// oVerflow
	if (flags_to_set_flags[0] == 1 && (src1[31]^Rd_out[31]) && ~(src1[31]^src2[31]^add_sub)) new_flags[0] <= 1;
	else new_flags[0] <= 0;
end

endmodule