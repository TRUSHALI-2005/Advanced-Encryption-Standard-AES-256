class All_zero extends Test;

  function new(virtual inf inff);
    super.new(inff);
  endfunction : new

  task main();
    Transaction trans;
    reset();
    env.run();
    trans = new();
    trans.key = 256'h0000000000000000000000000000000000000000000000000000000000000000;
    trans.plaintext = 128'h00000000000000000000000000000000;
    trans.valid_in = 1'b1;
    send_data_gen(trans);
    @(posedge vif.clk)
    trans.valid_in = 1'b0;
    send_data_gen(trans);
    count++;
  endtask: main

endclass : All_zero
