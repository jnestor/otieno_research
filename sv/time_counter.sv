//-----------------------------------------------------------------------------
// Title         : time_counter
// Project       : ECE 211 Digital Circuits 1
//-----------------------------------------------------------------------------
// File          : time_counter.sv
// Author        : John Nestor  <nestorj@nestorj-mbpro-15.home>
// Created       : 27.10.2018
// Last modified : 27.10.2018
//-----------------------------------------------------------------------------
// Description :
// Time counter forr reaction timer.  Assumes a 1 KHz clock and counts in millisconds
// Initialize using time_clr; count using time_en, if result > 9.999sec, assert time_late
//-----------------------------------------------------------------------------

module time_counter (input logic        clk, rst, time_clr, time_en,
		     output logic 	time_late,
		     output logic [3:0] d3, d2, d1, d0
		     );
   logic 				   carry1, carry2, carry3;
   
   counter_bcd U_COUNT0(.clk, .rst(time_clr || rst), .enb(time_en), .q(d0), .carry(carry1));
   counter_bcd U_COUNT1(.clk, .rst(time_clr || rst), .enb(carry1), .q(d1), .carry(carry2));
   counter_bcd U_COUNT2(.clk, .rst(time_clr || rst), .enb(carry2), .q(d2), .carry(carry3));
   counter_bcd U_COUNT3(.clk, .rst(time_clr || rst), .enb(carry3), .q(d3), .carry(time_late));
   
   
endmodule // stopwatch_count
