`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 11:15:48 AM
// Design Name: 
// Module Name: seven_segment_display
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


module seven_segment_display #(
    parameter MODE = "HEX",  // Mode: "HEX" for hexadecimal, "DEC" for decimal
    parameter ZERO_OFF = 0,
    parameter FIXED_DISPLAY = 4
)(
    input wire clk,
    input wire [15:0] hex_data,
    input wire rst,
    output reg [3:0] an,
    output reg [6:0] seg
);
    reg [1:0] sel;
    reg [3:0] curr_val;
    wire clk_div;
    wire [6:0] curr_seg;
    
    // Clock divider instance
    clk_div #(.FACTOR(250000)) clk_div_inst (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_div)
    );
    
    // Seven-segment encoder instance
    seven_segment_encoder #(.MODE(MODE)) encoder_inst (
        .value(curr_val),
        .negative(curr_val == 4'b1111),  // Negative indication when curr_val is -1 (two's complement)
        .seg(curr_seg)                   // Encoded 7-segment output for the current value
    ); 
    
    // Selection logic for each digit (multiplexing)
    always @(posedge clk_div or posedge rst) begin
        if (rst) begin
            sel <= 0;
        end else begin
            sel <= sel + 1;
        end
    end
    
    // Digit selection and corresponding value assignment
    always @(*) begin
        case(sel)
            2'b00: begin
                if (FIXED_DISPLAY >= 1 && !(ZERO_OFF && (hex_data[3:0] + hex_data[7:4] + hex_data[11:8] + hex_data[15:12] == 0)))
                    an = 4'b1110;  // Enable the first display
                else
                    an = 4'b1111;  // Disable all displays
                curr_val = hex_data[3:0];  // Select least significant 4 bits
            end
            2'b01: begin
                if (FIXED_DISPLAY >= 2 && !(ZERO_OFF && (hex_data[7:4] + hex_data[11:8] + hex_data[15:12] == 0)))
                    an = 4'b1101;  // Enable the second display
                else
                    an = 4'b1111;
                curr_val = hex_data[7:4];  // Select next 4 bits
            end
            2'b10: begin
                if (FIXED_DISPLAY >= 3 && !(ZERO_OFF && (hex_data[11:8] + hex_data[15:12] == 0)))
                    an = 4'b1011;  // Enable the third display
                else
                    an = 4'b1111;
                curr_val = hex_data[11:8];  // Select next 4 bits
            end
            2'b11: begin
                if (FIXED_DISPLAY >= 4 && !(ZERO_OFF && hex_data[15:12] == 0))
                    an = 4'b0111;  // Enable the fourth display
                else
                    an = 4'b1111;
                curr_val = hex_data[15:12];  // Select most significant 4 bits
            end
            default: begin
                an = 4'b1111;  // Disable all displays if invalid
                curr_val = 4'h0;  // Default value
            end
        endcase
        seg = curr_seg;  // Update the 7-segment output based on current value
    end

endmodule
