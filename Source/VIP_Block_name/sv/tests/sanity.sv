class Sanity extends Test;

  function new(virtual inf inff);
    super.new(inff);
  endfunction : new

  task main();
    Transaction trans;
    reset();
    env.run();
    trans = new();
    trans.key = 256'h00010203_04050607_08090a0b_0c0d0e0f_10111213_14151617_18191a1b_1c1d1e1f;
    trans.plaintext = 128'h00112233_44556677_8899aabb_ccddeeff;
    trans.valid_in = 1'b1;
    send_data_gen(trans);
    @(posedge vif.clk)
    trans.valid_in = 1'b0;
    send_data_gen(trans);
    count++;
  endtask: main
endclass : Sanity
