
module bsc (sr_clk, clk16x, enable);
   input  logic clk16x, enable;
   output logic sr_clk;

   logic [3:0] count = 4'b0000;

   assign sr_clk = ~count[3] & enable;

   always_ff @ (posedge clk16x)
      if (enable) count <= count + 1'b1;
      else        count <= 4'b0000;
endmodule

