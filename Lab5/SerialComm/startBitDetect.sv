
module startBitDetect (enable, data, char_complete);
   output logic enable = 1'b0;
   input  logic data, char_complete;

   always_ff @ (negedge data or posedge char_complete)
      if (char_complete) enable <= 0;
      else               enable <= 1;
endmodule

module startBitDetect_testbench ();
   logic enable;
   logic data, char_complete;

   startBitDetect dut (.enable, .data, .char_complete);

   initial begin
      data <= 1; char_complete <= 0; #20;
      data <= 0;                     #90;
      data <= 1;                     #30;
                 char_complete <= 1; #10;
      $stop;
   end
endmodule

