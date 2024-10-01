`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 11:21:54 AM
// Design Name: 
// Module Name: seven_segment_encoder
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


module seven_segment_encoder #(
    parameter MODE = "HEX"  // Mode: "HEX" for hexadecimal, "DEC" for decimal
)(
    input wire [3:0] value,      // 4-bit input (for numbers 0-15 in HEX, or 0-9 / negative sign in DEC)
    input wire negative,
    output reg [6:0] seg         // 7-segment display output (active low)
);
    always @(*) begin
        if (MODE == "HEX") begin
            // HEX Mode: Display 0-F
            case(value)
              4'b0001 : seg = 7'b1111001;   // 1
              4'b0010 : seg = 7'b0100100;   // 2
              4'b0011 : seg = 7'b0110000;   // 3
              4'b0100 : seg = 7'b0011001;   // 4
              4'b0101 : seg = 7'b0010010;   // 5
              4'b0110 : seg = 7'b0000010;   // 6
              4'b0111 : seg = 7'b1111000;   // 7
              4'b1000 : seg = 7'b0000000;   // 8
              4'b1001 : seg = 7'b0010000;   // 9
              4'b1010 : seg = 7'b0001000;   // A
              4'b1011 : seg = 7'b0000011;   // b
              4'b1100 : seg = 7'b1000110;   // C
              4'b1101 : seg = 7'b0100001;   // d
              4'b1110 : seg = 7'b0000110;   // E
              4'b1111 : seg = 7'b0001110;   // F
              default : seg = 7'b1000000;   // 0
            endcase
        end
        else if (MODE == "DEC") begin
            // DEC Mode: Display 0-9, or minus sign for negative numbers
            if (negative) begin
                seg = 7'b0111111; // Minus sign "-"
            end else begin
                case (value)
                    4'd0: seg = 7'b1000000; // 0
                    4'd1: seg = 7'b1111001; // 1
                    4'd2: seg = 7'b0100100; // 2
                    4'd3: seg = 7'b0110000; // 3
                    4'd4: seg = 7'b0011001; // 4
                    4'd5: seg = 7'b0010010; // 5
                    4'd6: seg = 7'b0000010; // 6
                    4'd7: seg = 7'b1111000; // 7
                    4'd8: seg = 7'b0000000; // 8
                    4'd9: seg = 7'b0010000; // 9
                    default: seg = 7'b1111111; // Off or blank for invalid input
                endcase
            end
        end
        else begin
            seg = 7'b1111111; // Off or blank for invalid mode
        end
    end

endmodule
