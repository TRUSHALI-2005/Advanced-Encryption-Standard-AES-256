class Driver;
  mailbox #(Transaction) gen2drv;
  virtual inf.DRV vif;

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
      if(vif.cb_dri.rst)
      begin
        gen2drv.get(trans);
        vif.cb_dri.plaintext <= trans.plaintext;
        vif.cb_dri.key <= trans.key;
        vif.cb_dri.valid_in <= trans.valid_in;
      end
      else
      begin
        gen2drv.get(trans);
        vif.cb_dri.plaintext <= 0;
        vif.cb_dri.key <= 0;
        vif.cb_dri.valid_in <= 0;
      end
      trans.display("DRI");
    end
  endtask : main

endclass : Driver
