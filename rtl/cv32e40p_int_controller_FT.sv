module cv32e40p_int_controller_FT
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
    output logic       irq_req_ctrl_o,
    output logic       irq_sec_ctrl_o,
    output logic [4:0] irq_id_ctrl_o,
    output logic       irq_wu_ctrl_o,

    // To/from cv32e40p_cs_registers
    input  logic     [31:0] mie_bypass_i,  // MIE CSR (bypass)
    output logic     [31:0] mip_o,  // MIP CSR
    input  logic            m_ie_i,  // Interrupt enable bit from CSR (M mode)
    input  logic            u_ie_i,  // Interrupt enable bit from CSR (U mode)
    input  PrivLvl_t        current_priv_lvl_i
);

logic        s_irq_req_ctrl_o_1, s_irq_req_ctrl_o_2, s_irq_req_ctrl_o_3; 
logic        s_irq_sec_ctrl_o_1, s_irq_sec_ctrl_o_2, s_irq_sec_ctrl_o_3;
logic [4:0]  s_irq_id_ctrl_o_1, s_irq_id_ctrl_o_2, s_irq_id_ctrl_o_3;
logic        s_irq_wu_ctrl_o_1, s_irq_wu_ctrl_o_2, s_irq_wu_ctrl_o_3;
logic [31:0] s_mip_o_1, s_mip_o_2, s_mip_o_3;
logic        irq_req_ctrl_fault, irq_sec_ctrl_fault, irq_id_ctrl_fault, irq_wu_ctrl_fault, mip_fault, fault; 

cv32e40p_int_controller3 #(.PULP_SECURE(PULP_SECURE)) int_controller3 
(
    .clk(clk),
    .rst_n(rst_n),

    .irq_i(irq_i),
    .irq_sec_i(irq_sec_i),

    .irq_req_ctrl_o_1(s_irq_req_ctrl_o_1),
    .irq_sec_ctrl_o_1(s_irq_sec_ctrl_o_2),
    .irq_id_ctrl_o_1(s_irq_id_ctrl_o_1),
    .irq_wu_ctrl_o_1(s_irq_wu_ctrl_o_1),

    .irq_req_ctrl_o_2(s_irq_req_ctrl_o_2),
    .irq_sec_ctrl_o_2(s_irq_sec_ctrl_o_2),
    .irq_id_ctrl_o_2(s_irq_id_ctrl_o_2),
    .irq_wu_ctrl_o_2(s_irq_wu_ctrl_o_2),

    .irq_req_ctrl_o_3(s_irq_req_ctrl_o_3),
    .irq_sec_ctrl_o_3(s_irq_sec_ctrl_o_3),
    .irq_id_ctrl_o_3(s_irq_id_ctrl_o_3),
    .irq_wu_ctrl_o_3(s_irq_wu_ctrl_o_3),

    .mie_bypass_i(mie_bypass_i), 
    
    .mip_o_1(s_mip_o_1),
    .mip_o_2(s_mip_o_2),
    .mip_o_3(s_mip_o_3), 

    .m_ie_i(m_ie_i),
    .u_ie_i(u_ie_i),
    .current_priv_lvl_i(current_priv_lvl_i)
);

voter #(1) voter_irq_req_ctrl (
    .in1(s_irq_req_ctrl_o_1),
    .in2(s_irq_req_ctrl_o_2),
    .in3(s_irq_req_ctrl_o_3),
    .vote(irq_req_ctrl_o),
    .detected(irq_req_ctrl_fault)
);

voter #(1) voter_irq_sec_ctrl (
    .in1(s_irq_sec_ctrl_o_1),
    .in2(s_irq_sec_ctrl_o_2),
    .in3(s_irq_sec_ctrl_o_3),
    .vote(irq_sec_ctrl_o),
    .detected(irq_sec_ctrl_fault)
);

voter #(32) voter_irq_id_ctrl (
    .in1(s_irq_id_ctrl_o_1),
    .in2(s_irq_id_ctrl_o_2),
    .in3(s_irq_id_ctrl_o_3),
    .vote(irq_id_ctrl_o),
    .detected(irq_id_ctrl_fault)
);

voter #(1) voter_irq_wu_ctrl (
    .in1(s_irq_wu_ctrl_o_1),
    .in2(s_irq_wu_ctrl_o_2),
    .in3(s_irq_wu_ctrl_o_3),
    .vote(irq_wu_ctrl_o),
    .detected( )
);

voter #(32) voter_mip (
    .in1(s_mip_o_1),
    .in2(s_mip_o_2),
    .in3(s_mip_o_3),
    .vote(mip_o),
    .detected(mip_fault)
);

assign fault = irq_req_ctrl_fault | irq_sec_ctrl_fault | irq_id_ctrl_fault | irq_wu_ctrl_fault | mip_fault;

endmodule