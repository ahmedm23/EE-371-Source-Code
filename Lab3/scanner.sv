
// Same behavior as altScanner but resets to scanning mode
module primScanner (clk, reset, rdy_xfer1, start_scan_out1, goto_stby_out1,
                    mem_used1, state1, start_scan_in, goto_stby_in, xfer,
                    alt_mem_used);
   input  logic       clk, reset;
   output logic       rdy_xfer1, start_scan_out1, goto_stby_out1;
   output logic [7:0] mem_used1;
   output logic [2:0] state1;
   input  logic       start_scan_in, goto_stby_in, xfer;
   input  logic [7:0] alt_mem_used;
   logic              scan, flush_mem;
   logic        [2:0] ps, ns;

   parameter
   low_pwr  = 3'b000,
   stby     = 3'b001,
   scanning = 3'b010,
   idle     = 3'b011,
   flushing = 3'b100,
   xferring = 3'b101;

   memory mem (.clk, .reset, .mem_used(mem_used1), .scan, .flush(flush_mem));

   always_comb begin
      case (ps)
         scanning: if (mem_used1 < 8'd100)        ns = scanning;
                   else                           ns = idle;
         xferring: if (mem_used1 > 8'd0)          ns = xferring;
                   else                           ns = low_pwr;
         flushing: if (mem_used1 > 8'd0)          ns = flushing;
                   else                           ns = low_pwr;
         low_pwr:  if (goto_stby_in)              ns = stby;
                   else                           ns = low_pwr;
         stby:     if (start_scan_in)             ns = scanning;
                   else                           ns = stby;
         idle:     if (xfer)                      ns = xferring;
                   else if (alt_mem_used > 8'd49) ns = flushing;
                   else                           ns = idle;
         default:                                 ns = low_pwr;
      endcase

      rdy_xfer1       = mem_used1 > 8'd79;
      goto_stby_out1  = rdy_xfer1;
      start_scan_out1 = ps == scanning & mem_used1 > 8'd89;

      scan      = ps == scanning;
      flush_mem = ps == xferring | ps == flushing;

      state1 = ps;
   end

   always_ff @ (posedge clk)
      if (reset)
         ps <= scanning;
      else
         ps <= ns;
endmodule

// Same behavior as primScanner except resets to low power mode
module altScanner (clk, reset, rdy_xfer2, start_scan_out2, goto_stby_out2,
                   mem_used2, state2, start_scan_in, goto_stby_in, xfer,
                   alt_mem_used);
   input  logic       clk, reset;
   output logic       rdy_xfer2, start_scan_out2, goto_stby_out2;
   output logic [7:0] mem_used2;
   output logic [2:0] state2;
   input  logic       start_scan_in, goto_stby_in, xfer;
   input  logic [7:0] alt_mem_used;
   logic              scan, flush_mem;
   logic        [2:0] ps, ns;

   parameter
   low_pwr  = 3'b000,
   stby     = 3'b001,
   scanning = 3'b010,
   idle     = 3'b011,
   flushing = 3'b100,
   xferring = 3'b101;

   memory mem (.clk, .reset, .mem_used(mem_used2), .scan, .flush(flush_mem));

   always_comb begin
      case (ps)
         scanning: if (mem_used2 < 8'd100)        ns = scanning;
                   else                           ns = idle;
         xferring: if (mem_used2 > 8'd0)          ns = xferring;
                   else                           ns = low_pwr;
         flushing: if (mem_used2 > 8'd0)          ns = flushing;
                   else                           ns = low_pwr;
         low_pwr:  if (goto_stby_in)              ns = stby;
                   else                           ns = low_pwr;
         stby:     if (start_scan_in)             ns = scanning;
                   else                           ns = stby;
         idle:     if (xfer)                      ns = xferring;
                   else if (alt_mem_used > 8'd49) ns = flushing;
                   else                           ns = idle;
         default:                                 ns = low_pwr;
      endcase

      rdy_xfer2       = mem_used2 > 8'd79;
      goto_stby_out2  = rdy_xfer2;
      start_scan_out2 = ps == scanning & mem_used2 > 8'd89;

      scan      = ps == scanning;
      flush_mem = ps == xferring | ps == flushing;

      state2 = ps;
   end

   always_ff @ (posedge clk)
      if (reset)
         ps <= low_pwr;
      else
         ps <= ns;
endmodule

module primScanner_testbench ();
   
endmodule

module altScanner_testbench ();
   logic       clk, reset;

   // Outputs
   logic       rdy_xfer2, start_scan_out2, goto_stby_out2;
   logic [7:0] mem_used2;
   logic [2:0] state2;

   // Inputs
   logic       start_scan_in, goto_stby_in, xfer;
   logic [7:0] alt_mem_used;

   parameter CLOCK_PERIOD = 100;
   initial begin
      clk <= 0;
      forever #(CLOCK_PERIOD/2) clk <= ~clk;
   end

   integer i;
   initial begin
                                                         @(posedge clk);
      reset <= 1;                                        @(posedge clk);
      reset <= 0;                                        @(posedge clk);
                  goto_stby_in <= 1;                     @(posedge clk);
                  goto_stby_in <= 0;                     @(posedge clk);
                                     start_scan_in <= 1; @(posedge clk);
                                     start_scan_in <= 0; @(posedge clk);
      for (i = 0; i < 108; i++)                          @(posedge clk);

   end
endmodule

