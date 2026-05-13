class Test;
  Enviornment env;
  virtual inf vif;

  function new(virtual inf vif);
    this.vif = vif;
    env = new(vif);
  endfunction : new

  task run();
    env.run(2);
    #2000;
    $finish;
  endtask : run

endclass : Test
