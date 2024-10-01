`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 12:58:24 AM
// Design Name: 
// Module Name: seg7_stack_top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg7_stack_top_tb;

    // Inputs
    reg clk;
    reg btn_push;
    reg btn_pop;
    reg btn_reset;
    reg [7:0] sw;

    // Outputs
    wire [3:0] an;
    wire [6:0] seg;

    // Instantiate the top module
    seg7_stack_top uut (
        .clk(clk),
        .btnU(btn_push),
        .btnC(btn_pop),
        .btnD(btn_reset),
        .sw(sw),
        .an(an),
        .seg(seg)
    );

    // Clock generation
    always begin
        #10 clk = ~clk;  // Generate a clock with a period of 10ns (100 MHz)
    end

    initial begin
        // Initialize inputs
        clk = 0;
        btn_push = 0;
        btn_pop = 0;
        btn_reset = 0;
        sw = 8'b00000000;

        // Reset the system
        btn_reset = 1;
        #2000000;
        btn_reset = 0;
        #20000000;
        
        btn_push = 1;
        #10000000;
        btn_push = 0;
        #100000000;

        // Push some values onto the stack
        sw = 8'hAA;  // First value to push (0xAA)
        btn_push = 1;
        #10000000;
        btn_push = 0;
        #100000000;

        sw = 8'hBB;  // Second value to push (0xBB)
        btn_push = 1;
        #10000000;
        btn_push = 0;
        #100000000;

        sw = 8'hCC;  // Third value to push (0xCC)
        btn_push = 1;
        #10000000;
        btn_push = 0;
        #100000000;

        // Pop a value from the stack
        btn_pop = 1;
        #10000000;
        btn_pop = 0;
        #100000000;

        // Push another value onto the stack
        sw = 8'hDD;  // Fourth value to push (0xDD)
        btn_push = 1;
        #10000000;
        btn_push = 0;
        #100000000;
        
        sw = 8'hDE;  // Fourth value to push (0xDE)
        btn_push = 1;
        #10000000;
        btn_push = 0;
        #100000000;
        
        sw = 8'h12;  // Fourth value to push (0xDE)
        btn_push = 1;
        #10000000;
        btn_push = 0;
        #100000000;

        // Pop all values from the stack
        btn_pop = 1;
        #10000000;
        btn_pop = 0;
        #100000000;

        btn_pop = 1;
        #10000000;
        btn_pop = 0;
        #100000000;

        btn_pop = 1;
        #10000000;
        btn_pop = 0;
        #100000000;
        
        btn_reset = 1;
        #10000000;
        btn_reset = 0;
        #100000000;

        // Finish simulation
        $finish;
    end

endmodule
