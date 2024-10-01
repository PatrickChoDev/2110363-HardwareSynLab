`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 11:46:06 AM
// Design Name: 
// Module Name: seven_segment_display_tb
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


module seven_segment_display_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [15:0] hex_data;

    // Outputs
    wire [3:0] an;
    wire [6:0] seg;
    wire [6:0] seg_dec;

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz clock (10ns period)

    // Instantiate the Unit Under Test (UUT)
    seven_segment_display #(
        .MODE("HEX"),    // You can switch this to "DEC" to test decimal mode
        .ZERO_OFF(0),    // Zero is displayed (set to 1 to turn zero off)
        .FIXED_DISPLAY(4) // Display all 4 digits
    ) uut (
        .clk(clk),
        .hex_data(hex_data),
        .rst(rst),
        .an(an),
        .seg(seg)
    );
    
    // Instantiate again for DEC mode
    seven_segment_display #(
        .MODE("DEC"),
        .ZERO_OFF(0),
        .FIXED_DISPLAY(4)
    ) uut_dec (
        .clk(clk),
        .hex_data(hex_data),
        .rst(rst),
        .an(an),
        .seg(seg_dec)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 0;
        hex_data = 16'h0000;

        // Apply reset
        rst = 1;
        #20;
        rst = 0;

        // Test HEX Mode
        // Display 0123 in hex
        hex_data = 16'h0123;
        #10000000;

        // Display ABCD in hex
        hex_data = 16'hABCD;
        #10000000;

        // Display 9876 in hex
        hex_data = 16'h9876;
        #10000000;


        // Test DEC Mode
        // Display +7 (0111) and then -1 (1111 in 2's complement)
        hex_data = 16'b0000_0000_0000_0111;  // Positive 7
        #10000000;

        hex_data = 16'b0000_0000_1111_0001;  // Negative -1
        #10000000;

        hex_data = 16'b0000_0000_1111_0011;  // -3 in decimal
        #10000000;

        // Finish simulation
        $finish;
    end

endmodule
