class Generator;

  mailbox #(Transaction) gen2drv;

  function new(mailbox #(Transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction : new
  
  extern task send(Transaction trans);

endclass : Generator
    
task Generator::send(Transaction trans);
  gen2drv.put(trans);
  trans.display("GEN");
endtask : send

