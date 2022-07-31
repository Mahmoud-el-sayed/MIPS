module ALU #(parameter WIDTH=32) 
(
input  wire  [WIDTH-1:0]  scrA,
input  wire  [WIDTH-1:0]  scrB,
input  wire  [2:0]        ALU_Control,
output wire               zero_flag,
output reg   [WIDTH-1:0]  ALU_RESULT
);

  
 always @(*)
  begin
     case(ALU_Control)
       3'b000:
              begin
                ALU_RESULT=scrA&scrB;
              end
       3'b001:
              begin
                ALU_RESULT=scrA|scrB;
              end
       3'b010:
              begin
                ALU_RESULT=scrA+scrB;
              end
       3'b100:
              begin
                ALU_RESULT=scrA-scrB;
              end   
       3'b101:
              begin
                ALU_RESULT=scrA*scrB;
              end   
       3'b110:
              begin
                ALU_RESULT=(scrA<scrB);
              end    
       default:
              begin
                ALU_RESULT='b0;
              end                                       
      endcase     
  end

  assign zero_flag=(ALU_RESULT=='b0);
endmodule

