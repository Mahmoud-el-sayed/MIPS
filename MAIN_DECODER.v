module MAIN_DECODER  (
input  wire  [5:0]  opcode,
output reg          jump,
output reg          MemtoReg,
output reg          MemtoWrite,
output reg          Branch,
output reg          ALUSrc,
output reg          RegDst,
output reg          RegWrite,
output reg   [1:0]  ALUOP,
input  wire          zero,
output wire          pcsr 
);

  
 always @(*)
  begin
     case(opcode)
       6'b000000:
              begin
                RegWrite=1'b1;
                RegDst=1'b1;
                ALUSrc=1'b0;
                Branch=1'b0;
                MemtoWrite=1'b0;
                MemtoReg=1'b0;
                ALUOP=2'b10;
                jump=1'b0; 
              end   
       6'b100011:
              begin
                RegWrite=1'b1;
                RegDst=1'b0;
                ALUSrc=1'b1;
                Branch=1'b0;
                MemtoWrite=1'b0;
                MemtoReg=1'b1;
                ALUOP=2'b00;
                jump=1'b0; 
              end  
       6'b101011:
              begin
                RegWrite=1'b0;
                RegDst=1'b0;
                ALUSrc=1'b1;
                Branch=1'b0;
                MemtoWrite=1'b1;
                MemtoReg=1'b1;
                ALUOP=2'b00;
                jump=1'b0; 
              end  
        6'b000100:
              begin
                RegWrite=1'b0;
                RegDst=1'b0;
                ALUSrc=1'b0;
                Branch=1'b1;
                MemtoWrite=1'b0;
                MemtoReg=1'b0;
                ALUOP=2'b01;
                jump=1'b0; 
              end  
        6'b001000:
              begin
                RegWrite=1'b1;
                RegDst=1'b0;
                ALUSrc=1'b1;
                Branch=1'b0;
                MemtoWrite=1'b0;
                MemtoReg=1'b0;
                ALUOP=2'b00;
                jump=1'b0; 
              end  
       6'b000010:
              begin
                RegWrite=1'b0;
                RegDst=1'b0;
                ALUSrc=1'b0;
                Branch=1'b0;
                MemtoWrite=1'b0;
                MemtoReg=1'b0;
                ALUOP=2'b00;
                jump=1'b1; 
              end 
       6'b100011:
              begin
                RegWrite=1'b1;
                RegDst=1'b0;
                ALUSrc=1'b1;
                Branch=1'b0;
                MemtoWrite=1'b0;
                MemtoReg=1'b1;
                ALUOP=2'b00;
                jump=1'b0; 
              end  
         default:
              begin
                RegWrite=1'b0;
                RegDst=1'b0;
                ALUSrc=1'b0;
                Branch=1'b0;
                MemtoWrite=1'b0;
                MemtoReg=1'b0;
                ALUOP=2'b00;
                jump=1'b0;
              end                                       
      endcase     
  end

  assign pcsr=zero&Branch;

endmodule

