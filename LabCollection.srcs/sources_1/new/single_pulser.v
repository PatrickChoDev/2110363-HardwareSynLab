`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 01:21:12 PM
// Design Name: 
// Module Name: single_pulser
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


module single_pulser(
    input wire clock,       // Clock signal
    input wire trigger,     // Trigger signal to generate a single pulse
    output reg pulse        // Output pulse
);

    // Internal signal to hold the state of the trigger
    reg trigger_d;

    // Pulse generation logic
    always @(posedge clock) begin
        // Edge detection: if trigger goes from 0 to 1, generate a pulse
        if (trigger && ~trigger_d) begin
            pulse <= 1;   // Generate a pulse
        end else begin
            pulse <= 0;   // Ensure pulse is low otherwise
        end

        // Register the current state of the trigger
        trigger_d <= trigger;
    end

endmodule
