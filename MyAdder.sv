// Code your design here
module MyAdder
#(
    parameter bitwidth = 32
)(
    //input clk,
    input [bitwidth-1:0] A, B,
    output [bitwidth-1:0] S,
    output Cout
);
//you can change this two lines
  wire [15:0] Adder_S0;
  wire [15:0] Adder_S1;
  wire Cout_middle, C0, C1;

//your code should start from here, don't touch inputs, don't touch other modules
  
  CLA_16bit CLA_16_inst(A[15:0], B[15:0], 0, S[15:0], Cout_middle);
  CLA_16bit CLA_16_inst0(A[31:16], B[31:16], 0, Adder_S0, C0);
  CLA_16bit CLA_16_inst1(A[31:16], B[31:16], 1, Adder_S1, C1);
  
  mux2_16 mux2_16_inst(Adder_S1, Adder_S0, Cout_middle, S[31:16]);
  mux2    mux2_inst   (C1, C0, Cout_middle, Cout);
  
//your code should end here


//but you can also change this two lines
endmodule


module HA(
    input a,b,
    output s, cout
);
    assign s=a^b;
    assign cout=a&b;
endmodule

module FA (
    input a,b,cin,
    output s,cout
    );
    wire xor1;
    assign xor1 = a^b;
    assign s = xor1^cin;
    assign cout = xor1&cin | a&b;
endmodule

module CLA_4bit(
  input [3:0] A, B,
  input Cin,
  output [3:0] S,
  output Cout
);
  wire [4:0] C;
  wire [3:0] G;
  wire [3:0] P;
  wire [3:0] S_out, FA_cout;
  
  assign C[0] = Cin;
  genvar i;
  generate
    for(i = 0; i < 4; i = i+1) begin :name
      HA HA_instant(A[i], B[i], P[i], G[i]);
      assign C[i+1] = G[i] | C[i]&P[i];
      FA FA_instant(A[i], B[i], C[i], S_out[i], FA_cout[i]);
    end
  endgenerate
  
  assign S = S_out;
  assign Cout = C[4];
  
endmodule

module CLA_16bit(
  input [15:0] A, B,
  input Cin,
  output [15:0] S,
  output Cout
);
  wire [3:0] C;
  
  CLA_4bit CLA_4_inst0(A[3:0],   B[3:0],   Cin,  S[3:0],   C[0]);
  CLA_4bit CLA_4_inst1(A[7:4],   B[7:4],   C[0], S[7:4],   C[1]);
  CLA_4bit CLA_4_inst2(A[11:8],  B[11:8],  C[1], S[11:8],  C[2]);
  CLA_4bit CLA_4_inst3(A[15:12], B[15:12], C[2], S[15:12], C[3]);
  
  assign Cout = C[3];
  
endmodule

module mux2(
  input A, B,
  input s,
  output Y
);
  
  assign Y = s ? A : B;  
endmodule

module mux2_16(
  input [15:0] A, B,
  input s,
  output [15:0] Y
);
  
  assign Y = s ? A : B;  
endmodule