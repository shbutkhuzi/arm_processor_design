module PROCESSOR_test();

logic clk;

PROCESSOR PROCESSOR_tst(clk);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;

end

endmodule