`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 04:18:11 AM
// Design Name: 
// Module Name: tb_clk_div
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

module tb_clk_div;

    // Testbench signals
    reg C;          // Input clock signal
    wire C_dvi;     // Output divided clock signal

    // Instantiate the clk_div module
    clk_div uut (
        .C(C),
        .C_dvi(C_dvi)
    );

    // Generate a clock signal with a period of 10 time units
    initial begin
        C = 0;
        forever #5 C = ~C; // Toggle every 5 time units
    end

    // Monitor the signals
    initial begin
        $monitor("Time: %0t, C: %b, C_dvi: %b", $time, C, C_dvi);
        
        // Run the simulation for 50 time units
        #50;
        $finish;
    end
endmodule