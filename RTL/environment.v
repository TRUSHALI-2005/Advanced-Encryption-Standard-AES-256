class Enviornment;

  Generator gen;
  Driver dri;
  Monitor mon;
  Scoreboard sco;
  event dri_next, mon_next;
  mailbox #(Transaction) mon2sco, gen2drv;

  function new(virtual inf vif);
    gen2drv = new();
    mon2sco = new();

    gen = new(gen2drv);
    dri = new(gen2drv,vif);
    mon = new(mon2sco,vif);
    sco = new(mon2sco);

    gen.dri_next = dri_next;
    dri.next = dri_next;
    //gen.mon_next = mon_next;
    //mon.next = mon_next;

  endfunction : new

  task run(int num = 1);
    fork
      gen.main(num);
      dri.main();
      mon.main();
      sco.main();
    join_any
  endtask : run

endclass : Enviornment
