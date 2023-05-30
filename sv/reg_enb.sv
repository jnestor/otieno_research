module reg_enb #(parameter W=8) (input logic clk, rst, enb,
		 input logic [W-1:0] d,
		 output logic [W-1:0] q);

   always_ff @(posedge clk)
     if (rst) q <= 0;
     else if (enb) q <= d;

endmodule // reg7_enb
