module random_generator (clk, reset, data);
  input logic clk, reset;
  output logic [1:0] data;

  wire feedback;
  logic [3:0] out
  
  assign feedback = ~(out[3] ^ out[2]);

  always @(posedge clk, posedge reset)
    begin
      if (reset)
        data = 2'bX;
      else
        out = {out[2:0],feedback};
        data = out % 4;
    end
endmodule

module random_generator_testbench();
  logic clk, reset;
  logic [1:0] data;

  random_generator dut (clk, reset, data);
  
  parameter clk_PERIOD=50;
    initial begin
      clk <= 0;
      forever #(clk_PERIOD) clk <= ~clk;
    enda
  integer i;

  initial begin
    reset <= 1; @(posedge clk);
    reset <= 0; @(posedge clk);

  //$stop; // End the simulation.
  end
endmodule