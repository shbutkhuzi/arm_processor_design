module ALU_test();

logic clk;
logic [31:0] src1, src2, Rd_out;
logic [7:0] ctrl_cmd;
logic [3:0] new_flags, current_flags;

ALU ALU_tst(src1, src2, Rd_out, ctrl_cmd, new_flags, current_flags);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	src1 = 194;
	src2 = 204;
	ctrl_cmd[7:6] = 2'b00;
	
	ctrl_cmd[4:1] = 4'b0100;
	
	#10 ctrl_cmd[7:6] = 2'b11;
		 ctrl_cmd[3:1] = 3'b000;

end

endmodule