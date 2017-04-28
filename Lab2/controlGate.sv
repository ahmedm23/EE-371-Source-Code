module controlGate (clk, reset, upper_switch, lower_switch, gate_state, water_status, occupied);
   input clk, reset, upper_switch, lower_switch, occupied;
   
   input reg [1:0] water_status;
   
   output reg [1;0] gate_state;

   reg [2:0] ps, ns;

   // Next state logic
   always_comb
      case(ps)
         2'b00: if (~occupied & upper_switch & water_status == 2'b11)     ns = 2'b01;
               else if (~occupied & lower_switch & water_status == 2'b10) ns = 2'b10;
               else if (occupied & upper_switch & water_status == 2'b10)  ns = 2'b10  
               else if (occupied & lower_switch & water_status == 2'b11)  ns = 2'b01
               else                                                       ns = gateState;
         default:                                                         ns = 2'b00; 
      endcase 
   
   assign gate_state = ps;

   // DFFs
   always_ff @(posedge clk)
   begina
      if (reset)
         ps <= 2'b00;
      else
         ps <= ns;
   end
endmodule