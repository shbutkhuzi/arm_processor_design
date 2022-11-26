module PCinc_test();

logic clk;
logic [31:0] old_add;
logic [31:0] new_add;
logic wen_ARd;
logic [3:0] ARn, ARs, ARm, ARd;
logic [31:0] Rn, Rs, Rm, Rd, Rd_data, PC_out, PC_next;

PCinc PCinc_tst(clk, old_add, new_add);
reg_file reg_file_tst(clk, wen_ARd, ARn, ARs, ARm, ARd, Rn, Rs, Rm, Rd, Rd_data, old_add, new_add);

always begin 
 #1 clk = ~clk;
end

initial begin
	clk = 0;
	

end

endmodule