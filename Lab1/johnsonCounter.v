module johnsonCounter(clk, reset, count);
   input clk, reset;
   output reg [3:0] count;

   // Assign parameters for each state
   parameter state0 = 4'b0000;
   parameter state1 = 4'b1000;
   parameter state2 = 4'b1100;
   parameter state3 = 4'b1110;
   parameter state4 = 4'b1111;
   parameter state5 = 4'b0111;
   parameter state6 = 4'b0011;
   parameter state7 = 4'b0001;

   always @ (posedge clk)
      if (~reset) // Display 4'b0000 as soon as reset activates
         count <= state0;
      else
         case (count) // Proceed through the states above as listed
            state0: count = state1;
            state1: count = state2;
            state2: count = state3;
            state3: count = state4;
            state4: count = state5;
            state5: count = state6;
            state6: count = state7;
            state7: count = state0;
         endcase
endmodule
