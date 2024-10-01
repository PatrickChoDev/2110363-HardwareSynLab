`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:04:33 PM
// Design Name: 
// Module Name: seg_counter_top_tb
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


module seg_counter_top_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg BTNU;
    reg BTNC;
    reg [7:0] sw;
    wire [3:0] an;
    wire [6:0] seg;

    // Instantiate the top module
    seg_counter_top uut (
        .clk(clk),
        .rst(rst),
        .btnU(BTNU),
        .btnC(BTNC),
        .sw(sw),
        .an(an),
        .seg(seg)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock, 10 ns period
    end

    // Test sequence
    initial begin
        // Initialize signals
        rst = 0;
        BTNU = 0;
        BTNC = 0;
        sw = 8'b00000000;

        // Apply reset
        rst = 1;
        #100;
        rst = 0;
        #100;

        // Test counting up by 1
        sw = 8'b00000001;  // Activate SW0 for counting up by 1
        #100;
        sw = 8'b00000000;  // Deactivate SW0
        #100;

        // Test counting down by 1
        sw = 8'b00000010;  // Activate SW1 for counting down by 1
        #100;
        sw = 8'b00000000;  // Deactivate SW1
        #100;

        // Test counting up by 10
        sw = 8'b00001000;  // Activate SW3 for counting up by 10
        #100;
        sw = 8'b00000000;  // Deactivate SW3
        #100;

        // Test counting down by 10
        sw = 8'b00000100;  // Activate SW2 for counting down by 10
        #100;
        sw = 8'b00000000;  // Deactivate SW2
        #100;

        // Test counting up by 100
        sw = 8'b00100000;  // Activate SW5 for counting up by 100
        #100;
        sw = 8'b00000000;  // Deactivate SW5
        #100;

        // Test counting down by 100
        sw = 8'b00010000;  // Activate SW4 for counting down by 100
        #100;
        sw = 8'b00000000;  // Deactivate SW4
        #100;

        // Test counting up by 1000
        sw = 8'b10000000;  // Activate SW7 for counting up by 1000
        #100;
        sw = 8'b00000000;  // Deactivate SW7
        #100;

        // Test counting down by 1000
        sw = 8'b01000000;  // Activate SW6 for counting down by 1000
        #100;
        sw = 8'b00000000;  // Deactivate SW6
        #100;

        // Test set to 9999
        BTNU = 1;
        #100;
        BTNU = 0;
        #100;

        // Test reset to 0000
        BTNC = 1;
        #100;
        BTNC = 0;
        #100;

        // Finish the simulation
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("At time %t: an = %b, seg = %b", $time, an, seg);
    end

endmodule