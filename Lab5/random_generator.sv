module random_generator (clk, reset, data);
  input logic clk, reset;
  output logic [3:0] data;

  reg [3:0] data_next;

  always_comb begin
    data_next = data;
    //data_next[1] = data[1]^data[0];
    //data_next[0] = data[0]^data[1];
    repeat(4) begin
         data_next = {(data_next[3]^data_next[1]), data_next[3:1]};
    end
  end

  always_ff @(posedge clk) begin
    if(reset)
      data <= 4'h1f;
    else
      data <= data_next;
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
    end

  initial begin
    reset <= 1; @(posedge clk);
    reset <= 0; @(posedge clk);

  //$stop; // End the simulation.
  end
endmodule