module data_memory(address,write_data,memwrite,rst,clk,read_data);
parameter n = 32;

input [n-1 : 0] address, write_data;     //input
input memwrite, rst ,clk;               //input
output  [n-1 : 0] read_data;

reg [n-1 : 0] mem [255 : 0];
integer i;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i = 0; i <= 255 ; i = i + 1 ) begin
            mem[i] <= 0;      //reset all memory
        end
    end
    else if (memwrite) begin
        mem[address] <= write_data;
    end
end

assign read_data = mem[address];

endmodule