
module primScanner (clk, reset, scan_status, rdy_flush, start_scan_out,
                    goto_stby_out, mem_used, start_scan_in, goto_stby_in, flush,
                    alt_mem_used);
   input  logic       clk, reset;
   output logic       scan_status, rdy_flush, start_scan_out;
   output logic [7:0] mem_used;
   input  logic       start_scan_in, flush;
   input  logic [7:0] alt_mem_used;
   logic              scan;

   memory buf (.clk, .reset, .mem_used, .scan, .flush);

   enum {low_pwr, stby, idle, scanning, flushing} ps, ns;

   always_comb
      case (ps)
         scanning: if (mem_used < 80) begin
                      ns = scanning; // Buffer < 80, keep scanning
                      rdy_flush = 0;
                      goto_stby_out = 0;
                      start_scan_out = 0;
                   end
                   else if (mem_used < 90) begin
                      if (flush) ns = flushing;
                      else       ns = scanning;
                      rdy_flush = 1;      // 80% full, keep scanning, but ready
                      goto_stby_out = 1;  // to transfer, signal other scanner 
                      start_scan_out = 0; // to go to stby
                   end
                   else if (mem_used < 100) begin
                      ns = scanning;     // 90% full, keep scanning, still ready
                      rdy_flush = 1;     // to transfer, signal other scanner to
                      goto_stby_out = 0; // start scanning
                      start_scan_out = 1;
                   end
                   else begin // 100% full
                      ns = 

   always_ff @ (posedge clk)
      if (reset)
         ps = scanning;
      else
         ps = ns;


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
