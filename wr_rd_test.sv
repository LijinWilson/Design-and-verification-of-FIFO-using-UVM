 // Explore VLSI Youtube Channel //


//	//...W R I T E    R E A D  BACK-TO-BACK  T E S T ...\\ 
// write read back to back test
// fifo_write_read_sequence : write and immediately read next
//-------------------------------------------------------------------------

class fifo_wr_rd_test extends fifo_test;

  `uvm_component_utils(fifo_wr_rd_test)
  
  // sequence instance 
  fifo_write_read_sequence seq;

  // constructor
  function new(string name = "fifo_wr_rd_test",uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  // build_phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Create the sequence
    seq = fifo_write_read_sequence::type_id::create("seq");
  endfunction : build_phase
  
  // run_phase - starting the test
  task run_phase(uvm_phase phase);
          $display("Starting UVM Test Run phase...");  

    phase.raise_objection(this);
    seq.start(env.agt.seqr);
    phase.drop_objection(this);
    
    //set a drain-time for the environment if desired
    phase.phase_done.set_drain_time(this, 50);
  endtask : run_phase
  
endclass : fifo_wr_rd_test
