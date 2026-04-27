module mux #(parameter size = 32) (in1,in2,select,out);

input [size-1 : 0] in1, in2;
input select;

output [size-1 : 0] out;

assign out = (select) ? in1 : in2;

endmodule