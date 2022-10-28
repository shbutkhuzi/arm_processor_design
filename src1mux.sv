module src1mux(
	input [31:0] Rn,
	input [31:0] Rs,
	input [31:0] PC_out,
	input [1:0] select,
	output reg [31:0] out
);

always_comb begin
	case(select)
		0: 		out = Rn;
		1: 		out = Rs;
		2: 		out = PC_out;
		default: out = 0;
	endcase
end	

endmodule