// ZOIX MODULE FOR FAULT INJECTION AND STROBING

`timescale 1ps / 1ps

`ifndef TOPLEVEL
	`define TOPLEVEL cv32e40p_top
`endif

module strobe;


// Inject faults
initial begin

        // Used to force the fault on the voter during component's analysis

        //force `TOPLEVEL.core_i.ex_stage_i.alu_i.voter_result.U130.S = 0;
        //force `TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.voter_illegal_instr.U3.A = 0;

        $display("ZOIX INJECTION");
        //$fs_inject;       // by default

        $fs_delete;			// CHECK THIS
        $fs_add(`TOPLEVEL);		// CHECK THIS

end


// Strobe point
initial begin

        //#`START_TIME;
        #59990; //equivalent to strobe_offset tmax
        forever begin

        //////////////////////////////////////////////////////////////////////////////////////////////////
        //OUTPUTS -> Used in Golden and Hardenized

                $fs_strobe(`TOPLEVEL.instr_req_o);
                $fs_strobe(`TOPLEVEL.data_req_o);
                $fs_strobe(`TOPLEVEL.data_we_o);
                $fs_strobe(`TOPLEVEL.instr_addr_o);
                $fs_strobe(`TOPLEVEL.data_addr_o);
                $fs_strobe(`TOPLEVEL.data_wdata_o);
                $fs_strobe(`TOPLEVEL.data_be_o);
                
        //////////////////////////////////////////////////////////////////////////////////////////////////
        //Second_step -> Used in Golden and Hardenized

                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.alu_i.result_o);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.alu_i.comparison_result_o);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.alu_i.ready_o);

                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.result_o);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.multicycle_o);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.mulh_active_o);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.ready_o);

                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.irq_req_ctrl_o);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.irq_sec_ctrl_o);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.irq_id_ctrl_o);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.irq_wu_ctrl_o);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.mie_bypass_i);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.mip_o);

                //$fs_strobe(`TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.instr_o);
                //$fs_strobe(`TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.is_compressed_o);
                //$fs_strobe(`TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.illegal_instr_o);

        //////////////////////////////////////////////////////////////////////////////////////////////////
        //Third_step -> Used in Hardenized for voters analysis

                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.voter_result.detected);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.voter_mcycle.detected);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.voter_mulh.detected);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.mult_i.voter_ready.detected);

                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.alu_i.voter_result.detected);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.alu_i.voter_mcycle.detected);
                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.alu_i.voter_mulh.detected);

                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.voter_irq_req_ctrl.detected);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.voter_irq_sec_ctrl.detected);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.voter_irq_id_ctrl.detected);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.voter_irq_wu_ctrl.detected);
                //$fs_strobe(`TOPLEVEL.core_i.id_stage_i.int_controller_i.voter_mip.detected);

                //$fs_strobe(`TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.voter_instr.detected);
                //$fs_strobe(`TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.voter_is_compressed.detected);
                //$fs_strobe(`TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.voter_illegal_instr.detected);

                //$fs_strobe(`TOPLEVEL.core_i.ex_stage_i.alu_i.voter_result);
                //$fs_strobe(`TOPLEVEL.core_i.if_stage_i.compressed_decoder_i.voter_illegal_instr);

                #10000; // TMAX Strobe period
        end

end



endmodule
