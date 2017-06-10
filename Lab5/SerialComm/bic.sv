
module bic (sr_clk, enable, char_complete);
   output logic char_complete = 1'b0;
   input  logic sr_clk, enable;

   logic [3:0] count = 4'b0000;

   assign char_complete = count == 4'b1011;

   always_ff @ (posedge sr_clk)
      if (enable & count < 4'b1010) count <= count + 1'b1;
      else                          count <= 4'b0000;
endmodule

module bic_testbench ();
   logic char_complete;
   logic sr_clk, enable;

   bic dut (.sr_clk, .enable, .char_complete);

   parameter CLOCK_PERIOD = 100;
   initial begin
      sr_clk <= 0;
      forever #(CLOCK_PERIOD / 2) sr_clk <= ~sr_clk;
   end

   initial begin
                   @(posedge sr_clk);
      enable <= 0; @(posedge sr_clk);
      enable <= 1; @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
      enable <= 0; @(posedge sr_clk);
                   @(posedge sr_clk);
                   @(posedge sr_clk);
      $stop;
   end
endmodule

