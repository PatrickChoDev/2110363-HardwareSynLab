`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 03:43:01 AM
// Design Name: 
// Module Name: bcd_syn_bram
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


module bcd_syn_bram
    (
        input clk,
        input [7:0] data_in,
        input write_enable,
        input [31:0] address,
        output reg [7:0] data_out
    );
    
    (* ramstyle = "block" *) reg [7:0] memory [31:0];
    
    generate
        initial begin
        
            memory[0] = 'h00;
            memory[1] = 'h01;
            memory[2] = 'h02;
            memory[3] = 'h03;
            memory[4] = 'h04;
            memory[5] = 'h05;
            memory[6] = 'h06;
            memory[7] = 'h07;
            memory[8] = 'h08;
            memory[9] = 'h09;
            memory[10] = 'h10;
            memory[11] = 'h11;
            memory[12] = 'h12;
            memory[13] = 'h13;
            memory[14] = 'h14;
            memory[15] = 'h15;
            memory[16] = 'h16;
            memory[17] = 'h17;
            memory[18] = 'h18;
            memory[19] = 'h19;
            memory[20] = 'h20;
            memory[21] = 'h21;
            memory[22] = 'h22;
            memory[23] = 'h23;
            memory[24] = 'h24;
            memory[25] = 'h25;
            memory[26] = 'h26;
            memory[27] = 'h27;
            memory[28] = 'h28;
            memory[29] = 'h29;
            memory[30] = 'h30;
            memory[31] = 'h31;
        end
    endgenerate
    
    always @(posedge clk) begin
        data_out <= memory[address];
        if (write_enable) memory[address] <= data_in;
    end
endmodule