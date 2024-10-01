`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 10:35:55 AM
// Design Name: 
// Module Name: seg7_tdm
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


module seg7_tdm(
input wire clk,            // Divided clock input
    input wire rst,            // Asynchronous reset
    input wire [15:0] hex_data,// 16-bit hexadecimal input
    output reg [3:0] an,       // Anodes for 7-segment displays
    output reg [6:0] seg       // Segment output for 7-segment displays
);
    reg [1:0] digit_sel;       // Selector for current digit
    reg [3:0] digit;           // Current digit to be displayed

    wire [6:0] seg_out;        // Output from hex_to_7seg module

    // Instantiate hex_to_7seg
    hex_seg7_enc encoder (
        .hex(digit),
        .seg(seg_out)
    );
    
    initial begin
        digit_sel <= 0;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            digit_sel <= 0;
        end else begin
            digit_sel <= digit_sel + 1;
        end
    end

    always @(*) begin
        case(digit_sel)
            2'b00: begin
                an = 4'b1110; // Enable first digit
                digit = hex_data[3:0];
            end
            2'b01: begin
                an = 4'b1101; // Enable second digit
                digit = hex_data[7:4];
            end
            2'b10: begin
                an = 4'b1011; // Enable third digit
                digit = hex_data[11:8];
            end
            2'b11: begin
                an = 4'b0111; // Enable fourth digit
                digit = hex_data[15:12];
            end
            default: begin
                an = 4'b1111; // Disable all
                digit = 4'h0;
            end
        endcase
        seg = seg_out;
    end
endmodule