
module startBitDetect(enable, data, char_received);
   output logic enable = 1'b0;
   input  logic data, char_received;

   always_ff @ (negedge data or posedge char_received)
      if (char_received) enable <= 0;
      else               enable <= 1;
endmodule

