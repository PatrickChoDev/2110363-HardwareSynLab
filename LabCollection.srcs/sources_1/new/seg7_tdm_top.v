`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 10:39:14 AM
// Design Name: 
// Module Name: seg7_tdm_top
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


module seg7_tdm_top(
    input wire clk,       // 100 MHz clock input
    input wire rst,       // Asynchronous reset
    output wire [3:0] an, // Anodes for 7-segment displays
    output wire [6:0] seg // Segments for 7-segment displays
);
    wire clk_div1; // Divided clock signal

    // Instantiate clock divider
    clk_div clk_div_inst (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_div1)
    );

    // Instantiate seven_segment_tdm
    seg7_tdm tdm_inst (
        .clk(clk_div1),
        .rst(rst),
        .hex_data(16'hF999), // Hardcoded 16-bit hex value
        .an(an),
        .seg(seg)
    );
endmodule