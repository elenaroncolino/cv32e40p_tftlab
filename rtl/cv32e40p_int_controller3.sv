module cv32e40p_int_controller3
  import cv32e40p_pkg::*;
#(
    parameter PULP_SECURE = 0
) (
    input logic clk,
    input logic rst_n,

    // External interrupt lines
    input logic [31:0] irq_i,  // Level-triggered interrupt inputs
    input logic        irq_sec_i,  // Interrupt secure bit from EU

    // To cv32e40p_controller
    output logic       irq_req_ctrl_o_1,
    output logic       irq_sec_ctrl_o_1,
    output logic [4:0] irq_id_ctrl_o_1,
    output logic       irq_wu_ctrl_o_1,

    output logic       irq_req_ctrl_o_2,
    output logic       irq_sec_ctrl_o_2,
    output logic [4:0] irq_id_ctrl_o_2,
    output logic       irq_wu_ctrl_o_2,

    output logic       irq_req_ctrl_o_3,
    output logic       irq_sec_ctrl_o_3,
    output logic [4:0] irq_id_ctrl_o_3,
    output logic       irq_wu_ctrl_o_3,

    // To/from cv32e40p_cs_registers
    input  logic     [31:0] mie_bypass_i,  // MIE CSR (bypass)

    output logic     [31:0] mip_o_1,  // MIP CSR
    output logic     [31:0] mip_o_2,  // MIP CSR
    output logic     [31:0] mip_o_3,  // MIP CSR

    input  logic            m_ie_i,  // Interrupt enable bit from CSR (M mode)
    input  logic            u_ie_i,  // Interrupt enable bit from CSR (U mode)
    input  PrivLvl_t        current_priv_lvl_i
);

cv32e40p_int_controller #(.PULP_SECURE(PULP_SECURE)) int_controller_1 
(
    .clk(clk),
    .rst_n(rst_n),
    .irq_i(irq_i),
    .irq_sec_i(irq_sec_i),

    .irq_req_ctrl_o(irq_req_ctrl_o_1),
    .irq_sec_ctrl_o(irq_sec_ctrl_o_1),
    .irq_id_ctrl_o(irq_id_ctrl_o_1),
    .irq_wu_ctrl_o(irq_wu_ctrl_o_1),

    .mie_bypass_i(mie_bypass_i),
    .mip_o(mip_o_1),
    .m_ie_i(m_ie_i),
    .u_ie_i(u_ie_i),
    .current_priv_lvl_i(current_priv_lvl_i)
);

cv32e40p_int_controller #(.PULP_SECURE(PULP_SECURE)) int_controller_2 
(
    .clk(clk),
    .rst_n(rst_n),
    .irq_i(irq_i),
    .irq_sec_i(irq_sec_i),

    .irq_req_ctrl_o(irq_req_ctrl_o_2),
    .irq_sec_ctrl_o(irq_sec_ctrl_o_2),
    .irq_id_ctrl_o(irq_id_ctrl_o_2),
    .irq_wu_ctrl_o(irq_wu_ctrl_o_2),

    .mie_bypass_i(mie_bypass_i),
    .mip_o(mip_o_2),
    .m_ie_i(m_ie_i),
    .u_ie_i(u_ie_i),
    .current_priv_lvl_i(current_priv_lvl_i)
);

cv32e40p_int_controller #(.PULP_SECURE(PULP_SECURE)) int_controller_3 
(
    .clk(clk),
    .rst_n(rst_n),
    .irq_i(irq_i),
    .irq_sec_i(irq_sec_i),

    .irq_req_ctrl_o(irq_req_ctrl_o_3),
    .irq_sec_ctrl_o(irq_sec_ctrl_o_3),
    .irq_id_ctrl_o(irq_id_ctrl_o_3),
    .irq_wu_ctrl_o(irq_wu_ctrl_o_3),

    .mie_bypass_i(mie_bypass_i),
    .mip_o(mip_o_3),
    .m_ie_i(m_ie_i),
    .u_ie_i(u_ie_i),
    .current_priv_lvl_i(current_priv_lvl_i)
);

endmodule