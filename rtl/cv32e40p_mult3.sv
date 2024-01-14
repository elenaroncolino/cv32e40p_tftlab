module cv32e40p_mult3
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

    output logic [31:0] result_1,
    output logic multicycle_1,
    output logic mulh_active_1,
    output logic ready_1,

    output logic [31:0] result_2,
    output logic multicycle_2,
    output logic mulh_active_2,
    output logic ready_2,

    output logic [31:0] result_3,
    output logic multicycle_3,
    output logic mulh_active_3,
    output logic ready_3,


    input  logic ex_ready_i
);

cv32e40p_mult mult_1
(
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
    .result_o(result_1),
    .multicycle_o(multicycle_1),
    .mulh_active_o1(mulh_active_1),
    .ready_o(ready_1),
    .ex_ready_i(ex_ready_i)
);


cv32e40p_mult mult_2
(
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
    .result_o(result_2),
    .multicycle_o(multicycle_2),
    .mulh_active_o1(mulh_active_2),
    .ready_o(ready_2),
    .ex_ready_i(ex_ready_i)
);

cv32e40p_mult mult_3
(
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
    .result_o(result_3),
    .multicycle_o(multicycle_3),
    .mulh_active_o1(mulh_active_3),
    .ready_o(ready_3),
    .ex_ready_i(ex_ready_i)
);



endmodule