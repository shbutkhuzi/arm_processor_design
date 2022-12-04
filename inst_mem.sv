module inst_mem(
	input [5:0] address,
	output reg [31:0] instruction
);

logic [7:0] instructions [64] =   '{8'b11101010, 8'b00000000, 8'b00000000, 8'b00000101, // bootloader
												8'b11100010, 8'b10010000, 8'b00010000, 8'b00110101, // first program     ADDS R1, R0, #53  
											   8'b11100000, 8'b01110001, 8'b00101101, 8'b00000001, //                   RSBS R2, R1, R1<<26
											   8'b11100110, 8'b00000100, 8'b00100000, 8'b00000011, // 						 STR  R2, [R4, 3]
											   8'b00011010, 8'b11111111, 8'b11111111, 8'b11111101, //						 BNE  by -3 instructions from here
											   8'b11100011, 8'b10100000, 8'b01010000, 8'b00000000, // second program	 MOV  R5, #0
											   8'b11100110, 8'b00010100, 8'b01100000, 8'b00001100, //						 LDR  R6, [R4, 12]
											   8'b11100011, 8'b10100000, 8'b11000000, 8'b00000000, //						 MOV  R12, #0
											   8'b11100001, 8'b01000101, 8'b00000000, 8'b00000110, //						 CMP  R5, R6
											   8'b00011010, 8'b00000000, 8'b00000000, 8'b00000100, //						 BNE  by +4 instructions from here
											   8'b11100001, 8'b11101100, 8'b11000000, 8'b00000000, //						 MVN  R12, R12
											   8'b11100011, 8'b10100000, 8'b01010000, 8'b00000000, //						 MOV  R5, #0
											   8'b11101010, 8'b11111111, 8'b11111111, 8'b11111100, //						 B    by -4 instructions from here
											   8'b11100010, 8'b10000101, 8'b01010000, 8'b00000001, //						 ADD  R5, R5, #1
											   8'b11101010, 8'b11111111, 8'b11111111, 8'b11111010, //						 B    by -6 instructions from here
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
												
always_comb begin
	if(address > 60) begin
		instruction = 0;
	end else instruction = {instructions[address], instructions[address+1], instructions[address+2], instructions[address+3]};
end

//assign instruction = {instructions[address], instructions[address+1], instructions[address+2], instructions[address+3]};

endmodule