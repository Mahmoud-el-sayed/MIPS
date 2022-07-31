module SIGN_EXTEND #(parameter WIDTH =32)
(
input  wire  [(WIDTH/2)-1:0]       instr,
output reg   [WIDTH-1:0]           Sign_IMM 
);

 always @(*)
  begin
    /*Sign_IMM={{16{instr[15]}},instr};*/
    Sign_IMM[15:0]=instr;
    Sign_IMM[31:16]={16{instr[15]}};                                   
  end
endmodule



