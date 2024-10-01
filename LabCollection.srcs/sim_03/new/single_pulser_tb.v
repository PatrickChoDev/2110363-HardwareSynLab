`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 01:22:24 PM
// Design Name: 
// Module Name: single_pulser_tb
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


module single_pulser_tb;
    reg clock;
    reg trigger;
    wire pulse;


    // Instantiate the Single Pulser
    single_pulser uut (
        .clock(clock),
        .trigger(trigger),
        .pulse(pulse)
    );

    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // 100 MHz clock
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        trigger = 0;

        // Wait for a few clock cycles
        #8;

        // Apply trigger
        trigger = 1;
        #24;  // Pulse width
        trigger = 0;
        #16;

        // Wait and check pulse width
        #20;
        
        // Apply another trigger
        trigger = 1;
        #10;  // Pulse width
        trigger = 0;
        #20;

        // End simulation
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor("Time=%0d, pulse=%b, trigger=%b", $time, pulse, trigger);
    end

endmodule
