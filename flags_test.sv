module flags_test();

logic clk;
logic update_flags;
logic [3:0] new_flags, old_flags;

flags flags_tst(update_flags, new_flags, old_flags);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	update_flags = 0;
	new_flags = 4'b1001;
	
	#4 update_flags = 1;
	#5 new_flags = 4'b0110;
	#4 update_flags = 0;
	#10 new_flags = 4'b1100;
	#4  update_flags = 1;
	
end

endmodule