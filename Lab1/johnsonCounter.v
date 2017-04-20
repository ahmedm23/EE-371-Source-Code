module johnsonCounter(clk, reset, count);
   input clk, reset;
   output reg [3:0] count;

   always @ (posedge clk)
      if (!reset) // Display 4'b0000 as soon as reset activates
         count <= 4'b0000;
      else begin // Shift the bits through each position
			count[3] <= ~count[0];
			count[2] <= count[3];
			count[1] <= count[2];
			count[0] <= count[1];
		end
endmodule
