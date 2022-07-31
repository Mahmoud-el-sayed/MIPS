module DATA_MEMORY #(parameter WIDTH=32 ) 
(
output reg  [WIDTH-1:0]    RD,
input  wire                clk,
input  wire                rst,
input  wire                WE, 
input  wire [WIDTH-1:0]    A,
input  wire [WIDTH-1:0]    WD,
output reg  [15:0]         test_value 
);

 reg [WIDTH-1:0] Data_memory [0:WIDTH-1];
 integer i; 
 always @(posedge clk or negedge rst)
  begin
     if(!rst)
       begin
         for(i=0;i<'d32;i=i+1)
          begin
            Data_memory[i]<=32'b0;
          end
        end
     else if(WE)
       begin
        Data_memory[A]<=WD;
       end 
    else
      begin
       Data_memory[A]<=Data_memory[A];
      end
  end
  
  
   always @(*)
  begin
     RD=Data_memory[A];
  end

  always @(*)
  begin
     test_value=Data_memory[0];
  end

  
endmodule

