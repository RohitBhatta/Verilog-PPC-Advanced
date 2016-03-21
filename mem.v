module mem(
    input clk,
    input readEn0,
    input [63:3] readAddr0,
    output [63:0] readData0,
    input readEn1,
    input [63:3] readAddr1,
    output [63:0] readData1,
    input writeEn,
    input [63:3] writeAddr,
    input [63:0] writeData);

    // memory
    reg [63:0]memory[0:1023];

    initial begin
        $readmemh("mem.bin",memory);
    end

    reg [63:0]d0;
    reg [63:0]d1;

    assign readData0 = d0;
    assign readData1 = d1;

    always @(posedge clk) begin
        if (writeEn) memory[writeAddr] <= writeData;
        if (readEn0) d0 <= memory[readAddr0];
        if (readEn1) d1 <= memory[readAddr1];
    end
    
endmodule
