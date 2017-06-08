
module PISO_SR (sr_clk, reset, data_out, data_in, load);
   input  logic       sr_clk, reset;
   output logic       data_out;
   input  logic       load;
   input  logic [7:0] data_in;

   logic [9:0] buf = 10'b11_1111_1111;

   assign data_out = buf[9];

   always_ff @ (posedge sr_clk or posedge reset)
      if (reset)     buf <= 10'b11_1111_1111;
      else if (load) buf <= {1'b0, data_in, 1'b1};
      else           buf <= {buf[8:0], 1'b1};
endmodule

