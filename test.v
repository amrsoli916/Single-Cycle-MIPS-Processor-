module tb();

reg clk;
reg rst;

// instantiate processor
top_module uut (
    .clk(clk),
    .rst(rst)
);

// clock generation
always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    #10;
    rst = 0;

    #200;

    $stop;

end

endmodule