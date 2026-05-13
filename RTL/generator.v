class Generator;

  mailbox #(Transaction) gen2drv;
  event dri_next,mon_next;

  function new(mailbox #(Transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction : new

  extern task main(bit [2:0] test = 0);
  extern task write(bit [127:0] pt = 0, bit [255:0] key = 0);

endclass : Generator

task Generator::main(bit [2:0] test);
  case(test)
    3'b000: write(128'h00112233445566778899aabbccddeeff,256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f); //Known test vector
    3'b001: write(128'h0,256'h0); //Null Value
    3'b010: write(100'h0,100'h0); //IP greater
    3'b011: write(); //IP less
    3'b100: write(); //IP other than known test vector
    default: write();
  endcase
endtask : main

task Generator::write(bit [127:0] pt, bit [255:0] key);
  Transaction trans;
  trans = new();
  trans.valid_in = 1;
  trans.plaintext = pt;
  trans.key = key;
  gen2drv.put(trans);
  trans.display("GEN");
  @(dri_next);
  trans.valid_in = 0;
  gen2drv.put(trans);
endtask : write
