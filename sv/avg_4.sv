`timescale 1ns / 1ps
// -----------------------------------------------------------------------------------------
// Company: Lafayette college
// Engineer: Otieno Maurice
// ------------------------------------------------------------------------------------------
// Create Date: 05/26/2023 10:08:08 AM
// Design Name: 
// Module Name: avg_4
// Project Name: NEW PULSE MONITOR
// Target Devices: NEXYSA7 100T
// Description: //
// This module adds the four counts and computes the average by shifting the sum to the right by 2
// -------------------------------------------------------------------------------------------------


module avg_4( 
input logic [7:0] count1, count2, count3, count4,
output logic [7:0] pulseavg
    );
    
    logic [9:0] sum;
    
    assign sum = count1 + count2 + count3 + count4;
    
    assign pulseavg = sum >> 2;
    
endmodule


