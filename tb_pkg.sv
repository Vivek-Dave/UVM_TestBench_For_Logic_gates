
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "gates_sequence_item.sv"        // transaction class
 `include "gates_sequence.sv"             // sequence class
 `include "gates_sequencer.sv"            // sequencer class
 `include "gates_driver.sv"               // driver class
 `include "gates_monitor.sv"              // monitor class
 `include "gates_agent.sv"                // agent class  
 `include "gates_coverage.sv"             // coverage class
 `include "gates_scoreboard.sv"           // scoreboard class
 `include "gates_env.sv"                  // environment class

 `include "gates_test.sv"                 // test1

endpackage
`endif 


