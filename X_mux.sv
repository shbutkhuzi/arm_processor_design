module X_mux(
	input [31:0] ALU_result,
	input [31:0] mem_data,
	input select,
	output reg [31:0] out
);

always_comb begin
	case(select)
		0: 		out = ALU_result;
		1: 		out = mem_data;
		default: out = 0;
	endcase
end

endmodule