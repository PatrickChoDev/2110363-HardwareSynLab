`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 11:54:50 AM
// Design Name: 
// Module Name: seven_segment_display_top
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


module seven_segment_display_top(
    input wire clk,       // 100 MHz clock input
    input wire rst,       // Asynchronous reset
    output wire [3:0] an, // Anodes for 7-segment displays
    output wire [6:0] seg // Segments for 7-segment displays
);

    // Instantiate seven_segment_tdm
    seven_segment_display #(
        .MODE("DEC"),    // You can switch this to "DEC" to test decimal mode
        .ZERO_OFF(1),
        .FIXED_DISPLAY(0) // Display all 4 digits
    ) uut (
        .clk(clk),
        .hex_data('hf70),
        .rst(rst),
        .an(an),
        .seg(seg)
    );
endmodule
