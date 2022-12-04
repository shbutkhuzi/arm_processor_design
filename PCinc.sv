module PCinc(
	input [31:0] old_address,
	output [31:0] new_address
);

assign new_address = old_address + 4;

endmodule