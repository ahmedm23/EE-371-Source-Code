module random_generator (clk, reset, data);
  input logic clk, reset;
  output logic [1:0] data;

  always_ff @(posedge clk) begin
    if(reset)
      data <= 2'h1f;
    else
      data = $urandom_range(4,0);
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