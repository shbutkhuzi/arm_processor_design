module Y_mux(
	input [3:0] ARd,
	input select,
	output reg [3:0] out
);

always_comb begin
	case(select)
		0: 		out = ARd;
		1: 		out = 15;
		default: out = 0;
	endcase
end

endmodule