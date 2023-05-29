`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: LAFAYETTE COLLEGE 
// Engineer: OTIENO MAURICE AND ALEX VILLALBA
// 
// Create Date: 04/20/2023 09:43:05 AM
// Design Name: REACFSM
// Module Name: reaction_FSM
// Project Name: HEALTH MONITOR
// Target Devices: NEXYSA7 1007
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
//  WE ASSIGN A VALUE 0-7 TO THE COLORS TO CONTROL THE INTENSITY

module reaction_FSM(
   input logic start, enter, rwait_done, wait5_done, time_late, rst, clk,
   output logic [2:0] color_r, color_g, color_b, 
   output logic time_clr, time_en, start_wait5, start_rwait, rs_en
); 

     typedef enum logic [2:0] {
         IDLE = 3'b000, RWAIT = 3'b001, WHITE = 3'b010, RED = 3'b011, 
          YELLOW = 3'b100, GREEN = 3'b101, DISPLAY = 3'b110
      } states_t ;
      
   states_t state, next;
        
        
     always_ff @(posedge clk)
               begin  
                 if (rst) state <= GREEN;
                 else state <= next;
                end
         
         
      always_comb 
         begin 
           next = GREEN;
           unique  case(state)
              IDLE: begin
                       color_r = 0; color_g =2; color_b =0; time_clr = 1; 
                       start_rwait =0; start_wait5 = 0;rs_en = 0; time_en =0;
                       if (start) next = RWAIT; 
                       else next = IDLE;    
                     end
             GREEN: begin
                       color_r = 0; color_g =2; color_b =0;time_clr = 1; 
                       start_rwait =0; time_en = 0; start_wait5 = 0; rs_en = 0;
                       if (start)  next = RWAIT;
                        else next = GREEN;
                     end
            RWAIT: begin 
                       color_r = 0; color_g =0; color_b =0; time_clr = 1;
                       start_rwait =1;time_en = 0;start_wait5 = 0; rs_en = 0;
                       if (rwait_done) next = WHITE;   
                       else  if ( enter & ~rwait_done) next = RED;
                       else next = RWAIT;
                     end 
             RED: begin
                      color_r = 7; color_g =0; color_b =0; start_wait5 = 1;
                      time_clr = 1; start_rwait =0; time_en = 0;rs_en =0;
                      if (wait5_done) next = IDLE;
                      else next = RED;
                    end
             WHITE: begin 
                      color_r = 4; color_g =2; color_b =3; start_rwait = 0; 
                      rs_en = 0; time_en = 1; start_wait5 = 0;time_clr = 0;
                      if (time_late) begin  next = YELLOW; end 
                      else if (enter & ~time_late) next = DISPLAY; 
                      else  next = WHITE;
                    end
            DISPLAY: begin
                      color_r = 0; color_g =2; color_b =0; start_rwait =0;
                      rs_en = 1; time_clr = 0; time_en = 0; start_wait5 = 0;
                      if (start) next = IDLE; 
                      else next = DISPLAY;
                    end
            YELLOW: begin 
                      color_r = 7; color_g =2; color_b =0; time_clr = 1;
                      start_rwait =0; time_en = 0; start_wait5 = 1;rs_en = 0;
                      if (wait5_done) next = IDLE; else next = YELLOW;
                    end
            default: begin 
                      color_r = 0; color_g =0; color_b =0; time_clr = 1; 
                      start_rwait =0; start_wait5 = 0;rs_en = 0;time_en = 0; 
                     end
             endcase
          end
 
endmodule