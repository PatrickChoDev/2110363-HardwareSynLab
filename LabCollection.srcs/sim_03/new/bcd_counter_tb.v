`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 01:34:11 PM
// Design Name: 
// Module Name: bcd_counter_tb
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


module bcd_counter_tb;
    // Testbench signals
    reg up;                 // Up counting control
    reg down;               // Down counting control
    reg set9;               // Set counter to 9
    reg set0;               // Set counter to 0
    reg clock;              // Clock signal
    reg reset;              // Asynchronous reset
    wire [3:0] count;      // 4-bit counter output
    wire cout;             // Overflow output
    wire bout;             // Borrow output

    // Instantiate the BCD counter module
    bcd_counter uut (
        .up(up),
        .down(down),
        .set9(set9),
        .set0(set0),
        .clock(clock),
        .reset(reset),
        .count(count),
        .cout(cout),
        .bout(bout)
    );

    // Clock generation: 50 MHz clock (20 ns period)
    always begin
        #2 clock = ~clock; // Toggle clock every 10 ns
    end

    // Testbench logic
    initial begin
        // Initialize signals
        clock = 0;
        reset = 0;
        up = 0;
        down = 0;
        set9 = 0;
        set0 = 0;

        // Apply reset
        reset = 1;
        #20;  // Wait for 20 ns
        reset = 0;

        // Test case 1: Set to 9
        set9 = 1;
        #20;  // Wait for 20 ns
        set9 = 0;
        #40;  // Wait for 40 ns

        // Test case 2: Count up from 9
        up = 1;
        #20;  // Wait for 20 ns
        up = 0;
        #40;  // Wait for 40 ns

        // Test case 3: Count down from 0
        down = 1;
        #20;  // Wait for 20 ns
        down = 0;
        #40;  // Wait for 40 ns

        // Test case 4: Set to 0
        set0 = 1;
        #20;  // Wait for 20 ns
        set0 = 0;
        #40;  // Wait for 40 ns

        // Test case 5: Count up from 0
        up = 1;
        #20;  // Wait for 20 ns
        up = 0;
        #40;  // Wait for 40 ns

        // Test case 6: Count down from 9
        set9 = 1;
        #20;  // Wait for 20 ns
        set9 = 0;
        down = 1;
        #20;  // Wait for 20 ns
        down = 0;
        #40;  // Wait for 40 ns

        // End simulation
        $stop;
    end

endmodule
