module cv32e40p_compressed_decoder_FT #(
    parameter FPU   = 0,
    parameter ZFINX = 0
) (
    input  logic [31:0] instr_i,
    output logic [31:0] instr_o,
    output logic        is_compressed_o,
    output logic        illegal_instr_o
);

import cv32e40p_pkg::*;


logic [31:0] s_instr_o_1, s_instr_o_2, s_instr_o_3;
logic        s_is_compressed_o_1, s_is_compressed_o_2, s_is_compressed_o_3;
logic        s_illegal_instr_o_1, s_illegal_instr_o_2, s_illegal_instr_o_3;
logic        instr_fault, is_compressed_fault, illegal_instr_fault, fault;

cv32e40p_compressed_decoder3 #(.FPU(FPU), .ZFINX(ZFINX)) compressed_decoder3 
(
    .instr_i(instr_i),

    .instr_o_1(s_instr_o_1),
    .is_compressed_1(s_is_compressed_o_1),
    .illegal_instr_o_1(s_illegal_instr_o_1),

    .instr_o_2(s_instr_o_2),
    .is_compressed_o_2(s_is_compressed_o_2),
    .illegal_instr_o_2(s_illegal_instr_o_2),

    .instr_o_3(s_instr_o_3),
    .is_compressed_o_3(s_is_compressed_o_3),
    .illegal_instr_o_3(s_illegal_instr_o_2)
);

voter #(32) voter_instr (
    .in1(s_instr_o_1),
    .in2(s_instr_o_2),
    .in3(s_instr_o_3),
    .vote(instr_o),
    .detected(instr_fault)
);

voter #(1) voter_is_compressed (
    .in1(s_is_compressed_o_1),
    .in2(s_is_compressed_o_2),
    .in3(s_is_compressed_o_3),
    .vote(is_compressed_o),
    .detected(is_compressed_fault)
);

voter #(1) voter_illegal_instr (
    .in1(s_illegal_instr_o_1),
    .in2(s_illegal_instr_o_2),
    .in3(s_illegal_instr_o_3),
    .vote(illegal_instr_o),
    .detected(illegal_instr_fault)
);

// fault signal is internally raised if a fault is detected, the management of this bit should be considered
assign fault = instr_fault | is_compressed_fault | illegal_instr_fault;


endmodule