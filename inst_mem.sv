module inst_mem(
	input [5:0] address,
	output reg [31:0] instruction
);

logic [7:0] instructions [64] =   '{8'b10011001, 8'b00110110, 8'b10001111, 8'b01111110,
											   8'b11011001, 8'b11110110, 8'b11101111, 8'b01111111,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000,
											   8'b00000000, 8'b00000000, 8'b00000000, 8'b00000000};
												
always_comb begin
	if(address > 60) begin
		instruction = 0;
	end else instruction = {instructions[address], instructions[address+1], instructions[address+2], instructions[address+3]};
end

//assign instruction = {instructions[address], instructions[address+1], instructions[address+2], instructions[address+3]};

endmodule