// ZOIX MODULE FOR FAULT INJECTION AND STROBING

`timescale 1ps / 1ps

`ifndef TOPLEVEL
	`define TOPLEVEL cv32e40p_top
`endif

module strobe;


// Inject faults
initial begin

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

        //OUTPUTS

                #$fs_strobe(`TOPLEVEL.instr_req_o);
                #$fs_strobe(`TOPLEVEL.data_req_o);
                #$fs_strobe(`TOPLEVEL.data_we_o);
                #$fs_strobe(`TOPLEVEL.instr_addr_o);
                #$fs_strobe(`TOPLEVEL.data_addr_o);
                #$fs_strobe(`TOPLEVEL.data_wdata_o);
                #$fs_strobe(`TOPLEVEL.data_be_o);
                

                #Second_step

                #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_alu_FT.result_o);
                  #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_alu_FT.comparison_result_o);
                   #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_alu_FT.ready_o);

                
                #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_mult_FT.result_o);
                  #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_mult_FT.multicycle_o);
                    #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_mult_FT.mulh_active_o);
                      #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_mult_FT.ready_o);

                #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_id_stage.cv32e40p_int_controller_FT.irq_req_ctrl_o);
                  #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_id_stage.cv32e40p_int_controller_FT.irq_sec_ctrl_o);
                    #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_id_stage.cv32e40p_int_controller_FT.irq_id_ctrl_o);
                      #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_id_stage.cv32e40p_int_controller_FT.irq_wu_ctrl_o);
                        #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_id_stage.cv32e40p_int_controller_FT.mie_bypass_i);
                          #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_id_stage.cv32e40p_int_controller_FT.mip_o);

                #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_if_stage.cv32e40p_compressed_decoder_FT.instr_o);
                  #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_if_stage.cv32e40p_compressed_decoder_FT.is_compressed_o);
                    #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_if_stage.cv32e40p_compressed_decoder_FT.illegal_instr_o);

                #Third_step

                $fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_alu_FT.alu_fault);
                #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_ex_stage.cv32e40p_mult_FT.fault);
                #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_id_stage.cv32e40p_int_controller_FT.fault);
                #$fs_strobe(`TOPLEVEL.cv32e40p_core.cv32e40p_if_stage.cv32e40p_compressed_decoder_FT.fault);



                #10000; // TMAX Strobe period
        end

end



endmodule
