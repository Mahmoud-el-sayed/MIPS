module SHIFT_LEFT_TWICE #(parameter WIDTH =16)
(
input  wire  [WIDTH-1:0]           in,
output reg   [WIDTH-1:0]           out 
);

 always @(*)
  begin
    out=in<<2;                                 
  end
endmodule





