
module SIPO_SR (sr_clk, reset, data_out, data_in);
   output logic [7:0] data_out;
   input  logic       sr_clk, reset, data_in;

   logic [9:0] buff = 10'b11_1111_1111;

   assign data_out = buff[8:1];

   always_ff @ (posedge sr_clk or posedge reset)
      if (reset) buff <= 10'b11_1111_1111;;
      else       buff <= {data_in, buff[9:1]}; // Shift in least sig bit first
endmodule

module SIPO_SR_testbench ();
   logic [7:0] data_out;
   logic       sr_clk, reset, data_in;

   SIPO_SR dut (.sr_clk, .reset, .data_out, .data_in);

   parameter CLOCK_PERIOD = 10;
   initial begin
      sr_clk <= 0;
      forever #(CLOCK_PERIOD / 2) sr_clk <= ~sr_clk;
   end

   initial begin
                                @(posedge sr_clk);
      reset <= 1;               @(posedge sr_clk);
      reset <= 0; data_in <= 1; @(posedge sr_clk);
                  data_in <= 1; @(posedge sr_clk);
                  data_in <= 1; @(posedge sr_clk);
                  data_in <= 0; @(posedge sr_clk);
                  data_in <= 0; @(posedge sr_clk);
                  data_in <= 0; @(posedge sr_clk);
                  data_in <= 0; @(posedge sr_clk);
                  data_in <= 1; @(posedge sr_clk);
                  data_in <= 0; @(posedge sr_clk);
                  data_in <= 0; @(posedge sr_clk);
                                @(posedge sr_clk);
      $stop;
   end
endmodule
