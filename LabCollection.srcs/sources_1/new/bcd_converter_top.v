`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 02:37:04 AM
// Design Name: 
// Module Name: bcd_converter_top
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


module bcd_converter_top(
    input clk,
    input [4:0] sw,
    output [6:0] seg,
    output [3:0] an 
    );
   
    reg [31:0] address;
    reg [15:0] display_data;
    wire [7:0] memory;
    
    clk_div #(.FACTOR(250000)) clkdiv(
    .clk(clk),
    .rst('b0),
    .clk_out(clk_dived)
    );
    
    bcd_syn_bram bram(
        .clk(clk),
        .data_in(0),
        .address(address),
        .write_enable(0),
        .data_out(memory)
    );
    
    seg7_tdm display(
        .clk(clk_dived),
        .rst('b0),
        .hex_data(display_data),  // Send top_value and stack_size to the display
        .an(an),
        .seg(seg)
    );
    
    
    always @(posedge clk) begin
        address <= 'h00 + sw;
        display_data <= {0,0,memory};
    end
    
endmodule
