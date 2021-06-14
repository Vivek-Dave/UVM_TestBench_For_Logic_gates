
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class gates_scoreboard extends uvm_scoreboard;
  //----------------------------------------------------------------------------
  `uvm_component_utils(gates_scoreboard)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_analysis_imp_drv #(gates_sequence_item, gates_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(gates_sequence_item, gates_scoreboard) aport_mon;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  uvm_tlm_fifo #(gates_sequence_item) expfifo;
  uvm_tlm_fifo #(gates_sequence_item) outfifo;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  logic t_a;
  logic t_b;
  logic t_andd,temp_andd;
  logic t_orr,temp_orr;
  logic t_nott_a,temp_nott_a;
  logic t_nott_b,temp_nott_b;
  logic t_xorr,temp_xorr;
  logic t_xnorr,temp_xnorr;
  logic t_buff_a,temp_buff_a;
  logic t_buff_b,temp_buff_b;
  logic t_nandd,temp_nandd;
  logic t_norr;
  bit true,false;
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="gates_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    aport_drv = new("aport_drv", this);
    aport_mon = new("aport_mon", this);
    expfifo= new("expfifo",this);
    outfifo= new("outfifo",this);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_drv(gates_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    //write scoreboard code here
    t_a = tr.a;
    t_b = tr.b;

    //temp_andd   = t_andd;
    //temp_orr    = t_orr;
    //temp_nott_a = t_nott_a;
    //temp_nott_b = t_nott_b;
    //temp_xorr   = t_xorr;
    //temp_xnorr  = t_xnorr;
    //temp_buff_a = t_buff_a;
    //temp_buff_b = t_buff_b;
    //temp_nandd  =t_nandd;
    //temp_norr   =t_norr;
    
    t_andd   = t_a&t_b;
    t_orr    = t_a|t_b;
    t_nott_a = ~t_a;
    t_nott_b = ~t_b;
    t_xorr   = t_a^t_b;
    t_xnorr  = ~(t_a^t_b);
    t_nandd  = ~(t_a&t_b);
    t_norr   = ~(t_a|t_b);
    t_buff_a = t_a;
    t_buff_b = t_b;

    tr.andd   = t_andd;
    tr.orr    = t_orr;
    tr.nott_a = t_nott_a;
    tr.nott_b = t_nott_b;
    tr.xorr   = t_xorr;
    tr.xnorr  = t_xnorr;
    tr.nandd  = t_nandd;
    tr.norr   = t_norr;
    tr.buff_a = t_buff_a;
    tr.buff_b = t_buff_b;

    void'(expfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void write_mon(gates_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
	gates_sequence_item exp_tr, out_tr;
  static int unsigned count = 0;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        //true=1;   

      	if (out_tr.andd===exp_tr.andd && out_tr.orr===exp_tr.orr && out_tr.nott_a===exp_tr.nott_a &&
        out_tr.nott_b===exp_tr.nott_b && out_tr.buff_a===exp_tr.buff_a && out_tr.buff_b===exp_tr.buff_b &&
        out_tr.xorr===exp_tr.xorr && out_tr.xnorr===exp_tr.xnorr && out_tr.nandd===exp_tr.nandd &&
        out_tr.norr===exp_tr.norr && count>0) begin
            PASS();
           `uvm_info ("\n [ PASS ",out_tr.convert2string() , UVM_MEDIUM)
	      end
      
      else if (out_tr.andd!==exp_tr.andd && out_tr.orr!==exp_tr.orr && out_tr.nott_a!==exp_tr.nott_a &&
        out_tr.nott_b!==exp_tr.nott_b && out_tr.buff_a!==exp_tr.buff_a && out_tr.buff_b!==exp_tr.buff_b &&
        out_tr.xorr!==exp_tr.xorr && out_tr.xnorr!==exp_tr.xnorr && out_tr.nandd!==exp_tr.nandd &&
        out_tr.norr!==exp_tr.norr && count>0) begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
     // else $display("no match ??");
        count++;
    end
  endtask
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (VECT_CNT && !ERROR_CNT)
            `uvm_info("PASSED",$sformatf("*** TEST PASSED - %0d vectors ran, %0d vectors passed ***",
            VECT_CNT, PASS_CNT), UVM_LOW)

        else
            `uvm_info("FAILED",$sformatf("*** TEST FAILED - %0d vectors ran, %0d vectors passed, %0d vectors failed ***",
            VECT_CNT, PASS_CNT, ERROR_CNT), UVM_LOW)
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void PASS();
	  VECT_CNT++;
	  PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction
  //----------------------------------------------------------------------------

endclass

