
module SIPO_SR (sr_clk, reset, data_out, data_in);
   output logic [7:0] data_out;
   input  logic       sr_clk, reset, data_in;

   logic [9:0] buf = 10'b00_0000_0000;

   assign data_out = buf[8:1];

   always_ff @ (posedge sr_clk or posedge reset)
      if (reset) buf <= 10'b00_0000_0000;
      else       buf <= {data_in, buf[9:1]}; // Shift in least signif bit first
endmodule

