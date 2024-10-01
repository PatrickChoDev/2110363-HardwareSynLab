`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 12:48:50 AM
// Design Name: 
// Module Name: seg7_stack_top
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


module seg7_stack_top(
    input clk,
    input btnU,  // BTNU
    input btnC,   // BTNC
    input btnD, // BTND
    input [7:0] sw,  // Switches for value input (SW0-SW7)
    output [3:0] an,
    output [6:0] seg,
    output reg [15:0] led   // LED for stack full
    );

    wire [7:0] top_value;
    wire [7:0] stack_size;
    wire stack_full, stack_empty, btn_push, btn_pop;
    
    clk_div #(.FACTOR(250000)) clkdiv(
    .clk(clk),
    .rst(btnD),
    .clk_out(clk_dived)
    );

    single_pulser pulser_push(clk_dived,btnU,btn_push);
    single_pulser pulser_pop(clk_dived,btnC,btn_pop);
    
    // Instantiate the stack
    stack_8bit_memory stack (
        .clk(clk_dived),
        .reset(btnD),
        .push(btn_push),
        .pop(btn_pop),
        .data_in(sw),
        .top_value(top_value),
        .stack_size(stack_size),
        .stack_full(stack_full),
        .stack_empty(stack_empty)
    );

    wire [15:0] display_data = {stack_size, top_value};

    // Instantiate the 7-segment display multiplexer module
    seg7_tdm display (
        .clk(clk_dived),
        .rst(btnD),
        .hex_data(display_data),  // Send top_value and stack_size to the display
        .an(an),
        .seg(seg)
    );
    
    always @(posedge clk or posedge btnD) begin
        if (btnD) led = 0;
        else begin
            led[15] = stack_full;
            led[14] = stack_empty;
            led[7:0] = sw;
        end
    end
endmodule
