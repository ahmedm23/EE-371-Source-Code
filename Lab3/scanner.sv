
module primScanner (clk, reset, rdy_flush, start_scan_out,
                    goto_stby_out, mem_used, state, start_scan_in, goto_stby_in,
                    flush, alt_mem_used);
   input  logic       clk, reset;
   output logic       rdy_flush, start_scan_out, goto_stby_out;
   output logic [7:0] mem_used;
   output logic [2:0] state;
   input  logic       start_scan_in, goto_stby_in, flush;
   input  logic [7:0] alt_mem_used;
   logic              scan, flush_mem;
   logic        [2:0] ps, ns;

   parameter
   low_pwr  = 3'b000,
   stby     = 3'b001,
   scanning = 3'b010,
   idle     = 3'b011,
   flushing = 3'b100;

   memory mem (.clk, .reset, .mem_used, .scan, .flush(flush_mem));

   always_comb begin
      case (ps)
         scanning: if (mem_used < 8'd80)                ns = scanning;
                   else if (mem_used == 8'd100)         ns = idle;
                   else // Buffer between 80 and 100
                      if (flush)                        ns = flushing;
                      else                              ns = scanning;
         flushing: if (mem_used > 8'd0)                 ns = flushing;
                   else                                 ns = low_pwr;
         low_pwr:  if (goto_stby_in)                    ns = stby;
                   else                                 ns = low_pwr;
         stby:     if (start_scan_in)                   ns = scanning;
                   else                                 ns = stby;
         idle:     if (flush | alt_mem_used > 8'd49)    ns = flushing;
                   else                                 ns = idle;
         default:                                       ns = low_pwr;
      endcase

      rdy_flush      = ps == scanning & mem_used > 8'd79;
      goto_stby_out  = rdy_flush & mem_used > 8'd89;
      start_scan_out = ps == scanning & mem_used > 8'd89;

      scan      = ps == scanning;
      flush_mem = ps == flushing;

      state = ps;
   end

   always_ff @ (posedge clk)
      if (reset)
         ps <= scanning;
      else
         ps <= ns;
endmodule

// Same behavior as primScanner except resets to low power mode
module altScanner (clk, reset, rdy_flush, start_scan_out,
                   goto_stby_out, mem_used, state, start_scan_in, goto_stby_in,
                   flush, alt_mem_used);
   input  logic       clk, reset;
   output logic       rdy_flush, start_scan_out, goto_stby_out;
   output logic [7:0] mem_used;
   output logic [2:0] state;
   input  logic       start_scan_in, goto_stby_in, flush;
   input  logic [7:0] alt_mem_used;
   logic              scan, flush_mem;
   logic        [2:0] ps, ns;

   parameter
   low_pwr  = 3'b000,
   stby     = 3'b001,
   scanning = 3'b010,
   idle     = 3'b011,
   flushing = 3'b100;

   memory mem (.clk, .reset, .mem_used, .scan, .flush(flush_mem));

   always_comb begin
      case (ps)
         scanning: if (mem_used < 8'd80)                ns = scanning;
                   else if (mem_used == 8'd100)         ns = idle;
                   else // Buffer between 80 and 100
                      if (flush)                        ns = flushing;
                      else                              ns = scanning;
         flushing: if (mem_used > 8'd0)                 ns = flushing;
                   else                                 ns = low_pwr;
         low_pwr:  if (goto_stby_in)                    ns = stby;
                   else                                 ns = low_pwr;
         stby:     if (start_scan_in)                   ns = scanning;
                   else                                 ns = stby;
         idle:     if (flush | alt_mem_used > 8'd49)    ns = flushing;
                   else                                 ns = idle;
         default:                                       ns = low_pwr;
      endcase

      rdy_flush      = ps == scanning & mem_used > 8'd79;
      goto_stby_out  = rdy_flush & mem_used > 8'd89;
      start_scan_out = ps == scanning & mem_used > 8'd89;

      scan      = ps == scanning;
      flush_mem = ps == flushing;

      state = ps;
   end

   always_ff @ (posedge clk)
      if (reset)
         ps <= low_pwr;
      else
         ps <= ns;
endmodule
