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
		      output logic [3:0] d2, d1, d0,
		      output logic pulse_led);

   logic [5:0] count, count1, count2, count3, count4;
   logic [7:0] bpm;                                                    // changed from countsum to bpm
   logic [7:0] pulseavg;
   logic pulse_db, pulse_sp, cy;                                        // added internal wire cy connected to the carry output of bcd counter
   assign  pulse_led = pulse_sp;                                            //internal wire to connect pulse to the single pulser
   
   debounce U_PDB(.clk,.pb(pulse_in), .pb_debounced(pulse_db));
   
   single_pulser U_PULSE (.clk,.din(pulse_db), .d_pulse(pulse_sp));     // delivers a single pulse to clear the saturating pulse counter
   
   pd_counter U_COUNT (.clk,.rst,.clr(pulse_sp), .enb(cy), .q(count));   // an instance of the saturating pulse counter for the pulse monitor
  
   reg_enb U_REG1 (.clk, .rst, .enb(pulse_sp), .d(count), .q(count1));
   reg_enb U_REG2 (.clk, .rst, .enb(pulse_sp), .d(count1), .q(count2));
   reg_enb U_REG3 (.clk, .rst, .enb(pulse_sp), .d(count2), .q(count3));
   reg_enb U_REG4 (.clk, .rst, .enb(pulse_sp), .d(count3), .q(count4));
  
   bcd_counter U_BCDCOUNTER(.enb(1'b1),.carry(cy),.clk,.rst);
  
   avg_4 U_AVERAGE(.count1, .count2, .count3,.count4, .pulseavg);         // adds the four registered counts and computes the average
  
   pd_to_bpm U_PD_TO_BPM (.pd(pulseavg), .bpm(bpm));
  
   binary_to_bcd U_B2B (.b(bpm), .hundreds(d2), .tens(d1), .ones(d0));

   
endmodule