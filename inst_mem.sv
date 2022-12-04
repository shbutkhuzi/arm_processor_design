module inst_mem(
	input [5:0] address,
	output reg [31:0] instruction
);

logic [7:0] instructions [64] =   '{8'b11100010, 8'b10010000, 8'b00010000, 8'b00110101,
											   8'b11100000, 8'b01110001, 8'b00101101, 8'b00000001,
											   8'b11100110, 8'b00000100, 8'b00100000, 8'b00000011,
											   8'b00011010, 8'b11111111, 8'b11111111, 8'b11111101,
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