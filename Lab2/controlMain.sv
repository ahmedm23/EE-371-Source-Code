//module controlMain (clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw, dir,
//                    w_up, w_down, arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low);
module controlMain (clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw, dir,
                    w_up, w_down, arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low);                        
   input clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw, dir, w_up, w_down;
//   output arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low;  
   output arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low;                
   

   //TEST
   logic water_flag1, water_flag2;
   mux_water flag (.water_high, .water_low, .water_flag1, .water_flag2, .dir);
//   mux_water_level flag (.wh, .wl, .water_flag1, .water_flag2, .dir);


         
      
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
//   firstGate G1 (.clk, .reset, .gate1_sw, .water_high, .arr_li, .exited,
//                .gate1_li, .occupied);
//     
//
//
//   secondGate G2 (.clk, .reset, .dep_sw, .gate2_sw, .water_low, .occupied, 
//                  .dep_li, .gate2_li, .exited);
//                  
                     //TEST   
   firstGate G1 (.clk, .reset, .gate1_sw, .water_high(water_flag1), .arr_li, .exited,
                .gate1_li, .occupied);                
                
                  
   secondGate G2 (.clk, .reset, .dep_sw, .gate2_sw, .water_low(water_flag2), .occupied, 
                  .dep_li, .gate2_li, .exited);  
endmodule


module mux_water (water_high, water_low, dir, water_flag1, water_flag2);
	input logic water_high, water_low, dir;
	output logic water_flag1, water_flag2;
	assign water_flag1 = (water_low & dir) | (water_high & ~dir);
	assign water_flag2 = (water_high & dir) | (water_low & ~dir);
endmodule

//module mux_water (wh, wl, dir, water_flag1, water_flag2);
//	input logic wh, wl, dir;
//	output logic water_flag1, water_flag2;
//	assign water_flag1 = (wl & dir) | (wh & ~dir);
//	assign water_flag2 = (wh & dir) | (wl & ~dir);
//endmodule


module controlMain_testbench ();
	logic clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw, dir,
                    w_up, w_down, arr_li, dep_li, gate1_li, gate2_li, occupied, water_high, water_low;

	controlMain dut (.clk, .reset, .arr_sw, .dep_sw, .gate1_sw, .gate2_sw, .dir,
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
      reset <= 0; dir <= 0;                   @(posedge clk);
                   arr_sw <= 1;               @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
		w_up <= 1;
		gate1_sw <= 1;  						      @(posedge clk);
	  for (i = 0; i < 50; i++) begin
         @(posedge clk);
      end
	// arrival light and gate1 light are on at this point       
	gate1_sw <= 0; arr_sw <= 0; w_up <= 0; 	 @(posedge clk);
	// occupied flag is on				
											 @(posedge clk);
                                             @(posedge clk);
	dep_sw <= 1; //w_down <= 1;	gate2_sw <= 1;									 
                                             @(posedge clk);
    for (i = 0; i < 50; i++) begin
         @(posedge clk);
      end										 
                                               @(posedge clk);
                                               @(posedge clk);
    gate2_sw <= 0; dep_sw <= 0;                @(posedge clk);
                                               @(posedge clk);
                                               @(posedge clk);
                                               @(posedge clk);
                                               @(posedge clk);
// ------------------------------------------//
      reset <= 1;                            @(posedge clk);
      reset <= 0;  dir <= 1;                 @(posedge clk);
                   arr_sw <= 1;               @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
		w_up <= 1;
		gate1_sw <= 1;  						      @(posedge clk);
	  for (i = 0; i < 50; i++) begin
         @(posedge clk);
      end
	// arrival light and gate1 light are on at this point       
	gate1_sw <= 0; arr_sw <= 0; w_down <= 0; 	 @(posedge clk);
	// occupied flag is on				
											 @(posedge clk);
                                             @(posedge clk);
	dep_sw <= 1; //w_down <= 1;	gate2_sw <= 1;									 
                                             @(posedge clk);
    for (i = 0; i < 50; i++) begin
         @(posedge clk);
      end										 
                                               @(posedge clk);
                                               @(posedge clk);
    gate2_sw <= 0; dep_sw <= 0;                @(posedge clk);
                                               @(posedge clk);
                                               @(posedge clk);
                                               @(posedge clk);
                                               @(posedge clk);
                                               

      $stop;
   end
endmodule
