module alu_plus4(in, out);
parameter size = 32;
input [size-1 :0] in;
output [size-1 : 0] out;

assign out = in + 4;

endmodule