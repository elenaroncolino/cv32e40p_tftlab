module cv32e40p_alu3
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

    output logic [31:0] result_1,
    output logic        comparison_result_1,
    output logic ready_1,

    output logic [31:0] result_2,
    output logic        comparison_result_2,
    output logic ready_2,

    output logic [31:0] result_3,
    output logic        comparison_result_3,
    output logic ready_3,

    input  logic ex_ready_i
);

cv32e40p_mult alu_1
(
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
    .result_o(result_1),
    .comparison_result_o(comparison_result_1),
    .ready_o(ready_1),
    .ex_ready_i(ex_ready_i)
   
);


cv32e40p_mult alu_2
(
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
    .result_o(result_2),
    .comparison_result_o(comparison_result_2),
    .ready_o(ready_2),
    .ex_ready_i(ex_ready_i)
);

cv32e40p_mult alu_3
(
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
    .result_o(result_3),
    .comparison_result_o(comparison_result_3),
    .ready_o(ready_3),
    .ex_ready_i(ex_ready_i)
   
);



endmodule