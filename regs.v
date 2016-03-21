module regs(
    input clk,

    /* read port 0 */
    input readEn0,
    input [4:0] readAddr0,
    output [63:0] readData0,

    /* read port 1 */
    input readEn1,
    input [4:0] readAddr1,
    output [63:0] readData1,

    /* write port 0 */
    input writeEn0,
    input [4:0] writeAddr0,
    input [63:0] writeData0,

    /* write port 0 */
    input writeEn1,
    input [4:0] writeAddr1,
    input [63:0] writeData1
);

    // memory
    reg [63:0]memory[0:31];

    initial begin
        $readmemh("regs.bin",memory);
    end

    reg [63:0]d0;
    reg [63:0]d1;

    assign readData0 = d0;
    assign readData1 = d1;

    always @(posedge clk) begin
        if (readEn0) d0 <= memory[readAddr0];
        if (readEn1) d1 <= memory[readAddr1];
        if (writeEn0) memory[writeAddr0] <= writeData0;
        if (writeEn1) memory[writeAddr1] <= writeData1;
    end
    
endmodule
