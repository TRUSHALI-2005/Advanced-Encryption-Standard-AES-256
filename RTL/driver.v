class Driver;
  mailbox #(Transaction) gen2drv;
  virtual inf.DRV vif;
  event next;

  function new(mailbox #(Transaction) gen2drv, virtual inf.DRV vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction : new

  task main();
    Transaction trans;
    forever
    begin
      trans = new();
      @(vif.cb_dri);
      gen2drv.get(trans);
      vif.cb_dri.plaintext <= trans.plaintext;
      vif.cb_dri.key <= trans.key;
      vif.cb_dri.valid_in <= trans.valid_in;
      trans.display("DRI");
      -> next;
    end
  endtask : main

endclass : Driver
