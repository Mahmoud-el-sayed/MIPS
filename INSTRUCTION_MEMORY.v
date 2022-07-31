module INSTRUCTION_MEMORY #(parameter WIDTH=32) 
(
input  wire  [WIDTH-1:0]  A,
output reg   [WIDTH-1:0]  instr
);

reg [WIDTH-1:0] ROM [0:WIDTH-1];

 initial
  begin
    $readmemh("GCD.txt",ROM);
  end
  
 always @(*)
  begin
     instr<=ROM[A>>2];
  end

  
endmodule
