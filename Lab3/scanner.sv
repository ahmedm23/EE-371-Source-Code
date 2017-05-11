
module primScanner (clk, reset, scan_status, rdy_transfer, start_scan_out,
                    goto_stby_out, mem_used, start_scan_in, goto_stby_in,
                    transfer);
   input  logic       clk, reset;
   output logic       scan_status, rdy_transfer, start_scan_out;
   output logic [7:0] mem_used;
   input  logic       start_scan_in, transfer;
   logic              scan, flush;

   memory buf (.clk, .reset, .mem_used, .scan, .transfer, .flush);

   enum {low_pwr, stby, idle, scanning} ps, ns;

   always_comb
      case (ps)
         scanning: if (mem_used < 80) begin
                      ns = scanning; // Buffer < 80, keep scanning
                      rdy_transfer = 0;
                      goto_stby_out = 0;
                      start_scan_out = 0;
                   end
                   else if (mem_used < 90) begin
                      ns = scanning;     // 80% full, keep scanning, but ready
                      rdy_transfer = 1;  // to transfer, signal other scanner to
                      goto_stby_out = 1; // go to stby
                      start_scan_out = 0;
                   end
                   else if (mem_used < 100) begin
                      ns = scanning;     // 90% full, keep scanning, still ready
                      rdy_transfer = 1;  // to transfer, signal other scanner to
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
endmodule

modoule secondScanner ();

endmodule
