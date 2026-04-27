module i_mem(addr, instr);

parameter size = 32; //size of the instruction
parameter mem_size = 256; //size of the instruction memory
parameter base_addr = 32'b000000; //base address for the first instruction

input [size-1 : 0] addr;
output [size-1 : 0] instr;

reg [size-1 : 0] mem [0 : mem_size-1];

initial begin
    $readmemh("imem.mem", mem);
end

assign instr = mem[(addr - base_addr) >> 2];

endmodule