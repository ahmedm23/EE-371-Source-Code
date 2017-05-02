module controlMain (clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw,
                    w_up, w_down, arr_li, dep_li, gate1_li, gate2_li);
                        
      input clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw, w_up, w_down;
      output arr_li, dep_li, gate1_li, gate2_li;                
//  arr_sw   SW0 -- arr_li   LEDR0
//  dep_sw   SW1 -- dep_li   LEDR1
//  gate1_sw Sw2 -- gate1_li LEDR2  
//  gate2_sw Sw3 -- gate2_li LEDR3

//  w_up    KEY1
//  w_down  KEY2

//  reset KEY0
   
   arrivalLight a (.clk, .reset, .arr_sw, .arr_li);  
// Arrival Module that Ahmed will do 
//Input: Clk, reset, SW0 
//Output: LEDR0, (count of timer)
//   if SW = 1
//   After 5 min delay 
//   Turn on LEDR0
   
   // flags for whether the water is high or low
   logic water_high, water_low;

   controlWater c (.clk, .reset, .water_high, .water_low, .w_up, .w_down);
// Waterlevel Module
//Input: clk, reset, KEY1, KEY2
//Logic: Waterlevel
//Output: Waterlevel [5:0] 
//   Takes in key presses and adjusts water level accordingly

   logic exited, occupied;
   
   firstGate G1 (.clk, .reset, .gate1_sw, .water_high, .water_low, .arr_li, .exited,
                .gate1_li, .occupied);
// Allow Boat to Enter 1st Gate Module
//Input: clk, reset, SW2, Waterlevel, LEDR0, exited
//Output: LEDR2, Occupied


//   A: if waterlevel > 47 && LEDR0 = 1 && SW2 = 1 // if the two conditions are met and gate switch is high
//         Go to B  
//      else
//         Stay in A
//   B: If SW2 is flipped down = 0
//      Go to state C
//   C: if exited = 1 
//      Go to state A
//   assign LEDR2 = (ps == B); 
//   assign Occupied = (ps == C);
  
   secondGate G2 (.clk, .reset, .dep_sw, .gate2_sw, .water_high, .water_low, .occupied, 
                  .dep_li, .gate2_li, .exited); 
                  
// Allow Boat to Exit 2nd Gate Module
//Input: clk, reset, SW1, SW3, waterlevel, Occupied,  
//Output: LEDR1, LEDR3, exited  
//   A: if occupied and SW1 = 1
//      go to B
//   B: if waterlevel < 3 && SW3 = 1
//      go to C
//   C: if SW1 = 0 && SW3 = 0
//      go to D
//   D: go to state A
//   assign LEDR1 = (SW1 == 1 && occupied); //Depart light one when depart switch is high and Lock is occupied
//   assign LEDR3 = (ps == C);
//   assign exited = (ps == D);

  
endmodule
