module johnsonCounter(clk, reset, count);
   input clk, reset;
   output reg [3:0] count;

   integer ps, ns;
      
   always @ (posedge clk)
      if (~reset)
         ps <= 0;
      else
         case (ps)
         0: begin
               ps = 1;
               count = 4'b0000;
            end
         1: begin
               ps = 2;
               count = 4'b1000;
               end
         2: begin
               ps = 3;
               count = 4'b1100;
            end
         3: begin
               ps = 4;
               count = 4'b1110;
            end
         4: begin
               ps = 5;
               count = 4'b1111;
            end
         5: begin
               ps = 6;
               count = 4'b0111;
            end
         6: begin
               ps = 7;
               count = 4'b0011;
            end
         7: begin
               ps = 0;
               count = 4'b0001;
            end
      endcase

endmodule
