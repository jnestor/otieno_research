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
    input logic mode,              // to witch between displaying the reaction timer output and pulse monitor outputs
    input logic clk,
    input logic rst,
    input analog_pos_in,            // pulse sensor positive input
    input analog_neg_in,            // pulse sensor negative input
    output logic [15:0] led,        // display digitized pulse sensor value
    output logic pulse,             // display pulse as red LED
    output logic [6:0] segs_l,
    output logic [7:0] anode_l,
    output logic dp_l               //  displaydecimal point
    );
    
    logic [3:0] pd2, pd1, pd0,       //internal wires from  pulse monitor to the seven segment display
    logic [3:0] rd3, rd2, rd1, rd0;  // internal wires from reaction timer to the seven segment display
    logic sclk;                      // the divided clock signal
    logic  pulse_in;                 // pulse from the pulse sensor
    assign pulse = pulse_in;         //internal wire to connect pulse to the single pulser
    
                                     // add clock divider and other modules here
    pulse_sensor    U_PS(.clk, .rst, .analog_pos_in, .analog_neg_in, .led, .pulse(pulse_in));

    clkdiv          U_CLOCKDIVIDER(.clk,.sclk,.reset(1'b0));

    pulse_monitor   U_PULSEMONITOR(.pulse_in,.d0(pd0),.d1(pd1),.d2(pd2),.clk(sclk),.rst,.pulse_led(pulse));

    display_control U_DISPLAYCONTROLLER(.clk(sclk),.rst,.pd2, .pd1, .pd0, .rd3, .rd2, .rd1, .rd0,.segs_l,.anode_l,.dp_l,.mode);
    
endmodule