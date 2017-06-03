
module startBitDetect(reset, enable, data, char_received);
   input  logic reset;
   output logic enable;
   input  logic data, char_received;

   always_ff @ (posedge reset | negedge data | posedge char_received)
      if (reset | char_received) enable <= 0;
      else                       enable <= 1;
endmodule

