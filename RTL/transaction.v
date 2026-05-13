class Transaction;

  bit [127:0] plaintext;
  bit [255:0] key;
  bit valid_in;
  bit done;
  bit [127:0] ciphertext;

  function void display(string str = "Tra");
    $display("---------------------------");
    $display("[%s | %0t] : VALID: %0b PT: %32h KEY: %64h DONE: %0b CT: %32h",str,$time,valid_in,plaintext,key,done,ciphertext);
  endfunction : display

endclass : Transaction
