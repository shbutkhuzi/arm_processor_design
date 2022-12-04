module flags(
	input update_flags,
	input [3:0] new_flags,
	output reg [3:0] current_flags
);

initial current_flags = 0;

always @(posedge update_flags) begin
	current_flags = new_flags;
end

endmodule
