module data_mem(
	input clk,
	input wen,
	input [5:0] mem_addr,
	input [31:0] data_in,
	output reg [31:0] data_out
);

logic [7:0] data [64] = '{8'b10011001, 8'b00110110, 8'b10001111, 8'b01111110,
								  8'b11011001, 8'b11110110, 8'b11101111, 8'b01111111,
								  8'b00001000, 8'b00000000, 8'b00001000, 8'b10000000,
								  8'b01100000, 8'b01001100, 8'b01010100, 8'b11011000,
								  8'b00100000, 8'b00100000, 8'b00000000, 8'b00000000,
								  8'b00000000, 8'b00001000, 8'b00000000, 8'b01000000,
								  8'b01000000, 8'b00001000, 8'b00000000, 8'b00010000,
								  8'b00000000, 8'b00100000, 8'b10000000, 8'b00001000,
								  8'b00000000, 8'b00010000, 8'b10010000, 8'b00100001,
							     8'b00001000, 8'b01000010, 8'b01000000, 8'b00000000,
							     8'b01000000, 8'b00010100, 8'b00100000, 8'b00101000,
								  8'b00000000, 8'b00100100, 8'b01000000, 8'b10000000,
								  8'b00010000, 8'b00010000, 8'b01100000, 8'b00010000,
								  8'b00010000, 8'b01000100, 8'b00001000, 8'b01000000,
								  8'b01000000, 8'b00000010, 8'b00100000, 8'b00010000,
							     8'b01000010, 8'b00011000, 8'b10001000, 8'b00000100};
								  
always_comb begin
	if(mem_addr > 60) begin
		data_out = 32'hffffffff;
	end else data_out = {data[mem_addr], data[mem_addr+1], data[mem_addr+2], data[mem_addr+3]};
end

always @(posedge clk) begin
	if (wen && (mem_addr <= 60)) begin
		data[mem_addr]   = data_in[31:24];
		data[mem_addr+1] = data_in[23:16];
		data[mem_addr+2] = data_in[15:8];
		data[mem_addr+3] = data_in[7:0];		
	end
end

endmodule