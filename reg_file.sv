module reg_file(
	input clk, wen_ARd,
	input [3:0] ARn, ARs, ARm, ARd,
	output [31:0] Rn, Rs, Rm, Rd,
	input [31:0] Rd_data,
	output [31:0] PC_out,
	input [31:0] PC_next,
	input ctrl_BL,
	output [7:0] R12
);

logic [31:0] r_file [16] = '{32'b00110001001001110100100101101011,
								     32'b11011001111101101110111101111111,
									  32'b11110000000000000000000000001111,
									  32'b00001111000000000000000011110000,
									  32'b00000000000000000000000000000000,
									  32'b00000000000011111111000000000000,
									  32'b00000000000000011000000000000000,
									  32'b00000000000011111111000000000000,
									  32'b00000000111100000000111100000000,
									  32'b00001111000000000000000011110000,
									  32'b11110000000000000000000000001111,
									  32'b00001111000000000000000011110000,
									  32'b00000000111100000000111100000000,
									  32'b00000000000000000000000000000000,
									  32'b00000000000000000000000000000000,
									  32'b00000000000000000000000000000000};
									
assign Rn     = r_file[ARn];
assign Rs 	  = r_file[ARs];
assign Rm 	  = r_file[ARm];
assign Rd 	  = r_file[ARd];
assign PC_out = r_file[15];

assign R12 = r_file[12][7:0];

always @(posedge clk) begin
	if (wen_ARd) begin
		r_file[ARd] = Rd_data;
	end
	
	if ((ARd == 4'b1111) && (wen_ARd == 1)) begin
		r_file[15] = Rd_data;
	end else r_file[15] = PC_next;
	
	if (r_file[15] > 60) begin
		r_file[15] = 0;
	end
	
	if (ctrl_BL) begin
		r_file[14] = r_file[15] + 4;
	end
end

endmodule