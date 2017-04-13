module johnsonCounter(clk, reset, count);
   input clk, reset;
   output reg [3:0] count;

   integer ps, ns;

   always
      case (ps)
         0: begin
               ns = 1;
               count = 4'b0000;
            end
         1: begin
               ns = 2;
               count = 4'b1000;
               end
         2: begin
               ns = 3;
               count = 4'b1100;
            end
         3: begin
               ns = 4;
               count = 4'b1110;
            end
         4: begin
               ns = 5;
               count = 4'b1111;
            end
         5: begin
               ns = 6;
               count = 4'b0111;
            end
         6: begin
               ns = 7;
               count = 4'b0011;
            end
         7: begin
               ns = 0;
               count = 4'b0001;
            end
      endcase

   always @ (posedge clk)
      if (~reset)
         ps <= 0;
      else
         ps <= ns;
endmodule
