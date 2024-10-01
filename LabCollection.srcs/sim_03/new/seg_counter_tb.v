`timescale 1ns / 1ps

module seg_counter_tb;

    // Testbench signals
    reg clock;                     // Clock signal
    reg reset;                     // Reset signal
    reg [7:0] switches;           // Switches (SW0-SW7)
    reg BTNU;                      // Button to set to 9999
    reg BTNC;                      // Button to reset to 0000
    wire [6:0] seg;               // 7-segment display segments
    wire [3:0] an;                // 7-segment display digit selects
    wire [7:0] pulses;

    // Instantiate the seg_counter module
    seg_counter uut (
        .clock(clock),
        .reset(reset),
        .switches(switches),
        .BTNU(BTNU),
        .BTNC(BTNC),
        .seg(seg),
        .an(an),
        .pulses(pulses)
    );

    // Clock generation: 50 MHz clock (20 ns period)
    always begin
        #2 clock = ~clock; // Toggle clock every 10 ns
    end

    // Testbench logic
    initial begin
        // Initialize signals
        clock = 0;
        reset = 0;
        switches = 8'b00000000;
        BTNU = 0;
        BTNC = 0;

        // Apply reset
        reset = 1;
        #20;  // Wait for 20 ns
        reset = 0;

        // Test case 1: Display 0000
        switches = 8'b00000000;
        #100; // Wait for 100 ns

        // Test case 2: Count up by 1
        switches = 8'b00000001; // Apply pulse for count up by 1
        #100; // Wait for 100 ns

        // Test case 3: Count down by 1
        switches = 8'b00000010; // Apply pulse for count down by 1
        #100; // Wait for 100 ns

        // Test case 4: Count up by 10
        switches = 8'b00000100; // Apply pulse for count up by 10
        #100; // Wait for 100 ns

        // Test case 5: Count down by 10
        switches = 8'b00001000; // Apply pulse for count down by 10
        #100; // Wait for 100 ns

        // Test case 6: Count up by 100
        switches = 8'b00010000; // Apply pulse for count up by 100
        #100; // Wait for 100 ns

        // Test case 7: Count down by 100
        switches = 8'b00100000; // Apply pulse for count down by 100
        #100; // Wait for 100 ns

        // Test case 8: Count up by 1000
        switches = 8'b01000000; // Apply pulse for count up by 1000
        #100; // Wait for 100 ns

        // Test case 9: Count down by 1000
        switches = 8'b10000000; // Apply pulse for count down by 1000
        #100; // Wait for 100 ns

        // Test case 10: Set to 9999
        BTNU = 1;
        #20;  // Wait for 20 ns
        BTNU = 0;

        // Test case 11: Reset to 0000
        BTNC = 1;
        #20;  // Wait for 20 ns
        BTNC = 0;

        // End simulation
        $stop;
    end

endmodule