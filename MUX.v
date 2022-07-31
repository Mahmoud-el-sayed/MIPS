module MUX #(parameter WIDTH =32)
(
input  wire  [WIDTH-1:0]           IN1,
input  wire  [WIDTH-1:0]           IN2,
output reg   [WIDTH-1:0]           OUT,
input  wire                        sel 
);

 always @(*)
  begin
   if(sel) 
    begin
      OUT=IN2;
    end
  else
    begin
      OUT=IN1;
    end                                  
  end
endmodule









