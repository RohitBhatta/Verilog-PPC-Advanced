
module main();

    initial begin
        $dumpfile("ppc.vcd");
        $dumpvars(0,main);
    end

    wire clk;
    wire halt = 0;

    clock clock0(halt,clk);

    /********************/
    /* Memory interface */
    /********************/

    wire memReadEn0 = 0;
    wire [63:3]memReadAddr0;
    wire [63:0]memReadData0;

    wire memReadEn1 = 0;
    wire [63:3]memReadAddr1;
    wire [63:0]memReadData1;

    wire memWriteEn = 0;
    wire [63:3]memWriteAddr;
    wire [63:0]memWriteData;

    mem mem0(clk,
        memReadEn0,memReadAddr0,memReadData0,
        memReadEn1,memReadAddr1,memReadData1,
        memWriteEn,memWriteAddr,memWriteData);

    /********/
    /* regs */
    /********/

    wire regReadEn0 = 0;
    wire [4:0]regReadAddr0;
    wire [63:0]regReadData0;

    wire regReadEn1 = 0;
    wire [4:0]regReadAddr1;
    wire [63:0]regReadData1;


    wire regWriteEn0 = 0;
    wire [4:0]regWriteAddr0;
    wire [63:0]regWriteData0;

    wire regWriteEn1;
    wire [4:0]regWriteAddr1;
    wire [63:0]regWriteData1;

    regs gprs(clk,
       /* Read port #0 */
       regReadEn0,
       regReadAddr0, 
       regReadData0,

       /* Read port #1 */
       regReadEn1,
       regReadAddr1, 
       regReadData1,

       /* Write port #0 */
       regWriteEn0,
       regWriteAddr0, 
       regWriteData0,

       /* Write port #1 */
       regWriteEn1,
       regWriteAddr1, 
       regWriteData1
    );

endmodule
