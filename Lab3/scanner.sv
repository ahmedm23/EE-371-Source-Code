
module primScanner (clk, reset, scan_status, rdy_flush, start_scan_out,
                    goto_stby_out, mem_used, start_scan_in, goto_stby_in, flush,
                    alt_mem_used);
   input  logic       clk, reset;
   output logic       scan_status, rdy_flush, start_scan_out;
   output logic [7:0] mem_used;
   input  logic       start_scan_in, flush;
   input  logic [7:0] alt_mem_used;
   logic              scan, flush_mem;

   memory mem (.clk, .reset, .mem_used, .scan, .flush(flush_mem));

   enum {low_pwr, stby, idle, scanning, flushing} ps, ns;

   always_comb begin
      case (ps)
         scanning: if (mem_used < 8'd80) begin
                      ns = scanning; // Buffer < 80, keep scanning
                      rdy_flush = 0;
                      goto_stby_out = 0;
                      start_scan_out = 0;
                   end
                   else if (mem_used < 8'd90) begin
                      if (flush) ns = flushing;
                      else       ns = scanning;
                      rdy_flush = 1;      // 80% full, keep scanning, but ready
                      goto_stby_out = 1;  // to transfer, signal other scanner 
                      start_scan_out = 0; // to go to stby
                   end
                   else if (mem_used < 8'd100) begin
                      if (flush) ns = flushing;
                      else       ns = scanning;
                      rdy_flush = 1;      // 90% full, keep scanning, still
                      goto_stby_out = 0;  // ready to transfer, signal other
                      start_scan_out = 1; // scanner to start scanning
                   end
                   else begin // 100% full
                      if (flush | alt_mem_used > 8'd49) ns = flushing;
                      else                              ns = idle;
                      rdy_flush = 1;
                      goto_stby_out = 0;
                      start_scan_out = 1;
                   end
         flushing: begin 
                      if (mem_used > 8'd0) ns = flushing;
                      else                 ns = low_pwr;
                      rdy_flush = 0;
                      goto_stby_out = 0;
                      start_scan_out = 0;
                   end
         low_pwr:  begin
                      if (goto_stby_in) ns = stby;
                      else              ns = low_pwr;
                      rdy_flush = 0;
                      goto_stby_out = 0;
                      start_scan_out = 0;
                   end
         stby:     begin
                      if (start_scan_in) ns = scanning;
                      else               ns = stby;
                      rdy_flush = 0;
                      goto_stby_out = 0;
                      start_scan_out = 0;
                   end
         idle:     begin
                      if (flush) ns = flushing;
                      else       ns = idle;
                      rdy_flush = 0;
                      goto_stby_out = 0;
                      start_scan_out = 0;
                   end

      flush_mem = ps == flushing;
   end

   always_ff @ (posedge clk)
      if (reset)
         ps <= scanning;
      else
         ps <= ns;


// 3 bit state output
// Low power  000
// stby       001
// collecting 010
// idle       011
// flushing   100


endmodule

modoule altScanner ();
   // Reset to low power mode
endmodule
