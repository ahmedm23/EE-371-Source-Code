module controlMain(clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw,
                   w_up, w_down, arr_li, dep_li, gate1_li, gate2_li);
//  Arrival Switch SW0 -- Arrival Light LEDR0
//  Depart  Switch SW1 -- Depart Light  LEDR1
//  1stGate Switch Sw2 -- 1stGate Light LEDR2  
//  2ndGate Switch Sw3 -- 2ndGate Light LEDR3
//  Raise_Water KEY1
//  Lower_Water KEY2

//  reset KEY0
   
   arrival a (.clk, .reset, .arr_sw, arr_li);  
// Arrival Module that Ahmed will do 
Input: Clk, reset, SW0 
Output: LEDR0, (count of timer)
   if SW = 1
   After 5 min delay 
   Turn on LEDR0
   
   logic water_level [5:0];

   controlWater c (.clk, .reset, .w_up, .w_down, .water_level);
// Waterlevel Module
Input: clk, reset, KEY1, KEY2
Logic: Waterlevel
Output: Waterlevel [5:0] 
   Takes in key presses and adjusts water level accordingly

   firstGate g (.clk, .reset, .gate1_sw   
// Allow Boat to Enter 1st Gate Module
Input: clk, reset, SW2, Waterlevel, LEDR0, exited
Output: LEDR2, Occupied
   A: if waterlevel > 47 && LEDR0 = 1 && SW2 = 1 // if the two conditions are met and gate switch is high
         Go to B  
      else
         Stay in A
   B: If SW2 is flipped down = 0
      Go to state C
   C: if exited = 1 
      Go to state A
   assign LEDR2 = (ps == B); 
   assign Occupied = (ps == C);
   
   
// Allow Boat to Exit 2nd Gate Module
Input: clk, reset, SW1, SW3, waterlevel, Occupied,  
Output: LEDR1, LEDR3, exited  
   A: if occupied and SW1 = 1
      go to B
   B: if waterlevel < 3 && SW3 = 1
      go to C
   C: if SW1 = 0 && SW3 = 0
      go to D
   D: go to state A
   assign LEDR1 = (SW1 == 1 && occupied); //Depart light one when depart switch is high and Lock is occupied
   assign LEDR3 = (ps == C);
   assign exited = (ps == D);


  
endmodule
