`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 01:59:56 PM
// Design Name: 
// Module Name: seg_counter_top
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

module seg_counter_top(
    input wire clk,             // 100 MHz clock from the board
    input wire rst,             // Reset button
    input wire btnU,            // Button to set to 9999
    input wire btnC,            // Button to reset to 0000
    input wire [7:0] sw,             // Switch to count up by 1000
    output wire [3:0] an,      // Anodes for 7-segment displays
    output wire [6:0] seg      // Segment output for 7-segment displays
);
    // Instantiate the seg_counter module
    seg_counter uut (
        .clock(clk),
        .reset(rst),
        .switches(sw),
        .BTNU(btnU),
        .BTNC(btnC),
        .seg(seg),
        .an(an)
    );

endmodule

