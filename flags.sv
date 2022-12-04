module flags(
	input update_flags,
	input [3:0] new_flags,
	output reg [3:0] current_flags
);

always @(posedge update_flags) begin
	current_flags = new_flags;
end

endmodule
