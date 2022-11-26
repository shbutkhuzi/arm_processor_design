module rot_right(
	input [31:0] inp_data,
	input [4:0] amount,
	output reg [31:0] out_data
);

always_comb begin
	case(amount)
		5'b00000: out_data <= inp_data;
		5'b00001: begin 
						out_data[30:0] <= inp_data[31:1];
						out_data[31] <= inp_data[0];
					 end
		5'b00010: begin 
						out_data[29:0] <= inp_data[31:2];
						out_data[31:30] <= inp_data[1:0];
					 end
		5'b00011: begin 
						out_data[28:0] <= inp_data[31:3];
						out_data[31:29] <= inp_data[2:0];
					 end
		5'b00100: begin 
						out_data[27:0] <= inp_data[31:4];
						out_data[31:28] <= inp_data[3:0];
					 end
		5'b00101: begin 
						out_data[26:0] <= inp_data[31:5];
						out_data[31:27] <= inp_data[4:0];
					 end
		5'b00110: begin 
						out_data[25:0] <= inp_data[31:6];
						out_data[31:26] <= inp_data[5:0];
					 end
		5'b00111: begin 
						out_data[24:0] <= inp_data[31:7];
						out_data[31:25] <= inp_data[6:0];
					 end
		5'b01000: begin 
						out_data[23:0] <= inp_data[31:8];
						out_data[31:24] <= inp_data[7:0];
					 end
		5'b01001: begin 
						out_data[22:0] <= inp_data[31:9];
						out_data[31:23] <= inp_data[8:0];
					 end
		5'b01010: begin 
						out_data[21:0] <= inp_data[31:10];
						out_data[31:22] <= inp_data[9:0];
					 end
		5'b01011: begin 
						out_data[20:0] <= inp_data[31:11];
						out_data[31:21] <= inp_data[10:0];
					 end
		5'b01100: begin 
						out_data[19:0] <= inp_data[31:12];
						out_data[31:20] <= inp_data[11:0];
					 end
		5'b01101: begin 
						out_data[18:0] <= inp_data[31:13];
						out_data[31:19] <= inp_data[12:0];
					 end
		5'b01110: begin 
						out_data[17:0] <= inp_data[31:14];
						out_data[31:18] <= inp_data[13:0];
					 end
		5'b01111: begin 
						out_data[16:0] <= inp_data[31:15];
						out_data[31:17] <= inp_data[14:0];
					 end
		5'b10000: begin 
						out_data[15:0] <= inp_data[31:16];
						out_data[31:16] <= inp_data[15:0];
					 end
		5'b10001: begin 
						out_data[14:0] <= inp_data[31:17];
						out_data[31:15] <= inp_data[16:0];
					 end
		5'b10010: begin 
						out_data[13:0] <= inp_data[31:18];
						out_data[31:14] <= inp_data[17:0];
					 end
		5'b10011: begin 
						out_data[12:0] <= inp_data[31:19];
						out_data[31:13] <= inp_data[18:0];
					 end
		5'b10100: begin 
						out_data[11:0] <= inp_data[31:20];
						out_data[31:12] <= inp_data[19:0];
					 end
		5'b10101: begin 
						out_data[10:0] <= inp_data[31:21];
						out_data[31:11] <= inp_data[20:0];
					 end
		5'b10110: begin 
						out_data[9:0] <= inp_data[31:22];
						out_data[31:10] <= inp_data[21:0];
					 end
		5'b10111: begin 
						out_data[8:0] <= inp_data[31:23];
						out_data[31:9] <= inp_data[22:0];
					 end
		5'b11000: begin 
						out_data[7:0] <= inp_data[31:24];
						out_data[31:8] <= inp_data[23:0];
					 end
		5'b11001: begin 
						out_data[6:0] <= inp_data[31:25];
						out_data[31:7] <= inp_data[24:0];
					 end
		5'b11010: begin 
						out_data[5:0] <= inp_data[31:26];
						out_data[31:6] <= inp_data[25:0];
					 end
		5'b11011: begin 
						out_data[4:0] <= inp_data[31:27];
						out_data[31:5] <= inp_data[26:0];
					 end
		5'b11100: begin 
						out_data[3:0] <= inp_data[31:28];
						out_data[31:4] <= inp_data[27:0];
					 end
		5'b11101: begin 
						out_data[2:0] <= inp_data[31:29];
						out_data[31:3] <= inp_data[28:0];
					 end
		5'b11110: begin 
						out_data[1:0] <= inp_data[31:30];
						out_data[31:2] <= inp_data[29:0];
					 end
		5'b11111: begin 
						out_data[0] <= inp_data[31];
						out_data[31:1] <= inp_data[30:0];
					 end
		default: out_data <= 0;
	endcase
end

endmodule