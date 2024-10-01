`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 04:26:05 AM
// Design Name: 
// Module Name: simple_calculator
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


module simple_calculator(
    input clk, 
    input [3:0] A,      // 4-bit input A
    input [3:0] B,      // 4-bit input B
    input BTNU,         // Button for addition
    input BTNL,         // Button for subtraction
    input BTND,         // Button for multiplication
    input BTNR,         // Button for division
    output [6:0] seg,
    output [3:0] an
);

    reg [7:0] result;  // 8-bit result to accommodate overflow
    wire btnU,btnL,btnD,btnR;

    // Perform the arithmetic operation based on the push button pressed
    always @(posedge clk) begin
        case (1'b1) // Use a one-hot encoding for buttons
            btnU: result <= A + B; // Addition
            btnL: result <= A - B; // Subtraction
            btnD: result <= A * B; // Multiplication
            btnR: result <= (B != 0) ? (A / B) : 8'hFF; // Division (check for zero divisor)
        endcase
    end
    
    clk_div #(.FACTOR(250000)) clkdiv(
    .clk(clk),
    .rst('b0),
    .clk_out(clk_dived)
    );

    single_pulser pulser_u(clk_dived,BTNU,btnU);
    single_pulser pulser_r(clk_dived,BTNR,btnR);
    single_pulser pulser_d(clk_dived,BTND,btnD);
    single_pulser pulser_l(clk_dived,BTNL,btnL);

    wire [3:0] hundreds = result / 100;
    wire [3:0] tens = (result % 100) / 10;
    wire [3:0] units = result % 10;

    seg7_tdm display(
        .clk(clk_dived),
        .rst('b0),
        .hex_data({0,hundreds,tens,units}),
        .an(an),
        .seg(seg)
    );
    

endmodule