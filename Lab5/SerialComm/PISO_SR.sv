
module PISO_SR (sr_clk, reset, data_out, data_in, load);
   input  logic       sr_clk, reset;
   output logic       data_out;
   input  logic       load;
   input  logic [7:0] data_in;

   logic [9:0] buf = 10'b11_1111_1111;

   assign data_out = buf[0]; // Shift out least signif bit first

   always_ff @ (posedge sr_clk or posedge reset)
      if (reset)     buf <= 10'b11_1111_1111;
      else if (load) buf <= {1'b1, data_in, 1'b0};
      else           buf <= {1'b1, buf[9:1]}; // Shift out least signif bit
endmodule

