//-----------------------------------------------------------------------------
// Title         : pd_counter - pulse period counter
// Project       : ECE 211 - Digital Circuits 1
//-----------------------------------------------------------------------------
// File          : counter_bcd.sv
// Author        : John Nestor
// Created       : 05.24.2023
// Last modified : 06.24.2023
//-----------------------------------------------------------------------------
// Description :
// This module counts the interval between rising edges on the pulse signal
//
//-----------------------------------------------------------------------------


module pd_counter (input logic clk, rst, enb, clr,
		     output logic [7:0] q);

   always_ff @(posedge clk)
     if (rst || clr) q <= 0;
     else if (q != 8'b11111111) q <= q + 1;
   
endmodule // pulsecounter
