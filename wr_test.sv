 // Explore VLSI Youtube Channel //


//-------------------------------------------------------------------------
//...W R I T E    T E S T ...\\ 
//write into fifo    
class fifo_wr_test extends fifo_test;
  `uvm_component_utils(fifo_wr_test)
  
  // sequence instance 
  fifo_write_sequence seq;//...W R I T E   S E Q U E N C E...\\
  
  // constructor
  function new(string name = "fifo_wr_test",uvm_component parent=null);
    super.new(name,parent);
        
    seq = fifo_write_sequence::type_id::create("seq");

  endfunction : new
 
  // run_phase - starting the test
  task run_phase(uvm_phase phase);
       
    phase.raise_objection(this);
    seq.start(env.agt.seqr);
    phase.drop_objection(this);

    //set a drain-time for the environment if desired
    phase.phase_done.set_drain_time(this, 30);
  endtask : run_phase
  
endclass : fifo_wr_test
