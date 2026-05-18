class Scoreboard;
  mailbox #(Transaction) mon2sco;
  bit [127:0] exp_cp;
  int num;

  function new(mailbox #(Transaction) mon2sco);
    this.mon2sco = mon2sco;
  endfunction : new

  task main();
    Transaction trans;
    aes256_ref_model refernce;
    forever
    begin
      mon2sco.get(trans);
      refernce = new();
      exp_cp = refernce.encrypt(trans.plaintext,trans.key);
      num++;
      if(trans.ciphertext == exp_cp)
      begin
        $display("#############PASS#############");
        trans.display("SCO");
      end
      else
      begin
        $display("#############FAIL#############");
        trans.display("SCO");
        $display("---------------------------");
        $display("[%s | %0t] : VALID: %0b PT: %32h KEY: %64h DONE: %0b CT: %32h","REF",$time,trans.valid_in,trans.plaintext,trans.key,trans.done,exp_cp);
      end
    end
  endtask : main

endclass : Scoreboard
