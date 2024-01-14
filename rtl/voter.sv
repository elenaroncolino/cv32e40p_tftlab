module voter #(parameter BIT_WIDTH = 1) (
  input logic [BIT_WIDTH-1:0] in1,
  input logic [BIT_WIDTH-1:0] in2,
  input logic [BIT_WIDTH-1:0] in3,
  output logic [BIT_WIDTH-1:0] vote,
  output logic detected
);

  // Fault-tolerant voter logic
  always_comb begin
    if (in1 == in2 || in2 == in3 || in1 == in3) begin
      // At least two inputs agree
      vote = (in1 == in2) ? in1 : in2;
      vote = (vote == in3) ? vote : in3;
      detected = 1'b0; // No fault detected
    end else begin
      // All inputs are different -> choose the majority
      vote = (in1 + in2 + in3) >= 2 ? 1'b1 : 1'b0;
      detected = 1'b1; // Fault detected
    end
  end

endmodule
