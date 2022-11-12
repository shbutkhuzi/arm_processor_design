module inst_mem_test();

logic clk;
logic [5:0] address;
logic [31:0] instr;

inst_mem inst_mem_tst(address, instr);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	address = 6'b000000;
	#10 address = 6'b000001;
	#10 address = 6'b111011;
	#10 address = 6'b111100;
	#10 address = 6'b111101;
	#10 address = 6'b111110;
	#10 address = 6'b111111;
	

end

endmodule