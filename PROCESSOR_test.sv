module PROCESSOR_test();

logic clk;
logic [7:0] R12;

PROCESSOR PROCESSOR_tst(clk, R12);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;

end

endmodule