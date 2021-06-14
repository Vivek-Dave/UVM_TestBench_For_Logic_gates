
`include "interface.sv"
`include "tb_pkg.sv"
module top;
  import uvm_pkg::*;
  import tb_pkg::*;
  
  bit clk;
  
  //----------------------------------------------------------------------------
  intf i_intf(clk);
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  all_gates DUT(.a     (i_intf.a),
                .b     (i_intf.b),
                .andd  (i_intf.andd),
                .orr   (i_intf.orr),
                .nandd (i_intf.nandd),
                .norr  (i_intf.norr),
                .nott_a(i_intf.nott_a),
                .nott_b(i_intf.nott_b),
                .xorr  (i_intf.xorr),
                .xnorr (i_intf.xnorr),
                .buff_a(i_intf.buff_a),
                .buff_b(i_intf.buff_b)
                );
  //----------------------------------------------------------------------------               

  initial clk = 0;
  
  always #5 clk = ~clk;
  
  //----------------------------------------------------------------------------
  initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    uvm_config_db#(virtual intf)::set(uvm_root::get(),"","vif",i_intf);
  end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  initial begin
    run_test("gates_test");
  end
  //----------------------------------------------------------------------------
endmodule

