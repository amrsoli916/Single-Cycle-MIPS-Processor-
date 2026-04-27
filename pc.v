module pc(in,out,rst,clk);
//size of thee instruction
parameter size = 32;
//base address for the first instruction 
parameter base_addr = 32'b000000;

input rst,clk; //two control signals, rst is for reset, clk is for clock
input [size - 1 : 0] in; //input is the address to be loaded into the program counter
output reg [size-1 : 0] out; //output is the current value of the program counter

always @(posedge clk) begin
    if (rst) begin
      out <= base_addr;
    end
    else begin
      out <= in;
    end
end

endmodule