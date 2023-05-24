`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2018 03:15:24 PM
// Design Name: 
// Module Name: display_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display_control(
    input logic clk, rst, mode, rs_en,
    input logic [3:0] pd2, pd1, pd0, rd3, rd2, rd1, rd0,
    output logic [6:0] segs_l,
    output logic [7:0] anode_l,
    output logic dp_l 
    );

    logic [7:0] blank, dpmask;
    logic [3:0] d7, d6, d5, d4, d3, d2, d1, d0;
    
    assign d7 = 4'd0;
    assign d6 = 4'd0;
    assign d5 = 4'd0;
    assign d4 = 4'd0;
    
    always_comb
      begin
        if (mode)
          begin  // pulse mode
            d3 = 4'd0;
            d2 = pd2;
            d1 = pd1;
            d0 = pd0;
            dpmask = 8'b00000000;
            blank = 8'b11111000;
          end
        else
          begin  // reaction timer mode
            d3 = rd3;
            d2 = rd2;
            d1 = rd1;
            d0 = rd0;
            dpmask = 8'b00001000;
            if (rs_en) blank = 8'b11110000;
            else blank = 8'b11111111;
          end
      end
    
    
    sevenseg_control U_SSC(.clk, .rst, .blank, .dpmask,
                           .d7, .d6, .d5, .d4, .d3, .d2, .d1, .d0,
                           .anode_l, .segs_l, .dp_l );

 

endmodule
