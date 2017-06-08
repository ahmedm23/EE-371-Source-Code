
module clock16x (CLOCK_50, clk16x);
   input  logic CLOCK_50;
   output logic clk16x = 0;

   logic [7:0] count = 8'b0000_0000;

   always_ff @ (posedge CLOCK_50)
      if (count == 8'b1010_0010) begin
         count <= 8'b0000_0000; // Count to 162 on 50 MHz clk to get half of
         clk16x <= ~clk16x;     // 16x 9600 bps clk period
      end
      else begin
         count <= count + 1'b1;
      end
endmodule

module clock16x_testbench ();
   logic CLOCK_50;
   logic clk16x;

   clock16x dut (.CLOCK_50, .clk16x);

   parameter CLOCK_PERIOD = 10;
   initial begin
      CLOCK_50 <= 0;
      forever #(CLOCK_PERIOD / 2) CLOCK_50 <= ~CLOCK_50;
   end

   integer i;
   initial begin
      for (i = 0; i < 1000; i++) @(posedge CLOCK_50);
      $stop;
   end
endmodule
