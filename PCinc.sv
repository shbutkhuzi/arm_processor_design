module PCinc(
	input clk,
	input [31:0] old_address,
	output reg [31:0] new_address
);

assign new_address = old_address + 4;

endmodule