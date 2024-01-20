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

      if (in1 == in2 && in2 != in3) begin // two operands equal and one diverges
        vote = in1;
        detected = 1'b1; // fault detected

      end else if (in2 == in3 && in2 != in1) begin // two operands equal and one diverges
        vote = in2;
        detected = 1'b1; // fault detected

      end else if (in1 == in3 && in1 != in2) begin // two operands equal and one diverges
        vote = in1;
        detected = 1'b1; // fault detected

      end else begin // all are equal
        detected = 1'b0; // no fault detected
        vote = in1;
      end 

    end else begin
      // All inputs are different -> choose in1
      vote = in1;
      detected = 1'b1; // Fault detected
    end
  end

endmodule
