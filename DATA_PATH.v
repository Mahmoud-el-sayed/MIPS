module DATA_PATH #(parameter WIDTH=32)
( 
  output wire     [15:0]    test_value_wire,
  output wire     [5:0]     istr_opcode_wire, //checked
  output wire     [5:0]     istr_FUNCT_wire , //checked
  input  wire     [2:0]     alu_control_wire,
  input  wire               clk_wire,  //checked
  input  wire               rst_wire,  //checked
  input  wire               REG_write_wire,
  input  wire               MEM_write_wire,
  input  wire               REG_DST_wire,
  input  wire               ALU_SRC_wire,
  input  wire               MemtoReg_wire,
  input  wire               Branch_wire,
  input  wire               jump_wire,
  input  wire               pcsr,
  output wire               zero_wire
);

 
 wire   [WIDTH-1:0]  scrB_MUX1_wire ;
 wire   [WIDTH-1:0]  scrA_RD1_wire ;
 wire   [WIDTH-1:0]  ALU_RESULT_A_DATA_MAMORY_wire ;
 wire   [WIDTH-1:0]  RD_DATA_IN_MUX2_wire ;    
 wire   [WIDTH-1:0]  PC_PLUS_FOUR_PC_Input_wire ;   
 wire   [WIDTH-1:0]  PC_OUT_wire ;                  //checked
 wire   [WIDTH-1:0]  RD2_WD_wire ; 
 wire   [WIDTH-1:0]  IN_MUX1_signimm_wire ;
 wire   [WIDTH-1:0]  WD3_out_mux2_wire ;
 wire   [WIDTH-1:0]  out_shift_branch_wire;
 wire   [WIDTH-1:0]  out_branch_adder_Mux3_wire;
 wire   [WIDTH-1:0]  input_PC_adder_Mux4_wire;     //checked
 wire   [WIDTH-1:0]  out_mux3_wire;
 wire   [25:0]       outjump_wire;
 wire   [4:0]        A3_MUX0_OUT_wire;
 wire   [19:0]       instr_wire ;          //checked
 

 PC #(.WIDTH(WIDTH)) pc_i 
 (
 .pc_input(input_PC_adder_Mux4_wire), //checked
 .clk(clk_wire), //checked
 .rst(rst_wire), //checked
 .pc_output(PC_OUT_wire)  //checked
 );


INSTRUCTION_MEMORY #(.WIDTH(WIDTH)) INSTRUCTION_MEMORY_i 
 (
 .A(PC_OUT_wire), //checked
 .instr({istr_opcode_wire,instr_wire,istr_FUNCT_wire}) //checked
 );


REGISTER_FILE #(.WIDTH(WIDTH)) REGISTER_FILE_i 
 (
 .RD1(scrA_RD1_wire),
 .RD2(RD2_WD_wire),
 .clk(clk_wire),
 .rst(rst_wire),
 .WE3(REG_write_wire),
 .A1(instr_wire[19:15]),  //checked
 .A2(instr_wire[14:10]),   //checked
 .A3(A3_MUX0_OUT_wire),
 .WD3(WD3_out_mux2_wire)
 );

DATA_MEMORY #(.WIDTH(WIDTH)) DATA_MEMORY_i 
 (
 .RD(RD_DATA_IN_MUX2_wire),
 .WE(MEM_write_wire),
 .clk(clk_wire),
 .rst(rst_wire),
 .A(ALU_RESULT_A_DATA_MAMORY_wire),
 .WD(RD2_WD_wire),
 .test_value(test_value_wire)
 );

ALU #(.WIDTH(WIDTH)) ALU_i 
 (
 .scrA(scrA_RD1_wire),
 .scrB(scrB_MUX1_wire),
 .ALU_Control(alu_control_wire),
 .zero_flag(zero_wire),
 .ALU_RESULT(ALU_RESULT_A_DATA_MAMORY_wire)
 );


SIGN_EXTEND #(.WIDTH(WIDTH)) SIGN_EXTEND_i 
 (
 .instr({instr_wire[9:0],istr_FUNCT_wire}), //checked
 .Sign_IMM(IN_MUX1_signimm_wire)
 );

SHIFT_LEFT_TWICE #(.WIDTH(WIDTH)) SHIFT_LEFT_TWICE_i 
 (
 .in(IN_MUX1_signimm_wire),
 .out(out_shift_branch_wire)
 );
 
 SHIFT_LEFT_TWICE #(.WIDTH(26)) SHIFT_LEFT_TWICE_jump_i 
 (
 .in({instr_wire[19:0],istr_FUNCT_wire}), //checked
 .out(outjump_wire)
 );

ADDER #(.WIDTH(WIDTH)) ADDER_pc_add4_i 
 (
 .A(4), //checked
 .B(PC_OUT_wire), //checked
 .C(PC_PLUS_FOUR_PC_Input_wire)
 );
 
 ADDER #(.WIDTH(WIDTH)) ADDER_pc_Branch_i 
 (
 .A(out_shift_branch_wire),
 .B(PC_PLUS_FOUR_PC_Input_wire),
 .C(out_branch_adder_Mux3_wire)
 );
//mux with sel=regdst
MUX #(.WIDTH(5)) MUX_0 
 (
 .IN1(instr_wire[14:10]), //checked
 .IN2(instr_wire[9:5]),    //checked
 .OUT(A3_MUX0_OUT_wire),
 .sel(REG_DST_wire)
 ); 
//mux with sel=alusrc
MUX #(.WIDTH(WIDTH)) MUX_1 
 (
 .IN1(RD2_WD_wire),
 .IN2(IN_MUX1_signimm_wire),
 .OUT(scrB_MUX1_wire),
 .sel(ALU_SRC_wire)
 ); 

//mux with sel=MEMTOREg
MUX #(.WIDTH(WIDTH)) MUX_2
 (
 .IN1(ALU_RESULT_A_DATA_MAMORY_wire),
 .IN2(RD_DATA_IN_MUX2_wire),
 .OUT(WD3_out_mux2_wire),
 .sel(MemtoReg_wire)
 ); 
 
 //mux with sel=PCSR (ie zero&branch)
MUX #(.WIDTH(WIDTH)) MUX_3
 (
 .IN1(PC_PLUS_FOUR_PC_Input_wire),
 .IN2(out_branch_adder_Mux3_wire),
 .OUT(out_mux3_wire),
 .sel(pcsr) 
 ); 
 
  //mux with sel=jump (ie zero&branch)
MUX #(.WIDTH(WIDTH)) MUX_4
 (
 .IN1(out_mux3_wire),
 .IN2({PC_PLUS_FOUR_PC_Input_wire[31:28],2'b00,outjump_wire}),
 .OUT(input_PC_adder_Mux4_wire),//input_PC_adder_Mux3_wire
 .sel(jump_wire)
 ); 

endmodule