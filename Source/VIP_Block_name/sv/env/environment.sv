class Enviornment;

  Generator gen;
  Driver dri;
  Monitor mon;
  Scoreboard sco;
  mailbox #(Transaction) mon2sco, gen2drv;

  function new(virtual inf vif);
    gen2drv = new();
    mon2sco = new();

    gen = new(gen2drv);
    dri = new(gen2drv,vif);
    mon = new(mon2sco,vif);
    sco = new(mon2sco);
    
  endfunction : new

  task run();
    fork
      dri.main();
      mon.main();
      sco.main();
    join_none
  endtask : run
  
  task send_data_gen(Transaction trans);
    gen.send(trans);
  endtask : send_data_gen

endclass : Enviornment
