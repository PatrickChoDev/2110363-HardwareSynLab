`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 02:02:32 PM
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input wire clk,            // Clock signal
    input wire btn,            // Raw button input
    output reg btn_debounced   // Debounced button output
);

    // Parameters
    parameter COUNTER_MAX = 1000000; // Adjust for your clock frequency and debounce time
    
    // Internal signals
    reg [19:0] counter;         // Counter for debouncing
    reg btn_sync_0, btn_sync_1; // Synchronization flip-flops

    // Synchronize button signal to clock domain
    always @(posedge clk) begin
        btn_sync_0 <= btn;
        btn_sync_1 <= btn_sync_0;
    end

    // Counter and debouncing logic
    always @(posedge clk) begin
        if (btn_sync_1 == btn_debounced) begin
            counter <= 0; // Reset counter if button state is stable
        end else begin
            if (counter < COUNTER_MAX) begin
                counter <= counter + 1;
            end else begin
                btn_debounced <= btn_sync_1; // Update debounced output
            end
        end
    end

endmodule