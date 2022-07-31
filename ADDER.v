module ADDER #(parameter WIDTH =32)
(
input  wire  [WIDTH-1:0]           A,
input  wire  [WIDTH-1:0]           B,
output reg   [WIDTH-1:0]           C 
);

 always @(*)
  begin
   C=A+B;                                 
  end
endmodule







