`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 04:39:58 AM
// Design Name: 
// Module Name: simple_calculator_top
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


module simple_calculator_top(
    input clk, 
    input [7:0] sw,     // switches
    input btnU,         // Button for addition
    input btnL,         // Button for subtraction
    input btnD,         // Button for multiplication
    input btnR,         // Button for division
    output [6:0] seg,
    output [3:0] an
);
    simple_calculator uut(
    .clk(clk), 
    .A(sw[7:4]),      // 4-bit input A
    .B(sw[3:0]),      // 4-bit input B
    .BTNU(btnU),         // Button for addition
    .BTNL(btnL),         // Button for subtraction
    .BTND(btnD),         // Button for multiplication
    .BTNR(btnR),         // Button for division
    .seg(seg),
    .an(an)
);
endmodule
