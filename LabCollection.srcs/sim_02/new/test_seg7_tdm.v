`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 11:29:37 AM
// Design Name: 
// Module Name: test_seg7_tdm
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


module test_seg7_tdm;
    reg clk;
    reg rst;
    wire [3:0] an;
    wire [6:0] seg;

    seg7_tdm uut (
        .clk(clk),
        .rst(rst),
        .hex_data(16'h0000),
        .an(an),
        .seg(seg)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #20;
        rst = 0;
        #1000000;
        $finish;
    end

    initial begin
        $monitor("Time = %0d ns | an = %b | seg = %b | Displayed Hex = %h", $time, an, seg, hex_display(seg));
    end

    function [3:0] hex_display;
        input [6:0] seg_pattern;
        case (seg_pattern)
            7'b0111111: hex_display = 4'h0;
            7'b0000110: hex_display = 4'h1;
            7'b1011011: hex_display = 4'h2;
            7'b1001111: hex_display = 4'h3;
            7'b1100110: hex_display = 4'h4;
            7'b1101101: hex_display = 4'h5;
            7'b1111101: hex_display = 4'h6;
            7'b0000111: hex_display = 4'h7;
            7'b1111111: hex_display = 4'h8;
            7'b1101111: hex_display = 4'h9;
            7'b1110111: hex_display = 4'hA;
            7'b1111100: hex_display = 4'hB;
            7'b0111001: hex_display = 4'hC;
            7'b1011110: hex_display = 4'hD;
            7'b1111001: hex_display = 4'hE;
            7'b1110001: hex_display = 4'hF;
            default:    hex_display = 4'hF;
        endcase
    endfunction
endmodule