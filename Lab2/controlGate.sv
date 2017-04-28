module controlGate (clk, reset, upperSwitch, lowerSwitch, gateState, waterState, occupied);
   input clk, reset, upperSwitch, lowerSwitch, occupied;
   
   input reg [1:0] waterState;
   
   output reg [1;0] gateState;

   reg [2:0] ns;

   // Next state logic
   always_comb
      case(gateState)
         2'b00: if (~occupied & upperSwitch & waterState == 2'b11)     ns = 2'b01;
               else if (~occupied & lowerSwitch & waterState == 2'b10) ns = 2'b10;
               else if (occupied & upperSwitch & waterState == 2'b10)  ns = 2'b10  
               else if (occupied & lowerSwitch & waterState == 2'b11)  ns = 2'b01
               else                                                    ns = gateState;
         default:                                                      ns = 2'b00; 
      endcase 
   end
   
   // DFFs
   always_ff @(posedge clk)
   begina
      if (reset)
         gateState <= 2'b00;
      else
         gateState <= ns;
   end
endmodule