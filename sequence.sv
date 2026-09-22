 // Explore VLSI Youtube Channel //


`include "uvm_macros.svh"

class fifo_seq_item extends uvm_sequence_item;
    `uvm_object_utils(fifo_seq_item)

  //data and control signals in trasaction packet
  // Data members (fields) that make up the transaction
  rand bit [7:0]data_in;
  rand bit rd;
  rand bit wr;
  
//   Output of the DUT, just part of transaction
  bit full;
  bit empty;
  bit [7:0]data_out;
  
  //Constructor
  function new(string name="fifo_seq_item");
    super.new(name);
  endfunction
  
endclass
