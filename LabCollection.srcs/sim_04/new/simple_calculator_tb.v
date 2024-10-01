`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 04:31:22 AM
// Design Name: 
// Module Name: simple_calculator_tb
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


module simple_calculator_tb;

    // Testbench signals
    reg clk;
    reg [3:0] A, B;
    reg BTNU, BTNL, BTND, BTNR;
    wire [6:0] seg;
    wire [3:0] an;

    // Instantiate the Unit Under Test (UUT)
    simple_calculator uut (
        .clk(clk),
        .A(A),
        .B(B),
        .BTNU(BTNU),
        .BTNL(BTNL),
        .BTND(BTND),
        .BTNR(BTNR),
        .seg(seg),
        .an(an)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // 10ns period clock
    end

    // Initial block for test vectors
    initial begin
        // Initialize inputs
        A = 4'b0000;
        B = 4'b0000;
        BTNU = 0;
        BTNL = 0;
        BTND = 0;
        BTNR = 0;
        
        // Test Case 1: Addition
        A = 4'b0011; // 3
        B = 4'b0001; // 1
        BTNU = 1;    // Trigger addition
        #10;
        BTNU = 0;    // Release button
        
        // Test Case 2: Subtraction
        A = 4'b0100; // 4
        B = 4'b0010; // 2
        BTNL = 1;    // Trigger subtraction
        #10;
        BTNL = 0;    // Release button
        
        // Test Case 3: Multiplication
        A = 4'b0010; // 2
        B = 4'b0011; // 3
        BTND = 1;    // Trigger multiplication
        #10;
        BTND = 0;    // Release button
        
        // Test Case 4: Division
        A = 4'b0110; // 6
        B = 4'b0011; // 3
        BTNR = 1;    // Trigger division
        #10;
        BTNR = 0;    // Release button
        
        // Test Case 5: Division by Zero
        A = 4'b0101; // 5
        B = 4'b0000; // 0
        BTNR = 1;    // Trigger division
        #10;
        BTNR = 0;    // Release button
        
        // End of simulation
        $finish;
    end
    
    // Monitor block to observe output changes
    initial begin
        $monitor("Time = %0t, A = %b, B = %b, BTNU = %b, BTNL = %b, BTND = %b, BTNR = %b, seg = %b, an = %b",
                 $time, A, B, BTNU, BTNL, BTND, BTNR, seg, an);
    end

endmodule