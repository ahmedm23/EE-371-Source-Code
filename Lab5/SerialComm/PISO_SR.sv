
module PISO_SR (sr_clk, reset, data_out, data_in, load);
   input  logic       sr_clk, reset;
   output logic       data_out;
   input  logic       load;
   input  logic [7:0] data_in;

   logic [9:0] buff = 10'b11_1111_1111;

   assign data_out = buff[0]; // Shift out least signif bit first

   always_ff @ (posedge sr_clk or posedge reset)
      if (reset)     buff <= 10'b11_1111_1111;
      else if (load) buff <= {1'b1, data_in, 1'b0};
      else           buff <= {buff[8:0], 1'b1}; // Shift out least signif bit
endmodule

module PISO_SR_testbench ();
   logic       sr_clk, reset;
   logic       data_out;
   logic       load;
   logic [7:0] data_in;

   PISO_SR dut (.sr_clk, .reset, .data_out, .data_in, .load);

   parameter CLOCK_PERIOD = 10;
   initial begin
      sr_clk <= 0;
      forever #(CLOCK_PERIOD / 2) sr_clk <= ~sr_clk;
   end

   integer i;
   initial begin
                                          @(posedge sr_clk);
      reset <= 1;                         @(posedge sr_clk);
      reset <= 0;                         @(posedge sr_clk);
      data_in <= 8'b0100_0011; load <= 1; @(posedge sr_clk);
                               load <= 0; @(posedge sr_clk);
      for (i = 0; i < 12; i++)            @(posedge sr_clk);
      data_in <= 8'b1001_1001; load <= 1; @(posedge sr_clk);
                               load <= 0; @(posedge sr_clk);
      for (i = 0; i < 24; i++)            @(posedge sr_clk);
      $stop;
   end
endmodule
