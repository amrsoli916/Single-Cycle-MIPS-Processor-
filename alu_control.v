module alu_control(aluop0, aluop1, funct, alu_control_out);

input aluop0, aluop1;
input [5 : 0] funct;
output reg [3 : 0] alu_control_out;

always @(*) begin
    casex ({aluop1,aluop0,funct})
        // lw & sw
        8'b00xxxxxx : alu_control_out = 4'b0010; //add
        // beq
        8'bx1xxxxxx : alu_control_out = 4'b0110; //sub
        // R-type
        8'b1x100000 : alu_control_out = 4'b0010; //add
        8'b1x100010 : alu_control_out = 4'b0110; //sub
        8'b1x100100 : alu_control_out = 4'b0000; //and
        8'b1x100101 : alu_control_out = 4'b0001; //or
        8'b1x101010 : alu_control_out = 4'b0111; //slt
        default: begin
          alu_control_out = 4'b0000;
        end
    endcase
end

endmodule

 