module data_mem_test();

logic clk;
logic wen;
logic [5:0] mem_addr;
logic [31:0] data_in;
logic [31:0] data_out;

data_mem data_mem_tst(clk, wen, mem_addr, data_in, data_out);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	data_in = 0;
	wen = 0;
	mem_addr = 6'b000000;
	#10 mem_addr = 6'b000001;
	#10 mem_addr = 6'b111011;
	#10 mem_addr = 6'b111100;
	#10 mem_addr = 6'b111101;
	#10 mem_addr = 6'b111110;
	#10 mem_addr = 6'b111111;
	
	#10 mem_addr = 6'b001100;
	    data_in = 32'b11110000111100001111000011110000;
		 
	#10 wen = 1;
	#10 mem_addr = 6'b001101;
	    data_in = 32'b11110000111100001111000011110000;
		 
	#10 mem_addr = 6'b111111;
	    data_in = 32'b11110000111100001111000011110010;	

end

endmodule