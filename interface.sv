 // Explore VLSI Youtube Channel //


//Fifo interface

interface fifo_interface(input logic clk,rst);

  logic [7:0]data_in;
  logic [7:0]data_out;
  logic empty;
  logic full;
  logic rd;
  logic wr;
  logic [3:0]fifo_cnt;
  
  clocking driver_cb @(posedge clk);
 // default input #1 output #1;
    output data_in;
    output rd,wr;
    input full,empty;
    input data_out;
    input fifo_cnt;
  endclocking
  
  clocking monitor_cb @(posedge clk);
   // default input #1 output #1;
    input data_in;
    input rd,wr;
    input full,empty;
    input data_out;
    input fifo_cnt;
  endclocking  
  
  modport DRIVER(clocking driver_cb,input clk,rst);
  modport MONITOR(clocking monitor_cb,input clk,rst);
  
endinterface
