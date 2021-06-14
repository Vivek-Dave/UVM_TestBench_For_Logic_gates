class gates_sequencer extends uvm_sequencer#(gates_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(gates_sequencer)  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="gates_sequencer",uvm_component parent);  
    super.new(name,parent);
  endfunction
  //----------------------------------------------------------------------------
  
endclass:gates_sequencer

