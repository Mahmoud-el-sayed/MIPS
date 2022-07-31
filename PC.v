module PC #(parameter WIDTH=32) 
(
input  wire  [WIDTH-1:0]  pc_input,
input  wire               clk,
input  wire               rst,
output reg   [WIDTH-1:0]  pc_output 
);

 always@(posedge clk or negedge rst)
  begin
    if (!rst)
      begin
        pc_output<=32'b0;
      end
    else
      begin
        pc_output<=pc_input;
      end
  end
  
endmodule