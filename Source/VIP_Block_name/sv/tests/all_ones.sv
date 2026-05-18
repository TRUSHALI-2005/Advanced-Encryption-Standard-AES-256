class All_ones extends Test;

  function new(virtual inf inff);
    super.new(inff);
  endfunction : new

  task main();
    Transaction trans;
    reset();
    env.run();
    trans = new();
    trans.key = 256'h1111111111111111111111111111111111111111111111111111111111111111;
    trans.plaintext = 128'h11111111111111111111111111111111;
    trans.valid_in = 1'b1;
    send_data_gen(trans);
    @(posedge vif.clk)
    trans.valid_in = 1'b0;
    send_data_gen(trans);
    count++;
  endtask: main

endclass : All_ones
