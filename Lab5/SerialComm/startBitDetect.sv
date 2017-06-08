
module startBitDetect (enable, data, char_received);
   output logic enable = 1'b0;
   input  logic data, char_received;

   always_ff @ (negedge data or posedge char_received)
      if (char_received) enable <= 0;
      else               enable <= 1;
endmodule

module startBitDetect_testbench ();
   logic enable;
   logic data, char_received;

   startBitDetect dut (.enable, .data, .char_received);

   initial begin
      data <= 1; char_received <= 0; #20;
      data <= 0;                     #90;
      data <= 1;                     #30;
                 char_received <= 1; #10;
      $stop;
   end
endmodule

