//-----------------------------------------------------------------------------
// Title         : counter_bcd - simple 4-bit BCD counter
// Project       : ECE 211 - Digital Circuits 1
//-----------------------------------------------------------------------------
// File          : counter_bcd.sv
// Author        : John Nestor
// Created       : 10.06.2014
// Last modified : 05.24.2023
//-----------------------------------------------------------------------------
// Description :
// This module is a simple 4-bit bcd counter counter with a
// synchronous reet
//
//-----------------------------------------------------------------------------

module counter_bcd(input logic clk, rst, enb,
	       output logic [3:0] q,
	       output logic 	  carry);

assign carry = (q == 4'd9) && enb;

  always_ff @( posedge clk )
    begin
       if (rst || carry) q <= 0;
       else if (enb) q <= q + 1;
    end

endmodule // counter

