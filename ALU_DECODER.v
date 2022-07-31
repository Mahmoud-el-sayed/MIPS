module ALU_DECODER (
input  wire  [1:0]        ALU_OP,
input  wire  [5:0]        FUNCT,
output reg   [2:0]        ALU_CONTROL 
);

 always @(*)
  begin
     case(ALU_OP)
       3'b00:
              begin
                ALU_CONTROL=3'b010;
              end
       3'b01:
              begin
                ALU_CONTROL=3'b100;
              end
       3'b10:
              begin
                case(FUNCT)
                  6'b100000:
                             begin
                               ALU_CONTROL=3'b010;
                             end
                  6'b100010:
                             begin
                               ALU_CONTROL=3'b100;
                             end
                  6'b101010:
                             begin
                               ALU_CONTROL=3'b110;
                             end
                  6'b011100:
                             begin
                               ALU_CONTROL=3'b101;
                             end
                  default:
                             begin
                               ALU_CONTROL=3'b010;
                             end
                 endcase
                
              end
       default:
              begin
                ALU_CONTROL=3'b010;
              end                                       
      endcase     
  end
endmodule

