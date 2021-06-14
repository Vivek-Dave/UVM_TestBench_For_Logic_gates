
/***************************************************
** class name  : gates_sequence
** description : generate random sequence 
***************************************************/
class gates_sequence extends uvm_sequence#(gates_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(gates_sequence)            
  //----------------------------------------------------------------------------

  gates_sequence_item txn;
  int unsigned LOOP = 100;

  //----------------------------------------------------------------------------
  function new(string name="gates_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    repeat(LOOP) begin
      txn=gates_sequence_item::type_id::create("txn");
      start_item(txn);
      txn.randomize()with{txn.a != txn.b;};
      finish_item(txn);
    end
  endtask:body
  //----------------------------------------------------------------------------
endclass:gates_sequence