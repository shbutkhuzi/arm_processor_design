module testbench();

logic clk;
logic [31:0] Rn;
logic [31:0] Rs;
logic [31:0] PC_out;
logic [1:0] select;
logic [31:0] out [0:2];
logic [3:0] ARd;

src1mux src1mux_test(Rn, Rs, PC_out, select, out[0]);
X_mux X_mux_test(Rn, Rs, select, out[1]);
Y_mux Y_mux_test(ARd, select, out[2]);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	Rn = 203;
	Rs = 104;
	PC_out = 184;
	select = 0;
	ARd = 13;
	
	#9 select = 1;
	#7 select = 2;

end

endmodule