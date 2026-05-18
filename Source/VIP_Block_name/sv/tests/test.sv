class Test;
  Enviornment env;
  virtual inf vif;
  int count;

  function new(virtual inf vif);
    this.vif = vif;
    env = new(vif);
  endfunction : new

  task send_data_gen(Transaction trans);
    env.send_data_gen(trans);
  endtask : send_data_gen

  task reset();
    $display("RESET CALLED %0t",$time);
    vif.rst = 1'b0;
    @(posedge vif.clk);
    @(posedge vif.clk);
    vif.rst = 1'b1;
    @(posedge vif.clk);
    $display("RESET END %0t",$time);
  endtask : reset

  virtual task main();
  endtask

endclass : Test
