module register_file(read_reg1, read_reg2, write_reg, write_data, reg_write, clk, rst, read_data1, read_data2);

input [4:0] read_reg1, read_reg2, write_reg;    // 5 bits to address 32 regitsers
input [31:0] write_data;                        //32 bit data to write into the register
input reg_write, clk, rst;                      

output reg [31:0] read_data1, read_data2;   // 32 bit data read from the rsgisters
reg [31:0] reg_file [31:0];   
integer i;

always @(posedge clk or posedge rst) begin
    if(rst)begin
      for (i =0 ; i <32 ; i = i + 1) begin
        reg_file[i] <= 0;   // reset all register to 0
      end
    end
    else if(reg_write) begin
        reg_file[write_reg] <= write_data;  // write data to the register if reg_write is high
    end
end

always @(*) begin
    read_data1 = reg_file[read_reg1];    // read data from the register specified by read_reg1
    read_data2 = reg_file[read_reg2];    // read data from the register specified by read_reg2 
end

endmodule