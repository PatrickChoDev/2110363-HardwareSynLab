`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 12:43:30 AM
// Design Name: 
// Module Name: stack_8bit_memory
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


module stack_8bit_memory(
    input clk,
    input reset,
    input push,   // Push signal (BTNU)
    input pop,    // Pop signal (BTNC)
    input [7:0] data_in,  // Data from switches (SW0-SW7)
    output reg [7:0] top_value,  // Value at the top of the stack
    output reg [7:0] stack_size, // Number of elements in the stack
    output reg stack_full,
    output reg stack_empty
    );

    reg [7:0] stack_mem [255:0];  // Stack memory with 256 8-bit elements

    // Synchronous stack operations
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            stack_size <= 0;             // Reset stack size
            top_value <= 0;              // Reset top value
            stack_full <= 0;             // Stack is not full
            stack_empty <= 1;            // Stack is empty
        end else begin
            // PUSH Operation
            if (push && !stack_full) begin
                stack_mem[stack_size] <= data_in;  // Store the input data in the stack
                stack_size <= stack_size + 1;  // Increment stack size
                top_value <= data_in;      // Update top value with the pushed data
            end

            // POP Operation
            if (pop && !stack_empty) begin
                top_value <= stack_mem[stack_size - 1];  // Update top value with the next element
                stack_size <= stack_size - 1;  // Decrement stack size
            end

            // Update Stack Full/Empty Status
            stack_full <= (stack_size == 255);     // Stack is full if the pointer reaches the last index
            stack_empty <= (stack_size == 0);      // Stack is empty if the pointer is 0
        end
    end
endmodule

