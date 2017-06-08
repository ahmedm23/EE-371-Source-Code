
module BIC (sr_clk, enable, data_complete);
   input  logic sr_clk, enable;
   output logic data_complete;

   logic [3:0] count = 4'b0000; // Can do this??

   assign data_complete = count == 4'b1011;

   always_ff @ (posedge sr_clk)
      if (enable) count <= count + 1'b1;
      else        count <= 4'b0000;
endmodule

