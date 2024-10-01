`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 03:01:02 AM
// Design Name: 
// Module Name: bcd_conveter_top_tb
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


module bcd_conveter_top_tb;
    
    // Inputs
    reg clk;
    reg [4:0] sw;

    // Outputs
    wire [3:0] an;
    wire [6:0] seg;

    // Instantiate the top module
    bcd_converter_top uut (
        .clk(clk),
        .sw(sw),
        .an(an),
        .seg(seg)
    );
    always #2 clk <= ~clk;
    
    initial begin
        clk = 0;
        sw <= 'b0100;
        #100
        sw <= 'b1000;
        #100
        sw <= 'b0000;
    end
    
endmodule
