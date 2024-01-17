module cv32e40p_alu_FT
  import cv32e40p_pkg::*;
(
     input logic               clk,
    input logic               rst_n,
    input logic               enable_i,
    input alu_opcode_e        operator_i,
    input logic        [31:0] operand_a_i,
    input logic        [31:0] operand_b_i,
    input logic        [31:0] operand_c_i,

    input logic [1:0] vector_mode_i,
    input logic [4:0] bmask_a_i,
    input logic [4:0] bmask_b_i,
    input logic [1:0] imm_vec_ext_i,

    input logic       is_clpx_i,
    input logic       is_subrot_i,
    input logic [1:0] clpx_shift_i,

    output logic [31:0] result_o,
    output logic        comparison_result_o,
    output logic ready_o,

    input  logic ex_ready_i
);


  logic [31:0] s_result_1, s_result_2, s_result_3;
  logic s_comparison_result_1, s_comparison_result_2, s_comparison_result_3;
  logic s_ready_1, s_ready_2, s_ready_3;
  logic res_fault, comp_fault, aready_fault, alu_fault;

  cv32e40p_alu3 alu3 (
.clk(clk),
    .rst_n(rst_n),
    .enable_i(enable_i),
    .operator_i(operator_i),
    .operand_a_i(operand_a_i),
    .operand_b_i(operand_b_i),
    .operand_c_i(operand_c_i),

    .vector_mode_i(vector_mode_i),
    .bmask_a_i(bmask_a_i),
    .bmask_b_i(bmask_b_i),
    .imm_vec_ext_i(imm_vec_ext_i),
    .is_clpx_i(is_clpx_i),
    .is_subrot_i(is_subrot_i),
    .clpx_shift_i(clpx_shift_i),
    
    .result_1(s_result_1),
    .comparison_result_1(s_comparison_result_1),
    .ready_1(s_ready_1),

    .result_2(s_result_2),
    .comparison_result_2(s_comparison_result_2),
    .ready_2(s_ready_2),

    .result_3(s_result_3),
    .comparison_result_3(s_comparison_result_3),
    .ready_3(s_ready_3),

    .ex_ready_i(ex_ready_i)
  );
  voter #(32) voter_result (
    .in1(s_result_1),
    .in2(s_result_2),
    .in3(s_result_3),
    .vote(result_o),
    .detected(res_fault)
  );

  voter #(1) voter_comp (
    .in1(s_comparison_result_1),
    .in2(s_comparison_result_2),
    .in3(s_comparison_result_3),
    .vote(comparison_result_o),
    .detected(comp_fault)
  );

  voter #(1) voter_aready (
    .in1(s_ready_1),
    .in2(s_ready_2),
    .in3(s_ready_3),
    .vote(ready_o),
    .detected(aready_fault)
  );

  assign alu_fault = res_fault | comp_fault | aready_fault ; // fault signal is internally raised if a fault is detected, the management of this bit should be considered

endmodule