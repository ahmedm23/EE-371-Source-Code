module controlGate (clk, reset, upper_switch, lower_switch, gate_state, water_status, occupied);
   input clk, reset, upper_switch, lower_switch, occupied;
   
   input reg [1:0] water_status;
   
   output reg [1;0] gate_state;

   reg [2:0] ns;

   // Next state logic
   always_comb
      case(gate_state)
         2'b00: if (~occupied & upper_switch & water_status == 2'b11)     ns = 2'b01;
               else if (~occupied & lower_switch & water_status == 2'b10) ns = 2'b10;
               else if (occupied & upper_switch & water_status == 2'b10)  ns = 2'b10  
               else if (occupied & lower_switch & water_status == 2'b11)  ns = 2'b01
               else                                                       ns = gateState;
         default:                                                         ns = 2'b00; 
      endcase 
   
   // DFFs
   always_ff @(posedge clk)
   begina
      if (reset)
         gate_state <= 2'b00;
      else
         gate_state <= ns;
   end
endmodule