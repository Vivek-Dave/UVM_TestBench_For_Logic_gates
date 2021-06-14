class gates_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration-----------------

  rand logic  a;  //i/p
  rand logic  b;

  
  logic andd;     //o/p
  logic orr;
  logic nott_a;
  logic nott_b;
  logic xorr;
  logic xnorr;
  logic buff_a;
  logic buff_b;
  logic nandd;
  logic norr;
  
  //---------------- register gates_sequence_item class with factory --------
  `uvm_object_utils_begin(gates_sequence_item) 
     `uvm_field_int( a      ,UVM_ALL_ON)
     `uvm_field_int( b      ,UVM_ALL_ON)
     `uvm_field_int( andd   ,UVM_ALL_ON)
     `uvm_field_int( orr    ,UVM_ALL_ON)
     `uvm_field_int( nott_a ,UVM_ALL_ON)
     `uvm_field_int( nott_b ,UVM_ALL_ON)
     `uvm_field_int( xorr   ,UVM_ALL_ON)
     `uvm_field_int( xnorr  ,UVM_ALL_ON)
     `uvm_field_int( buff_a ,UVM_ALL_ON)
     `uvm_field_int( buff_b ,UVM_ALL_ON)
     `uvm_field_int( nandd  ,UVM_ALL_ON)
     `uvm_field_int( norr   ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="gates_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf(" a=%0b  b=%0b",a,b));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf(" andd=%0b orr=%0b nott_a=%0b nott_b=%0b xorr=%0b xnorr=%0b buff_a=%0b buff_b=%0b nandd=%0b norr=%0b",andd,orr,nott_a,nott_b,xorr,xnorr,buff_a,buff_b,nandd,norr));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), " || ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:gates_sequence_item
