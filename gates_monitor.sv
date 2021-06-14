
class gates_monitor extends uvm_monitor;
  //----------------------------------------------------------------------------
  `uvm_component_utils(gates_monitor)
  //----------------------------------------------------------------------------

  //------------------- constructor --------------------------------------------
  function new(string name="gates_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------- sequence_item class ---------------------------------------
  gates_sequence_item  txn;
  //----------------------------------------------------------------------------
  
  //------------------------ virtual interface handle---------------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------

  //------------------------ analysis port -------------------------------------
  uvm_analysis_port#(gates_sequence_item) ap_mon;
  //----------------------------------------------------------------------------
  
  //------------------- build phase --------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif)))
    begin
      `uvm_fatal("monitor","unable to get interface")
    end
    
    ap_mon=new("ap_mon",this);
    txn=gates_sequence_item::type_id::create("txn",this);
  endfunction
  //----------------------------------------------------------------------------

  //-------------------- run phase ---------------------------------------------
  task run_phase(uvm_phase phase);
    forever
    begin
      sample_dut(txn);
      ap_mon.write(txn);
    end
  endtask
  //----------------------------------------------------------------------------

  task sample_dut(output gates_sequence_item txn);
    gates_sequence_item t = gates_sequence_item::type_id::create("t");
    @(posedge vif.clk);
    #1;
    t.a      = vif.a;
    t.b      = vif.b;
    t.andd   = vif.andd;
    t.orr    = vif.orr;
    t.nott_a = vif.nott_a;
    t.nott_b = vif.nott_b;
    t.xorr   = vif.xorr;
    t.xnorr  = vif.xnorr;
    t.nandd  = vif.nandd;
    t.norr   = vif.norr;
    t.buff_b = vif.buff_b;
    t.buff_a = vif.buff_a;
    txn      = t;
  endtask

endclass:gates_monitor

