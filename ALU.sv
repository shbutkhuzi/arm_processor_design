module ALU(
	input [31:0] src1,
	input [31:0] src2,
	output reg [31:0] Rd_out,
	input [7:0] ctrl_cmd,
	output reg [3:0] new_flags,
	input [3:0] current_flags	// NZCV
);

logic [31:0] A[2], B[2], S[2];
logic cout[2];
logic fin_carry;

MyAdder MyAdder_inst0(A[0], B[0], S[0], cout[0]);
MyAdder MyAdder_inst1(A[1], B[1], S[1], cout[1]);

always_comb begin
	case(ctrl_cmd[7:6])
		// Data Processing Instructions
		2'b00: begin
					case(ctrl_cmd[4:1])
						// Bitwise AND
						4'b0000: Rd_out <= src1 & src2;
						// Bitwise XOR
						4'b0001: Rd_out <= src1 ^ src2;
						// Subtract
						4'b0010: begin A[1] <= ~src2; B[1] <= 1; A[0] <= src1; B[0] <= S[1]; Rd_out <= S[0]; fin_carry <= cout[0]; end
						// Reverse Subtract
						4'b0010: begin A[1] <= ~src1; B[1] <= 1; A[0] <= src2; B[0] <= S[1]; Rd_out <= S[0]; fin_carry <= cout[0]; end
						// Add
						4'b0100: begin A[0] <= src1; B[0] <= src2; Rd_out <= S[0]; fin_carry <= cout[0]; end
						// Add with Carry
						4'b0101: begin A[0] <= src1; B[0] <= src2; A[1] <= S[0]; B[1] <= {28'h0000000, 3'b000, current_flags[1]}; Rd_out <= S[1]; fin_carry <= cout[1]; end
						// Bitwise OR
						4'b1100: Rd_out <= src1 | src2;
						// Bitwise Clear
						4'b1110: Rd_out <= src1 & ~src2;
						// Bitwise NOT
						4'b1111: Rd_out <= ~src1;
						default: Rd_out <= 0;
					endcase
				 end
		// Multiply
		2'b11: begin
					case(ctrl_cmd[3:1])
						// Multiply
						3'b000: Rd_out <= src1 * src2; // :)
						default: Rd_out <= 0;
					endcase
				 end
		default: Rd_out <= 0;
	endcase
end

always_comb begin
	if (Rd_out == 0) new_flags[2] <= 1;
	else new_flags[2] <= 0;
	
	if (Rd_out[31] == 1) new_flags[3] <= 1;
	else new_flags[3] <= 0;
	
	if (fin_carry == 1) new_flags[1] <= 1;
	else new_flags[1] <= 0;
	
	// overflow	
end

endmodule