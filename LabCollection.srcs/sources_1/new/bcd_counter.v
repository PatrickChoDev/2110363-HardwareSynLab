`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 01:33:16 PM
// Design Name: 
// Module Name: bcd_counter
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

module bcd_counter(
    input wire up,          // Up counting control (active on positive edge)
    input wire down,        // Down counting control (active on positive edge)
    input wire set9,        // Set counter to 9
    input wire set0,        // Set counter to 0
    input wire clock,       // Clock signal
    input wire reset,       // Asynchronous reset
    output reg [3:0] count, // 4-bit counter output
    output reg cout,        // Overflow output
    output reg bout         // Borrow output
);

    // Internal signals
    reg [3:0] next_count;

    // Counter logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            count <= 4'b0000; // Reset counter to 0
        end else begin
            count <= next_count;
        end
    end

    // Calculate next count based on inputs
    always @(*) begin
        // Default outputs
        next_count = count;
        cout = 0;
        bout = 0;
        
        if (set9) begin
            next_count = 4'b1001; // Set to 9
        end else if (set0) begin
            next_count = 4'b0000; // Set to 0
        end else if (up) begin
            if (count == 4'b1001) begin
                next_count = 4'b0000; // Wrap around to 0 after 9
                cout = 1;
            end else begin
                next_count = count + 1;
            end
        end else if (down) begin
            if (count == 4'b0000) begin
                next_count = 4'b1001; // Wrap around to 9 from 0
                bout = 1;
            end else begin
                next_count = count - 1;
            end
        end
    end

endmodule
