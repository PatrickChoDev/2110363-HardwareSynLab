`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 02:31:10 AM
// Design Name: 
// Module Name: syn_bram
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


module syn_bram #(
    parameter DATA_WIDTH = 8,
    parameter ADDRESS_WIDTH = 256
    )
    (
        input clk,
        input [DATA_WIDTH-1:0] data_in,
        input write_enable,
        input [ADDRESS_WIDTH-1:0] address,
        output reg [DATA_WIDTH-1:0] data_out
    );
    
    (* ramstyle = "block" *) reg [DATA_WIDTH-1:0] memory [ADDRESS_WIDTH-1:0];
    
    always @(posedge clk) begin
        data_out <= memory[address];
        if (write_enable) memory[address] <= data_in;
    end
endmodule
