module cv32e40p_mult_fault
  import cv32e40p_pkg::*;
(
    input logic clk,
    input logic rst_n,
    input logic        enable_i,
    input mul_opcode_e operator_i,

    // integer and short multiplier
    input logic       short_subword_i,
    input logic [1:0] short_signed_i,
    input logic [31:0] op_a_i,
    input logic [31:0] op_b_i,
    input logic [31:0] op_c_i,
    input logic [4:0] imm_i,

    // dot multiplier
    input logic [ 1:0] dot_signed_i,
    input logic [31:0] dot_op_a_i,
    input logic [31:0] dot_op_b_i,
    input logic [31:0] dot_op_c_i,
    input logic        is_clpx_i,
    input logic [ 1:0] clpx_shift_i,
    input logic        clpx_img_i,

    output logic [31:0] result_o,
    output logic multicycle_o,
    output logic mulh_active_o,
    output logic ready_o,

    input  logic ex_ready_i
);


  logic [31:0] s_result_1, s_result_2, s_result_3;
  logic s_multicycle_1, s_multicycle_2, s_multicycle_3;
  logic s_mulh_active_1, s_mulh_active_2, s_mulh_active_3;
  logic s_ready_1, s_ready_2, s_ready_3;
  logic result_fault, multicycle_fault, mulh_fault, ready_fault, fault;

  cv32e40p_mult mult3 (
      .clk(clk),
      .rst_n(rst_n),
      .enable_i(enable_i),
      .operator_i(operator_i),
      .short_subword_i(short_subword_i),
      .op_a_i(op_a_i),
      .op_b_i(op_b_i),
      .op_c_i(op_c_i),    
      .imm_i(imm_i),
      .dot_signed_i(dot_signed_i),
      .dot_op_a_i(dot_op_a_i),
      .dot_op_b_i(dot_op_b_i),
      .dot_op_c_i(dot_op_c_i),
      .is_clpx_i(is_clpx_i),
      .clpx_shift_i(clpx_shift_i),
      .clpx_img_i(clpx_img_i),

      //outputs x3
      .result_1(s_result_1),
      .multicycle_1(s_multicycle_1),
      .mulh_active_1(s_mulh_active_1),
      .ready_1(s_ready_1),

      .result_2(s_result_2),
      .multicycle_2(s_multicycle_2),
      .mulh_active_2(s_mulh_active_2),
      .ready_2(s_ready_2),

      .result_3(s_result_3),
      .multicycle_3(s_multicycle_3),
      .mulh_active_3(s_mulh_active_3),
      .ready_3(s_ready_3),

      .ex_ready_i(ex_ready_i)
  );

  voter #(32) voter_result (
    .in1(s_result_1),
    .in2(s_result_2),
    .in3(s_result_3),
    .vote(result_o),
    .detected(result_fault)
  );

  voter #(1) voter_mcycle (
    .in1(s_multicycle_1),
    .in2(s_multicycle_2),
    .in3(s_multicycle_3),
    .vote(multicycle_o),
    .detected(multicycle_fault)
  );

  voter #(1) voter_mulh (
    .in1(s_mulh_active_1),
    .in2(s_mulh_active_2),
    .in3(s_mulh_active_3),
    .vote(mulh_active_o),
    .detected(mulh_fault)
  );

  voter #(1) voter_ready (
    .in1(s_ready_1),
    .in2(s_ready_2),
    .in3(s_ready_3),
    .vote(ready_o),
    .detected(ready_fault)
  );

  assign fault = result_fault | multicycle_fault | mulh_fault | ready_fault; // fault signal is internally raised if a fault is detected, the management of this bit should be considered

endmodule