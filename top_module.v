module top_module(rst,clk);
parameter size = 32;
input rst, clk;

wire[size-1 : 0] instr;
wire [size-1 : 0] pc_out;
wire [31 : 0] read_data1, read_data2,alusrc_out,result,out_extend,read_data_from_mem,result_from_memtoreg_mux;
wire [31 : 0] out_for_alu_plus4,result_for_brunch,result_for_brunch_mux,jump_concatenation,final_pc_result;
wire [3 : 0] alu_control_out;
wire [4 : 0] write_reg;
wire regwrite,regdst,alusrc,memtoreg,memwrite,branch,aluop0,aluop1,jump,zero;
//instantiate the program counter
pc pc_inst (.in(final_pc_result), .rst(rst), .clk(clk), .out(pc_out));
//instantiate the instruction memory
i_mem imem_inst (.addr(pc_out), .instr(instr));
//instantiate the alu_plus4
alu_plus4 alu_inst_plus (.in(pc_out), .out(out_for_alu_plus4));
//instantiate the register file
register_file reg_file(.read_reg1(instr[25:21]), .read_reg2(instr[20:16]), .clk(clk), .rst(rst), 
                       .write_reg(write_reg), .write_data(result_from_memtoreg_mux), .reg_write(regwrite),
                        .read_data1(read_data1), .read_data2(read_data2));
             
//instantiate the control unit
control control_ist(.in(instr[31:26]), .regdst(regdst), .alusrc(alusrc), .memtoreg(memtoreg),
                    .regwrite(regwrite), .memwrite(memwrite),
                    .branch(branch), .aluop0(aluop0), .aluop1(aluop1), .jump(jump));

//instantiate the mux for regdst
mux #(.size(5)) mux_regdst(.in1(instr[15:11]), .in2(instr[20:16]), .select(regdst), .out(write_reg));

//instantiate the alu control unit
alu_control alu_control_inst(.aluop0(aluop0), .aluop1(aluop1), .funct(instr[5:0]), 
                              .alu_control_out(alu_control_out));

//instantiate the alusrc mux
mux #(.size(32)) mux_alusrc(.in1(out_extend), .in2(read_data2), .select(alusrc), .out(alusrc_out));

//instantiate the alu
alu alu_inst(.in1(read_data1), .in2(alusrc_out), .op_code(alu_control_out), .result(result), .zero(zero));

//instantiate the sign extend unit
sign_extend sign_extend_inst(.in(instr[15:0]) , .out(out_extend));

//instantiate the data memory
data_memory data_memory_ins(.address(result), .write_data(read_data2), .memwrite(memwrite)
                             , .clk(clk), .rst(rst), .read_data(read_data_from_mem));

//instantiate the mux to select from mem or not
mux #(.size(32)) mux_memtoreg(.in1(read_data_from_mem), .in2(result), .select(memtoreg)
                                , .out(result_from_memtoreg_mux));

//result for the alu to calculate the pc from instruction brunch
assign result_for_brunch = out_for_alu_plus4 + (out_extend) << 2;

//instantiate the mux to select brunch or not
mux #(.size(32)) mux_brunch(.in1(result_for_brunch), .in2(out_for_alu_plus4),
                        .select(branch & zero), .out(result_for_brunch_mux));

//result for concatenation for the instruction jumb
assign jump_concatenation = {(instr[25:0])<<2 , out_for_alu_plus4[31:28]};

//instantiate the mux to select jump or not
mux #(.size(32)) jump_mux(.in1(jump_concatenation), .in2(result_for_brunch_mux),
                        .select(jump), .out(final_pc_result));
endmodule
