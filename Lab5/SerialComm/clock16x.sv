
module clock16x (CLOCK_50, clk16x);
   input  logic CLOCK_50;
   output logic clk16x;

   logic [7:0] count = 8'b0000_0000;

   always_ff @ (posedge CLOCK_50)
      if (count == 8'b1010_0010) begin
         count <= 8'b0000_0000; // Count to 162 on 50 MHz clk to get half of
         clk16x <= ~clk16x;     // 16x 9600 bps clk period
      end
      else begin
         count <= count + 1'b1;
         //clk16x <= clk16x;
      end
endmodule
