//-----------------------------------------------------------------------------
// Title         : pulse_monitor - period-based pulse monitor
// Project       : ECE 211 - Digital Circuits 1
//-----------------------------------------------------------------------------
// File          : counter_bcd.sv
// Author        : John Nestor
// Created       : 05.24.2023
// Last modified : 05.24.2023
//-----------------------------------------------------------------------------
// Description :
// Using a pulsemonitor.com pulse sensor, sample the perid of successive
// pulses, average and display.
//
//-----------------------------------------------------------------------------

// NOTE: his module needs to be modified to match the structure of the period-based
// pulse monitor - see the diagram in the doc folder.

module pulse_monitor (input logic clk, rst, pulse_in,
		      output logic [3:0] d2, d1, d0);

   logic [5:0] 				count, count1, count2, count3;
   logic [7:0] 				countsum;
   logic [7:0]              pulseavg;
   logic                    pulse_db, pulse_pulse;

   delay_counter U_TIMER (.clk, .rst, .delay_start(1'b0), .delay_done);  // periodic 5 second delay

   debounce U_PDB(.clk, .pb(pulse_in), .pb_debounced(pulse_db));
   single_pulser U_PULSE (.clk, .din(pulse_db), .d_pulse(pulse_pulse));
   
   // counter for pulse monitor

   pulsecounter U_PCOUNT (.clk, .rst(delay_done), .cten(pulse_pulse), .q(count));
   
   reg6_enb U_REG1 (.clk, .rst, .lden(delay_done), .d(count), .q(count1));
   reg6_enb U_REG2 (.clk, .rst, .lden(delay_done), .d(count1), .q(count2));
   reg6_enb U_REG3 (.clk, .rst, .lden(delay_done), .d(count2), .q(count3));
   
   assign countsum = count1 + count2 + count3;

   assign pulseavg = countsum << 2;  // multiply by 4

   binary_to_bcd U_B2B (.b(pulseavg), .hundreds(d2), .tens(d1), .ones(d0));

   
   
   
endmodule
