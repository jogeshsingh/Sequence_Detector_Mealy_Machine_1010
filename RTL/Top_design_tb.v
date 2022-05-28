`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2022 10:52:14 AM
// Design Name: 
// Module Name: Top_design_tb
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

`define S_WIDTH 2
module Top_design_tb();
reg clk , rst_n , d_in ;
wire out_mealy;
wire mealy_glitch_free ;
wire [`S_WIDTH-1:0] p_STATE ;


/////instantiation of design block/////
TOP_design DUT(clk , 
               rst_n , 
               d_in ,   
               out_mealy , 
               p_STATE, 
               mealy_glitch_free
                   );
  //setting default value of clk and reset to zero /////////
  initial
   begin
      clk = 1'b0 ;
      rst_n = 1'b0;
    end 
   
   ///clock gen/////
   always #5 clk = ~clk ;
   
  ///// applying reset ///
  initial
   begin
   
  repeat(2) @(posedge clk)
   rst_n <= 1'b1 ;
   repeat(5) @(posedge clk); 
  end
  
  ///applying input to design  module //
 initial
  begin
      #5 d_in = 1'b1;
      #10 d_in = 1'b0 ;
      #15 d_in = 1'b0;
      #5 d_in = 1'b1 ;
      #4 d_in = 1'b0;
      #3 d_in = 1'b0 ;
      #5 d_in = 1'b1;
      #6 d_in = 1'b0 ;
      #7 d_in = 1'b1 ;
      #2 d_in = 1'b0;
      #6 d_in = 1'b0 ;
      #7 d_in = 1'b0;
      #8 d_in = 1'b1 ;
      #2 d_in = 1'b1;
      #5 d_in = 1'b0 ;
      #8 d_in = 1'b1;
      #9 d_in = 1'b0 ;
      #5 d_in = 1'b0 ;
      #7 d_in = 1'b0;
      #8 d_in = 1'b1 ;
      #4 d_in = 1'b0;
      #7 d_in = 1'b0 ;
      #3 d_in = 1'b0;
      #5 d_in = 1'b0 ;
      #2 d_in = 1'b1;
      #4 d_in = 1'b0 ;
      #5 d_in = 1'b1 ;
      #600 $stop;
           end
   

//200 $finish ;

endmodule
