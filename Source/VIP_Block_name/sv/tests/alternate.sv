class Alternate extends Test;

  function new(virtual inf inff);
    super.new(inff);
  endfunction : new

  task main();
    Transaction trans;
    reset();
    env.run();
    trans = new();
    trans.key = 256'h0101010101010101010101010101010101010101010101010101010101010101;
    trans.plaintext = 128'h01010101010101010101010101010101;
    trans.valid_in = 1'b1;
    send_data_gen(trans);
    @(posedge vif.clk)
    trans.valid_in = 1'b0;
    send_data_gen(trans);
    count++;
  endtask: main

endclass : Alternate
