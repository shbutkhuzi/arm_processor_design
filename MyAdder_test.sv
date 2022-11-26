module MyAdder_test();

logic clk;
logic [31:0] A, B, S;
logic cout;

MyAdder MyAdder_tst(A, B, S, cout);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	A = 2593;
	B = 2940;
	
	#5 A = 32'hfffffffe;
	   B = 1;
	#5 B = 2;
	
end

endmodule