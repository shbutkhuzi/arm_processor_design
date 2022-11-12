module reg_file_test();

logic clk;
logic wen_ARd;
logic [3:0] ARn, ARs, ARm, ARd;
logic [31:0] Rn, Rs, Rm, Rd, Rd_data, PC_out, PC_next;

reg_file reg_file_tst(clk, wen_ARd, ARn, ARs, ARm, ARd, Rn, Rs, Rm, Rd, Rd_data, PC_out, PC_next);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	wen_ARd = 0;
	ARn = 0;
	ARs = 1;
	ARm = 2;
	ARd = 3;
	Rd_data = 0;
	PC_next = 0;
	
	#10 wen_ARd = 1;
	Rd_data = 356;
	PC_next = 12;
	ARd = 15;
	
	#10 PC_next = PC_out + 4;
	
	#10 wen_ARd = 0;
	Rd_data = 356;
	PC_next = 10;
	ARd = 15;

	#10 wen_ARd = 1;
	Rd_data = 36;
	PC_next = 5;
	ARd = 12;

end

endmodule