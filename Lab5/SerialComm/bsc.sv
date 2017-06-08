
module bsc (sr_clk, clk16x, enable);
   output logic sr_clk;
   input  logic clk16x, enable;

   logic [3:0] count = 4'b0000;

   assign sr_clk = ~count[3] & enable; // posedge sr_clk at middle of bit

   always_ff @ (posedge clk16x)
      if (enable) count <= count + 1'b1;
      else        count <= 4'b0000;
endmodule

module bsc_testbench ();
   logic sr_clk;
   logic clk16x, enable;

   bsc dut (.sr_clk, .clk16x, .enable);

   parameter CLOCK_PERIOD = 100;
   initial begin
      clk16x <= 0;
      forever #(CLOCK_PERIOD / 2) clk16x <= ~clk16x;
   end

   integer i;
   initial begin
                               @(posedge clk16x);
      enable <= 0;             @(posedge clk16x);
      enable <= 1;             @(posedge clk16x);
                               @(posedge clk16x);
      for (i = 0; i < 32; i++) @(posedge clk16x);
      $stop;
   end
endmodule
