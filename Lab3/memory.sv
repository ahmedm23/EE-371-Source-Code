
module memory (clk, reset, mem_used, scan, flush);
   input  logic       clk, reset;
   output logic [7:0] mem_used;
   input  logic       scan, flush;

   always_ff @ (posedge clk)
      if (reset)                         mem_used <= 8'd0;
      else if (scan & mem_used < 8'd100) mem_used <= mem_used + 8'd1;
      else if (flush & mem_used > 8'd2)  mem_used <= mem_used - 8'd3;
      else if (flush & mem_used > 8'd0)  mem_used <= mem_used - 8'd1;
      else                               mem_used <= mem_used;

endmodule

module memory_testbench ();
   logic clk, reset;
   logic [7:0] mem_used;
   logic scan, flush;

   memory dut (.clk, .reset, .mem_used, .scan, .flush);

   parameter CLK_PER = 10;
   initial begin
      clk <= 1;
      forever #(CLK_PER/2) clk <= ~clk;
   end

   integer i;
   initial begin
                                         @(posedge clk);
      reset <= 1; scan <= 0; flush <= 0; @(posedge clk);
      reset <= 0;                        @(posedge clk);
                                         @(posedge clk);
                                         @(posedge clk);
                  scan <= 1;             @(posedge clk);

      for (i = 0; i < 108; i++)          @(posedge clk);

                  scan <= 0;             @(posedge clk);
                                         @(posedge clk);
                             flush <= 1; @(posedge clk);

      for (i = 0; i < 60; i++)           @(posedge clk);

                             flush <= 0; @(posedge clk);
                                         @(posedge clk);
                  scan <= 1;             @(posedge clk);

      for (i = 0; i < 10; i++)           @(posedge clk);

                  scan <= 0;             @(posedge clk);
                             flush <= 1; @(posedge clk);
                             flush <= 0; @(posedge clk);
                                         @(posedge clk);
   $stop;
   end
endmodule
