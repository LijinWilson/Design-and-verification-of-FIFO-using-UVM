 // Explore VLSI Youtube Channel //


//-------------------------------------------------------------------------
//write read back to back test 
//fifo_sequence : random stimulus
//fifo_write_sequence : write stimulus
//-------------------------------------------------------------------------

class fifo_test extends uvm_test;
  
  fifo_environment env;
  
  virtual fifo_interface vif;
  
  `uvm_component_utils(fifo_test)
  
  //Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env=fifo_environment::type_id::create("env", this);
    uvm_config_db#(virtual fifo_interface)::set(this, "env", "vif", vif);
    
    if(! uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif)) 
      begin
        `uvm_error("build_phase","Test virtual interface failed")
      end
  endfunction
  
  // end_of_elobaration phase
  virtual function void end_of_elaboration();
    //print's the topology
    print();
  endfunction
  
  //Run phase
  task run_phase(uvm_phase phase);
    fifo_sequence fifo_seq;
    fifo_seq = fifo_sequence::type_id::create("fifo_seq");
    
    //fifo_write_sequence fifo_seq;
    //fifo_seq = fifo_write_sequence::type_id::create("fifo_seq");

    phase.raise_objection( this, "Starting  main phase" );
    $display("%t Starting sequence fifo_seq run_phase",$time);
    fifo_seq.start(env.agt.seqr);
    phase.drop_objection( this , "Finished fifo_seq in main phase" );
  endtask
  
endclass
