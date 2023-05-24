//-----------------------------------------------------------------------------
// Module Name   : lab10_top
// Project       : ECE 211 Digital Circuits 1
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : April 2023
//-----------------------------------------------------------------------------
// Description   : Top-level module for Lab 10 - Health Monitor
//-----------------------------------------------------------------------------


module lab10_top(
    input logic clk,
    input logic rst,
    input analog_pos_in,       // pulse sensor positive input
    input analog_neg_in,      // pulse sensor negative input
    output logic [15:0] led,  // display digitized pulse sensor value
    output logic pulse        // display pulse as red LED
    );
    
    pulse_sensor U_PS(.clk, .rst, .analog_pos_in, .analog_neg_in, .led, .pulse);
    
    // add clock divider and other modules here
    
    
 
    
    
endmodule
