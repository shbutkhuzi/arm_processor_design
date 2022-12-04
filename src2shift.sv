module src2shift(
	input [31:0] Rs,
	input signed [31:0] Rm,
	input [27:0] imm,
	output reg [31:0] src2
);

logic [31:0] rot_out [3];

rot_right rot_right_inst0({24'h000000, imm[7:0]}, {imm[11:8], 1'b0}, rot_out[0]);
rot_right rot_right_inst1(Rm, imm[11:7], rot_out[1]);
rot_right rot_right_inst2(Rm, {24'h000000, 3'b000, Rs[4:0]}, rot_out[2]); 

always_comb begin
	case(imm[27:26])
		// Data-processing instructions
		2'b00: begin
					case(imm[25])
						1'b0: begin
									case(imm[4])
										1'b0: begin
													case(imm[6:5])
														2'b00: src2 <= Rm <<  imm[11:7];
														2'b01: src2 <= Rm >>  imm[11:7];
														2'b10: src2 <= Rm >>> imm[11:7];
														2'b11: src2 <= rot_out[1];
														default: src2 <= 0;
													endcase
												end
										1'b1: begin
													case(imm[6:5])
														2'b00: src2 <= Rm <<  Rs[4:0];
														2'b01: src2 <= Rm >>  Rs[4:0];
														2'b10: src2 <= Rm >>> Rs[4:0];
														2'b11: src2 <= rot_out[2];
														default: src2 <= 0;
													endcase
												end
										default: src2 <= 0;
									endcase
								end
						1'b1: begin
									src2 <= rot_out[0];
								end
						default: src2 <= 0;
					endcase
				 end
		// Memory instructions
		2'b01: begin
					case(imm[25])
						1'b0: begin
									case(imm[6:5])
										2'b00: src2 <= Rm <<  imm[11:7];
										2'b01: src2 <= Rm >>  imm[11:7];
										2'b10: src2 <= Rm >>> imm[11:7];
										2'b11: src2 <= rot_out[1];
										default: src2 <= 0;
									endcase
								end
						1'b1: src2 <= imm[11] ? {20'hFFFFF, imm[11:0]} : {20'h00000, imm[11:0]};
					default: src2 <= 0;
					endcase
				 end
		// Branch
		2'b10: src2 <= imm[23] ? {6'b111111, imm[23:0], 2'b00} : {6'b000000, imm[23:0], 2'b00};
		// Multiply
		2'b11: src2 <= Rm;
		default: src2 <= 0;
	endcase
end

endmodule