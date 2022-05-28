`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2022 09:48:00 AM
// Design Name: 
// Module Name: TOP_design
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
/*--------------------------------------------------------------------------------------------------------------------------------------
 SEQUECNE DETECTOR OF MEALY MACHINGE 1010 using 3 always blocks OVERALAPPING
 -----------------------------------------------------------------------------------------------------------*/
`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11
`define STATE_WIDTH 2
module TOP_design(input clk , 
                  input rst_n , 
                  input d_in ,   
                  output out_mealy , 
                  output reg [`STATE_WIDTH-1:0] p_STATE  , 
                  output reg mealy_glitch_free
                   );
 reg [`STATE_WIDTH-1:0] nEXT_STATE ;
reg out ;

///data register///
always @(posedge clk)
  begin
   if(~rst_n)
    begin
     p_STATE <= `S0; 
      end
   else
     begin
     p_STATE <= nEXT_STATE ; 
       end 
  end
            
     
  ///next_sTATE _LOGIC//////
  always @(*)
    begin
    nEXT_STATE = 1'b0;
     out = 1'b0;
     case(p_STATE)
    `S0: begin
            if(d_in == 1'b0)
        begin
             nEXT_STATE = `S0;
             out = 1'b0;
        end
              else
        begin
             nEXT_STATE = `S1;
             out = 1'b0;
          end
        end
    `S1 : begin
             if(d_in==1'b0)
             begin
               nEXT_STATE = `S2;
               out = 1'b0;
         end
               else
            begin 
              out = 1'b0;
               nEXT_STATE = `S1 ;
          end
        end  
    `S2 : begin
             if(d_in == 1'b0 )
            begin 
                 nEXT_STATE = `S0 ;
                  out = 1'b0;
                 end
               else
              begin 
                   nEXT_STATE = `S3;
                  out = 1'b0;
           end               
        end                 
     `S3 :  begin 
             if(d_in == 1'b0)  
             begin            
                nEXT_STATE = `S2;
                out = 1'b1;
               end 
            else
           begin
                out = 1'b0;
                nEXT_STATE = `S1 ;
            end
         end   
      default : begin
                 nEXT_STATE = `S0; 
                 end 
             endcase
           end              
                  
///////////registered outputs/////

always @(posedge clk)
      begin                  
       if(~rst_n)
        begin
         mealy_glitch_free <= 1'b0;
          end
       else
   begin
       mealy_glitch_free <= out ;
       end                 
 end         
 
 assign out_mealy = out ; 
endmodule
