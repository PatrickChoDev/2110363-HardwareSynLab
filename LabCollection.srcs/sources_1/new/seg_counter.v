`timescale 1ns / 1ps
module seg_counter(
    input wire clock,
    input wire reset,
    input wire [7:0] switches, // SW0-SW7
    input wire BTNU,           // Set to 9999
    input wire BTNC,           // Reset to 0000
    output wire [6:0] seg, // 7-segment display segments for each digit
    output wire [3:0] an       // 7-segment display digit selects
);

    wire [3:0] count [3:0]; // Counter outputs for 4 digits
    wire cout [2:0]; // Carry-out signals
    wire bout [2:0]; // Borrow signals
    wire [7:0] pulses;
    wire clk_dived;
    wire clk_dived2;
    
    clk_div #(.FACTOR(2500000)) clkdiv(
    .clk(clock),
    .rst(reset),
    .clk_out(clk_dived)
    );
    
    clk_div #(.FACTOR(250000)) clkdiv2(
    .clk(clock),
    .rst(reset),
    .clk_out(clk_dived2)
    );
    
    single_pulser pulser0(clk_dived, switches[0], pulses[0]);
    single_pulser pulser1(clk_dived, switches[1], pulses[1]);
    single_pulser pulser2(clk_dived, switches[2], pulses[2]);
    single_pulser pulser3(clk_dived, switches[3], pulses[3]);
    single_pulser pulser4(clk_dived, switches[4], pulses[4]);
    single_pulser pulser5(clk_dived, switches[5], pulses[5]);
    single_pulser pulser6(clk_dived, switches[6], pulses[6]);
    single_pulser pulser7(clk_dived, switches[7], pulses[7]);
    
    // Instantiate four BCD counters
    bcd_counter counter0 (
        .up(pulses[1]),
        .down(pulses[0]),
        .set9(BTNU),
        .set0(BTNC),
        .clock(clk_dived),
        .reset(reset),
        .count(count[0]),
        .cout(cout[0]),
        .bout(bout[2])
    );

    bcd_counter counter1 (
        .up(pulses[3] | cout[0]),
        .down(pulses[2]  | bout[2]),
        .set9(BTNU),
        .set0(BTNC),
        .clock(clk_dived),
        .reset(reset),
        .count(count[1]),
        .cout(cout[1]),
        .bout(bout[1])
    );

    bcd_counter counter2 (
        .up(pulses[5] | cout[1]),
        .down(pulses[4]  | bout[1]),
        .set9(BTNU),
        .set0(BTNC),
        .clock(clk_dived),
        .reset(reset),
        .count(count[2]),
        .cout(cout[2]),
        .bout(bout[0])
    );

    bcd_counter counter3 (
        .up(pulses[7] | cout[2]),
        .down(pulses[6] | bout[0]),
        .set9(BTNU),
        .set0(BTNC),
        .clock(clk_dived),
        .reset(reset),
        .count(count[3]),
        .cout(),
        .bout()
    );

    // 7-segment display driver
    seg7_tdm tdm_inst (
        .clk(clk_dived2),
        .rst(reset),
        .hex_data({count[3], count[2], count[1], count[0]}), // Concatenate counts
        .an(an),
        .seg(seg)
    );

endmodule
