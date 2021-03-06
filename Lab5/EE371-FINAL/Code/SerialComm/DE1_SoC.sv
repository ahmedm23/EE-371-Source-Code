
module DE1_SoC (CLOCK_50, LEDR, KEY, GPIO_0);
   input  logic        CLOCK_50;
   output logic [7:0]  LEDR;
   input  logic [3:0]  KEY;
   inout  logic [35:0] GPIO_0;

   logic reset;
   assign reset = ~KEY[0];

   logic clk16x;
   clock16x clk_maker (.CLOCK_50, .clk16x); // clk16x = 16x 9600 Bps clk signal

   logic [7:0] data_in; // Data entering Nios II
   logic [7:0] data_out; // Data leaving Nios II
   

   // Receiver modules
   logic enable;
   logic char_complete;
   startBitDetect sbd (.enable, .data(GPIO_0[2]), .char_complete);

   logic sr_clk_Rx;
   bsc BSC_Rx (.sr_clk(sr_clk_Rx), .clk16x, .enable); // Generate sr_clk for Rx

   bic BIC_Rx (.sr_clk(sr_clk_Rx), .enable, .char_complete);

   SIPO_SR sr_Rx (.sr_clk(sr_clk_Rx), .reset, .data_out(data_in),
                  .data_in(GPIO_0[2])); 

   // Transmitter modules
   logic tx_enable;
   logic sr_clk_Tx;
   bsc BSC_Tx (.sr_clk(sr_clk_Tx), .clk16x, .enable(tx_enable));

   bic BIC_Tx (.sr_clk(sr_clk_Tx), .enable(tx_enable),
               .char_complete(char_complete_tx));

   logic load;
   PISO_SR sr_Tx (.sr_clk(sr_clk_Tx), .reset, .data_out(GPIO_0[3]),
                  .data_in(data_out), .load);

   
   nios_system niosii (.clk_clk                 (CLOCK_50),
                       .leds_export             (LEDR[7:0]),
                       .reset_reset_n           (KEY[0]),
                       .data_out_export         (data_out),
                       .data_in_export          (data_in),
                       .tx_enable_export        (tx_enable),
                       .char_complete_tx_export (char_complete_tx),
                       .char_complete_export    (char_complete),
                       .load_export             (load));
endmodule

module receiver_testbench ();
   logic       reset;
   logic       clk16x;
   logic       GPIO_00;
   logic [7:0] data_in;

   logic enable;
   logic char_complete;
   startBitDetect sbd (.enable, .data(GPIO_00), .char_complete);

   logic sr_clk_Rx;
   bsc bsc_rx (.sr_clk(sr_clk_Rx), .clk16x, .enable);

   bic bic_rx (.sr_clk(sr_clk_Rx), .enable, .char_complete);

   SIPO_SR sr_rx (.sr_clk(sr_clk_Rx), .reset, .data_out(data_in),
                  .data_in(GPIO_00));

   parameter CLOCK_PERIOD = 10;
   initial begin
      clk16x <= 0;
      forever #(CLOCK_PERIOD / 2) clk16x <= ~clk16x;
   end

   initial begin
                                  @(posedge clk16x);
      reset <= 1;                 @(posedge clk16x);
      reset <= 0;                 @(posedge clk16x);
      GPIO_00 <= 1;               @(posedge clk16x);
      GPIO_00 <= 1;               @(posedge clk16x);
      GPIO_00 <= 0; /*start bit*/ @(posedge clk16x);
      GPIO_00 <= 1; /*data LSB*/  @(posedge sr_clk_Rx);
      GPIO_00 <= 1;               @(posedge sr_clk_Rx);
      GPIO_00 <= 0;               @(posedge sr_clk_Rx);      
      GPIO_00 <= 0;               @(posedge sr_clk_Rx);
      GPIO_00 <= 0;               @(posedge sr_clk_Rx);
      GPIO_00 <= 0;               @(posedge sr_clk_Rx);
      GPIO_00 <= 1;               @(posedge sr_clk_Rx);
      GPIO_00 <= 0; /*data MSB*/  @(posedge sr_clk_Rx);
      GPIO_00 <= 1; /*stop bit*/  @(posedge sr_clk_Rx);
                                  @(posedge sr_clk_Rx);
                                  @(posedge sr_clk_Rx);
      $stop;
   end
endmodule

module transmitter_testbench ();
   logic       tx_enable;
   logic       char_complete_tx;
   logic       load;
   logic       GPIO_01;
   logic [7:0] data_out;
   logic       clk16x;
   logic       reset;

   logic sr_clk_Tx;
   bsc bsc_tx (.sr_clk(sr_clk_Tx), .clk16x, .enable(tx_enable));

   bic bic_tx (.sr_clk(sr_clk_Tx), .enable(tx_enable),
               .char_complete(char_complete_tx));

   PISO_SR sr_tx (.sr_clk(sr_clk_Tx), .reset, .data_out(GPIO_01),
                  .data_in(data_out), .load);

   parameter CLOCK_PERIOD = 10;
   initial begin
      clk16x <= 0;
      forever #(CLOCK_PERIOD / 2) clk16x <= ~clk16x;
   end

   initial begin
                                                          @(posedge clk16x);
      reset <= 1;                                         @(posedge clk16x);
      reset <= 0;                                         @(posedge clk16x);
      data_out <= 8'b01000011; tx_enable <= 1; load <= 1; @(posedge sr_clk_Tx);
                                               load <= 0; @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
                                tx_enable <= 0;           @(posedge sr_clk_Tx);
                                                          @(posedge sr_clk_Tx);
      $stop;
   end
endmodule
