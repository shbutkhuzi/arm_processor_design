module src2shift_test();

logic clk;
logic [31:0] in_data, out_data;
logic [4:0] amt;
logic [31:0] Rs, Rm, src2;
logic [25:0] imm;

rot_right rot_right_tst(in_data, amt, out_data);
src2shift src2shift_tst(Rs, Rm, imm, src2);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	in_data = 32'hF0F0;
	amt = 3;
	imm = 0;
	Rs = 32'h000C;
	Rm = 32'hC58A;
	
	#6 amt = 5;
	#6 in_data = 32'hA8C2;
	#6 amt = 31;
	#6 amt = 32;
	#6 amt = 33;
	
	#50 imm[25] = 1;
	    imm[11:0] = 12'b001011010110;
		 
	#10 imm[25] = 0;
	#5  imm[11:0] = 12'b010100001010;
	#5  imm[11:0] = 12'b010100101010;
	#5  imm[11:0] = 12'b010101001010;
	#5  imm[11:0] = 12'b010101101010;
	
	#10 imm[25] = 0; Rm = 32'hC000C58B;
	#5  imm[11:0] = 12'b010100011010;
	#5  imm[11:0] = 12'b010100111010;
	#5  imm[11:0] = 12'b010101011010;
	#5  imm[11:0] = 12'b010101111010;
	
	
	
end

endmodule