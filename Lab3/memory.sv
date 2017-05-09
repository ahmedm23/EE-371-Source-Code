
module memory (clk, reset, mem_used, scan, transfer, flush);
   input  logic clk, reset;
   output logic [7:0] mem_used;
   input  logic scan, transfer, flush;

   always_ff @ (posedge clk)
      if (reset | flush)                   mem_used <= 8'd0;
      else if (scan & mem_used < 8'd100)   mem_used <= mem_used + 8'd1;
      else if (transfer & mem_used > 8'd0) mem_used <= mem_used - 8'd2;
      else                                 mem_used <= mem_used;

endmodule

module memory_testbench ();
   logic clk, reset;
   logic [7:0] mem_used;
   logic scan, transfer, flush;

   memory dut (.clk, .reset, .mem_used, .scan, .transfer, .flush);

   parameter CLK_PER = 10;
   initial begin
      clk <= 1;
      forever #(CLK_PER/2) clk <= ~clk;
   end

   integer i;
   initial begin
                                                       @(posedge clk);
      reset <= 1;                                      @(posedge clk);
      reset <= 0;                                      @(posedge clk);
                                                       @(posedge clk);
                                                       @(posedge clk);
                  scan <= 1;                           @(posedge clk);
      for (i = 0; i < 108; i++) begin
         @(posedge clk);
      end
                  scan <= 0;                           @(posedge clk);
                                                       @(posedge clk);
                             transfer <= 1             @(posedge clk);
      for (i = 0; i < 60; i++) begin
         @(posedge clk);
      end
                             transfer <= 0             @(posedge clk);
                                                       @(posedge clk);
                  scan <= 1;                           @(posedge clk);
      for (i = 0; i < 10; i++) begin
         @(posedge clk);
      end
                  scan <= 0;                           @(posedge clk);
                                           flush <= 1; @(posedge clk);
                                           flush <= 0; @(posedge clk);
                                                       @(posedge clk);
   end
   $stop
endmodule
