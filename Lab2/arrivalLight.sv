module arrivalLight (clk, reset, arr_sw, arr_li);
   input clk, reset, arr_sw;

   output reg arr_li;
   reg [3:0] count;

   // DFFs
   always_ff @(posedge clk)
   begin
      if (reset | ~arr_sw)
         begin
            count   <= 4'b1111;
            arr_li <= 0; 
         end
      else if (count == 4'b000) 
         begin
            arr_li <= 1;
            count   <= 4'b1111;
         end
      else
         count <= count - 4'b0001;
   end
endmodule

module arrivalLightTestbench ();
   logic clk, reset, arr_li;
   logic arr_li;
   
   arrivalLight test (clk, reset, arr_sw, arr_li);
   
   parameter clk_PERIOD=50;
   initial begin
      clk <= 0;
      forever #(clk_PERIOD) clk <= ~clk;
   end

   initial begin
                                                   @(posedge clk);
   reset <= 1;                                     @(posedge clk);
   reset <= 0; arr_li = 0;                         @(posedge clk);
                                                   @(posedge clk);
               arr_li = 1;                         @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);

   //$stop; // End the simulation.
   end
endmodule