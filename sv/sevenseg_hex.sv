module sevenseg_hex (input logic [3:0] a,
		 output logic [6:0] segs_l );

   logic [6:0] 			    segs;  // active high
   
   always_comb
     unique case (a) 
       4'h0 : segs = 7'b111_1110; 
       4'h1 : segs = 7'b011_0000; 
       4'h2 : segs = 7'b110_1101; 
       4'h3 : segs = 7'b111_1001; 
       4'h4 : segs = 7'b011_0011; 
       4'h5 : segs = 7'b101_1011; 
       4'h6 : segs = 7'b101_1111; 
       4'h7 : segs = 7'b111_0000; 
       4'h8 : segs = 7'b111_1111; 
       4'h9 : segs = 7'b111_0011;
       4'ha : segs = 7'b111_0111;
       4'hb : segs = 7'b001_1111;
       4'hc : segs = 7'b000_1101;
       4'hd : segs = 7'b011_1101;
       4'he : segs = 7'b100_1111;
       4'hf : segs = 7'b100_0111;
   endcase // unique case (d)

   assign segs_l = ~segs;  // convert to active low

endmodule // sevenseg

     
