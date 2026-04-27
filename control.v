module control(in,regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop0,jump,aluop1);
input [5:0] in;
output reg regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop0,jump,aluop1;

always @(*) begin
    casex (in)
            // R-type
            6'b000000 : begin
              {regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop1,aluop0,jump} = 9'b100100100;
            end
            // lw
            6'b100011 : begin
              {regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop1,aluop0,jump} = 9'b011100000;
            end
            // sw
            6'b101011 : begin
              {regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop1,aluop0,jump} = 9'bx1x010000;
            end
            // beq
            6'b000100 : begin
              {regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop1,aluop0,jump} = 9'bx0x001010;
            end
            //addi
            6'b001000 : begin
              {regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop1,aluop0,jump} = 9'b010100000;
            end
            //jump
            6'b000010 : begin
              {regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop1,aluop0,jump} = 9'bxxx00xxx1;
            end

            default : begin
              {regdst,alusrc,memtoreg,regwrite,memwrite,branch,aluop1,aluop0,jump} = 9'b000000000;
            end
                
    endcase
end

endmodule