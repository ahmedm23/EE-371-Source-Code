
module controlWater (clk, reset, water_high, water_low, w_up, w_down);
   input  logic clk, reset;
   output logic water_high, water_low;
   input  logic w_up, w_down;

   logic [7:0] water_counter; // This counter for timing of raise/lower water

   enum {low, high, raise, lower} ps, ns;

   always_comb begin
      case (ps)
         low:   begin
                   if (w_up) ns = raise;
                   else      ns = low;
                end
         high:  begin
                   if (w_down) ns = lower;
                   else        ns = high;
                end
         raise: begin
                   if (water_counter < 8'd80) ns = raise;
                   else                       ns = high;
                end
         lower: begin
                   if (water_counter < 8'd70) ns = lower;
                   else                       ns = low;
                end
      endcase

      // Timing for water to go 0' -> 4.7'
      // Timing for water to go 5' -> 0.3'
      water_high = (water_counter > 8'd74) | ps == high;
      water_low = (water_counter > 8'd65 & ps == lower) | ps == low;
   end

   always_ff @ (posedge clk)
      if (reset) begin
         ps <= low; // What should be the default state?
         water_counter <= 8'd0;
      end
      else begin
         ps <= ns;
         if (ps == raise | ps == lower) water_counter <= water_counter + 8'd1;
         else                           water_counter <= 8'd0;
      end
endmodule

module comparator_8bit (gt, eq, lt, a, b);
   output logic gt, eq, lt;
   input  logic [7:0] a, b;
   logic gt_l, gt_r, eq_l, eq_r, lt_l, lt_r;

   comparator_4bit l_comp (.gt(gt_l), .eq(eq_l), .lt(lt_l), .a(a[7:4]), .b(b[7:4]));
   comparator_4bit r_comp (.gt(gt_r), .eq(eq_r), .lt(lt_r), .a(a[3:0]), .b(b[3:0]));

   assign gt = gt_l | gt_r;
   assign eq = eq_l & eq_r;
   assign lt = lt_l | lt_r;
endmodule

module comparator_4bit (gt, eq, lt, a, b);
   output logic gt, eq, lt;
   input  logic [3:0] a, b;

   logic [3:0] gt_arr, eq_arr, lt_arr;

   always_comb begin
      gt_arr[3] = a[3] & ~b[3];
      gt_arr[2] = a[2] & ~b[2];
      gt_arr[1] = a[1] & ~b[1];
      gt_arr[0] = a[0] & ~b[0];
 
      eq_arr[3] = a[3] ~^ b[3];
      eq_arr[2] = a[2] ~^ b[2];
      eq_arr[1] = a[1] ~^ b[1];
      eq_arr[0] = a[0] ~^ b[0];
      
      lt_arr[3] = ~a[3] & b[3];
      lt_arr[2] = ~a[2] & b[2];
      lt_arr[1] = ~a[1] & b[1];
      lt_arr[0] = ~a[0] & b[0];
   end

   assign gt = gt_arr[3] | gt_arr[2] | gt_arr[1] | gt_arr[0];
   assign eq = eq_arr[3] & eq_arr[2] & eq_arr[1] & eq_arr[0];
   assign lt = lt_arr[3] | lt_arr[2] | lt_arr[1] | lt_arr[0];
endmodule

module controlWater_testbench ();
   logic clk, reset, w_up, w_down;
   logic water_high, water_low;

   controlWater dut (.clk, .reset, .water_high, .water_low, .w_up, .w_down);

   parameter CLK_PER = 10;
   initial begin
      clk <= 1;
      forever #(CLK_PER/2) clk <= ~clk;
   end

   integer i;
   initial begin
                                             @(posedge clk);
      reset <= 1;                            @(posedge clk);
      reset <= 0;                            @(posedge clk);
                  w_down <= 1;               @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
                  w_down <= 0;               @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
                               w_up <= 1;    @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
                               w_up <= 0;    @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
      for (i = 0; i < 80; i++) begin
         @(posedge clk);
      end
                               w_up <= 1;    @(posedge clk);
                               w_up <= 0;    @(posedge clk);
                  w_down <= 1;               @(posedge clk);
                  w_down <= 0;               @(posedge clk);
      for (i = 0; i < 80; i++) begin
         @(posedge clk);
      end
      $stop;
   end
endmodule

module comparator_8bit_testbench();
   logic gt, eq, lt;
   logic [7:0] a, b;

   comparator_8bit dut (.gt, .eq, .lt, .a, .b);

   integer i, j;
   initial begin
      for (i = 0; i < 256; i++) begin
         a = i;
         for (j = 0; j < 256; j++) begin
            b = j; #10;
         end
      end
   end
endmodule

module comparator_4bit_testbench ();
   logic gt, eq, lt;
   logic [3:0] a, b;

   comparator_4bit dut (.gt, .eq, .lt, .a, .b);

   integer i, j;
   initial begin
      for (i = 0; i < 16; i++) begin
         a = i;
         for (j = 0; j < 16; j++) begin
            b = j; #10;
         end
      end
   end
endmodule
