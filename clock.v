module clock(
    input halt,
    output clk
);

    //
    // The clock -- sumulation only
    //
    reg theClock = 0;

    assign clk = theClock;

    always begin
        #1;
        theClock = ~clk;
    end

    // cycle counter
    reg [15:0]cycles = 0;

    always @(posedge clk) begin
        if (halt) begin
            $display("=== %d",cycles);
            $finish;
        end
        if (cycles == 10000) begin
            $display("ran for 10000 cycles");
            $finish;
        end
        cycles <= cycles + 1;
    end

endmodule
