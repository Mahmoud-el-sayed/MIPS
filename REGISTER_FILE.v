module REGISTER_FILE #(parameter WIDTH=32 , parameter WIDTH_2=5) 
(
output reg  [WIDTH-1:0]    RD1,
output reg  [WIDTH-1:0]    RD2,
input  wire                clk,
input  wire                rst,
input  wire                WE3, 
input  wire [WIDTH_2-1:0]  A1,
input  wire [WIDTH_2-1:0]  A2,
input  wire [WIDTH_2-1:0]  A3,
input  wire [WIDTH-1:0]    WD3
);

 reg [WIDTH-1:0] register_file [0:WIDTH-1];
 integer i; 
 always @(posedge clk or negedge rst)
  begin
     if(!rst)
       begin
         for(i=0;i<'d32;i=i+1)
          begin
            register_file[i]<=32'b0;
          end
        end
     else if(WE3)
       begin
        register_file[A3]<=WD3;
       end 
    else
      begin
       register_file[A3]<=register_file[A3];
      end
  end
  
  
   always @(*)
  begin
     RD2=register_file[A2];
  end
  
  always @(*)
  begin
     RD1=register_file[A1];
  end
/* think in this
always @(*)
  begin
     RD1<=register_file[A1];
     RD2<=register_file[A2];
  end
*/
  
endmodule
