module controlMain (clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw,
                    w_up, w_down, arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low);
                        
      input clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw, w_up, w_down;
      output arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low;                
//  arr_sw   SW0 -- arr_li   LEDR0
//  dep_sw   SW1 -- dep_li   LEDR1
//  gate1_sw Sw2 -- gate1_li LEDR2  
//  gate2_sw Sw3 -- gate2_li LEDR3
//  w_up    KEY1
//  w_down  KEY2
//  reset KEY0
   
   arrivalLight a (.clk, .reset, .arr_sw, .arr_li);  
   controlWater c (.clk, .reset, .water_high, .water_low, .w_up, .w_down);

   logic exited;//, occupied;
   firstGate G1 (.clk, .reset, .gate1_sw, .water_high, .water_low, .arr_li, .exited,
                .gate1_li, .occupied);
                
   secondGate G2 (.clk, .reset, .dep_sw, .gate2_sw, .water_high, .water_low, .occupied, 
                  .dep_li, .gate2_li, .exited); 
                  

  
endmodule

module controlMain_testbench ();
	logic clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw,
                    w_up, w_down, arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low;

	controlMain dut (.clk, .reset, .arr_sw, .dep_sw, .gate1_sw, .gate2_sw,
                     .w_up, .w_down, .arr_li, .dep_li, .gate1_li, .gate2_li, 
					 .occupied, .water_high, .water_low);
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
                   arr_sw <= 1;               @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
		w_up <= 1;
		gate1_sw <= 1;  						      @(posedge clk);
	  for (i = 0; i < 8; i++) begin
         @(posedge clk);
      end
	// arrival light and gate1 light are on at this point       
	gate1_sw <= 0; arr_sw <= 0; w_up <= 0; 	 @(posedge clk);
	// occupied flag is on				
											 @(posedge clk);
                                             @(posedge clk);
	dep_sw <= 1; w_down <= 1;	gate2_sw <= 1;									 
                                             @(posedge clk);
    for (i = 0; i < 8; i++) begin
         @(posedge clk);
      end										 
                                               @(posedge clk);
                                             @(posedge clk);
    gate2_sw <= 0; dep_sw <= 0;                 @(posedge clk);
                                             @(posedge clk);
                                                @(posedge clk);
                                              @(posedge clk);
                                              @(posedge clk);

      $stop;
   end
endmodule
