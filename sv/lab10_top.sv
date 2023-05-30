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
    input analog_pos_in,            // pulse sensor positive input
    input analog_neg_in,            // pulse sensor negative input
    output logic [15:0] led,        // display digitized pulse sensor value
    output logic pulse,             // display pulse as red LED
    output logic [6:0] segs_n,
    output logic [7:0] anode_n,
    output logic dp_n               //  displaydecimal point
    );
    
    logic [3:0] pd2, pd1, pd0;      //internal wires from  pulse monitor to the seven segment display
    logic sclk;                      // the divided clock signal
    logic  pulse_in;                 // pulse from the pulse sensor
        
                                     // add clock divider and other modules here
    pulse_sensor    U_PS(.clk, .rst, .analog_pos_in, .analog_neg_in, .led, .pulse(pulse_in));

    clkdiv          #(.DIVFREQ(1000)) U_CLOCKDIVIDER(.clk, .sclk, .reset(1'b0));

    pulse_monitor   U_PULSEMONITOR(.pulse_in, .d0(pd0),.d1(pd1),.d2(pd2),.clk(sclk),.rst,.pulse_led(pulse));

    logic [7:0] blank, dpmask;
    assign blank = 8'b11111000;
    assign dpmask = 8'b00000000;
    
    sevenseg_control U_SSC(
        .clk(sclk), .rst, .blank, .dpmask,
        .d7(4'd0), .d6(4'd0), .d5(4'd0), .d4(4'd0), .d3(4'd0), 
        .d2(pd2), .d1(pd1), .d0(pd0),
        .anode_n, .segs_n, .dp_n 
        );

    
endmodule