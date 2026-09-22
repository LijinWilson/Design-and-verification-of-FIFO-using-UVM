 // Explore VLSI Youtube Channel //


//FIFO Scoreboard

class fifo_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(fifo_scoreboard)

  //Analysis import declaration
  uvm_analysis_imp#(fifo_seq_item, fifo_scoreboard) scb_port;
  //uvm_analysis_imp is the component that receives and processes the transactions.
  fifo_seq_item que[$];
  
  fifo_seq_item trans;

  
  bit [7:0]mem[$];
  bit [7:0] tx_data;
  bit  read_delay_clk;

  //Constructor
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_port = new("scb_port", this);
  endfunction
  
  //Write function implemetation
  function void write(fifo_seq_item transaction);
   que.push_back(transaction);
 endfunction 
  
 virtual task run_phase(uvm_phase phase);
    forever begin
    
    wait(que.size()>0);
    trans=que.pop_front();

    //WRITE
    if(trans.wr==1) begin
    mem.push_back(trans.data_in);
    end
          
    //READ
    if(trans.rd==1 || (read_delay_clk != 0)) 
      	begin //if block starts here
          //$display($time, "\t display 1 trans.rd = %d, read_delay_clk=%d", trans.rd, read_delay_clk);
          
      	if(read_delay_clk==0) read_delay_clk = 1;
         	 
          			else begin //else
            		if(trans.rd==0) read_delay_clk = 0;
                      //$display($time, "\t display 2 trans.rd = %d, read_delay_clk=%d", trans.rd, read_delay_clk);

            		if(mem.size>0) 
                		begin
                  		tx_data = mem.pop_front();
                  		if(trans.data_out==tx_data) 
                    	begin
                          `uvm_info("SCOREBOARD",$sformatf("------ :: EXPECTED MATCH  :: ------"),UVM_MEDIUM)
                     	`uvm_info("SCOREBOARD",$sformatf("Exp Data: %0d, Rec data=%0d",tx_data,trans.data_out),UVM_MEDIUM)
                     	`uvm_info("SCOREBOARD",$sformatf("-------------------------------------------------------"),UVM_MEDIUM)
                    	end
                  		else 
                    	begin
                          `uvm_info("SCOREBOARD",$sformatf("------ ::  FAILED MATCH  :: ------"),UVM_MEDIUM)
                      	`uvm_info("SCOREBOARD",$sformatf("Exp Data: %0d, Rec data=%0d",tx_data,trans.data_out),UVM_MEDIUM)
                      	`uvm_info("SCOREBOARD",$sformatf("-------------------------------------------------------"),UVM_MEDIUM)
                    	end
                		end
            		end //else
        end //if block ends here
          
      else
      read_delay_clk = 0;
 
    end
  endtask 
                  
  
endclass
        
