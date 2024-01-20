module cv32e40p_compressed_decoder3 #(
    parameter FPU   = 0,
    parameter ZFINX = 0
) (
    input  logic [31:0] instr_i,

    output logic [31:0] instr_o_1,
    output logic        is_compressed_1,
    output logic        illegal_instr_o_1,

    output logic [31:0] instr_o_2,
    output logic        is_compressed_o_2,
    output logic        illegal_instr_o_2,

    output logic [31:0] instr_o_3,
    output logic        is_compressed_o_3,
    output logic        illegal_instr_o_3
);

import cv32e40p_pkg::*;

cv32e40p_compressed_decoder #(.FPU(FPU), .ZFINX(ZFINX)) compressed_decoder_1 
(
    .instr_i(instr_i),
    .instr_o(instr_o_1),
    .is_compressed_o(is_compressed_1),
    .illegal_instr_o(illegal_instr_o_1)
);

cv32e40p_compressed_decoder #(.FPU(FPU), .ZFINX(ZFINX)) compressed_decoder_2 (
    .instr_i(instr_i),
    .instr_o(instr_o_2),
    .is_compressed_o(is_compressed_o_2),
    .illegal_instr_o(illegal_instr_o_2)
);

cv32e40p_compressed_decoder #(.FPU(FPU), .ZFINX(ZFINX)) compressed_decoder_3 
(
    .instr_i(instr_i),
    .instr_o(instr_o_3),
    .is_compressed_o(is_compressed_o_3),
    .illegal_instr_o(illegal_instr_o_3)
);

endmodule