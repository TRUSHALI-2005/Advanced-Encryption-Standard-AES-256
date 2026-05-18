class Monitor;
  mailbox #(Transaction) mon2sco;
  virtual inf.MON vif;

  function new(mailbox #(Transaction) mon2sco, virtual inf.MON vif);
    this.mon2sco = mon2sco;
    this.vif = vif;
  endfunction : new

  task main();
    Transaction trans;
    forever
    begin
      @(vif.cb_mon);
      wait(vif.cb_mon.done);
      trans = new();
      trans.plaintext = vif.cb_mon.plaintext;
      trans.key = vif.cb_mon.key;
      trans.valid_in = vif.cb_mon.valid_in;
      trans.done = vif.cb_mon.done;
      trans.ciphertext = vif.cb_mon.ciphertext;
      mon2sco.put(trans);
      trans.display("MON");
    end
  endtask : main
endclass : Monitor
