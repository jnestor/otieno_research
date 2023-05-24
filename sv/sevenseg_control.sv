// extended version of sevenseg_control
// added actove-high blank input (turns off digit when blank[i]==1)
// added dpmask (turns on dp when count==i and blank[i]==0

module sevenseg_control( input logic clk, rst,
			    input logic [3:0]  d7, d6, d5, d4, d3, d2, d1, d0,
			    input logic [7:0] blank, dpmask,
			    output logic [7:0] anode_l,
			    output logic [6:0] segs_l,
			    output logic dp_l );

   logic [2:0] 			       count;
   logic [3:0] 			       dsel;

   // counter
   always_ff @(posedge clk)
     if (rst) count <= 0;
     else count <= count + 1;
     
     assign dp_l = !((dpmask[count]==1'b1) && (blank[count]==1'b0));

   //3-8 decoder
   always_comb
      begin
        anode_l = '1;  // default va\lue not really needed here
	    for (int i=0; i<=7; i=i+1)
	       if ((count == i) && (blank[i] == 1'b0)) anode_l[i] = 1'b0;
	       else anode_l[i] = 1'b1;
       end

   //multiplexer
   always_comb
     case (count) 
       3'd0: dsel = d0;
       3'd1: dsel = d1;
       3'd2: dsel = d2;
       3'd3: dsel = d3;
       3'd4: dsel = d4;
       3'd5: dsel = d5;
       3'd6: dsel = d6;
       3'd7: dsel = d7;
       default: dsel = '0;
     endcase // case (count)

   // seven-seg decoder
   sevenseg_hex U_SEVENSEG(.a(dsel), .segs_l);
  
endmodule // sevenseg_control
