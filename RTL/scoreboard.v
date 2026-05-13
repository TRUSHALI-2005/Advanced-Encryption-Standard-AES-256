class Scoreboard;
  mailbox #(Transaction) mon2sco;

  function new(mailbox #(Transaction) mon2sco);
    this.mon2sco = mon2sco;
  endfunction : new

  task main();
    Transaction trans;
    forever
    begin
      mon2sco.get(trans);
      if(trans.ciphertext == test_vector(trans.plaintext, trans.key))
      begin
        $display("#############PASS#############");
        trans.display("SCO");
      end
      else
      begin
        $display("#############FAIL#############");
        trans.display("SCO");
        $display("---------------------------");
        $display("[%s | %0t] : VALID: %0b PT: %32h KEY: %64h DONE: %0b CT: %32h","REF",$time,trans.valid_in,trans.plaintext,trans.key,trans.done,test_vector(trans.plaintext, trans.key));
      end
    end
  endtask : main

  function bit [127:0] test_vector ( bit [127:0] plaintext, bit [255:0] key );
    case({plaintext,key})
      {128'h0,256'h0}: test_vector = 128'hdc95c078a2408989ad48a21492842087;
      {128'h00112233445566778899aabbccddeeff,256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f}: test_vector = 128'h8ea2b7ca516745bfeafc49904b496089;
      default : test_vector = 128'h0;
    endcase
  endfunction : test_vector
endclass : Scoreboard
