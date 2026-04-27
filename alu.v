module alu(in1,in2,op_code,result,zero);

input [31:0] in1,in2;
input [3:0] op_code;
output reg [31:0] result;
output zero;

always @(*) begin
    case (op_code)
        4'b0000 : result = in1 & in2; //and
        4'b0001 : result = in1 | in2; //or
        4'b0010 : result = in1 + in2; //add
        4'b0110 : result = in1 - in2; //sub
        4'b0111 : result = (in1 < in2) ? 1 : 0; //slt
        4'b1100 : result = ~(in1 | in2); //nor
        default: begin
            result = 0;
        end
    endcase
end

assign zero = (result == 0) ? 1 : 0;

endmodule