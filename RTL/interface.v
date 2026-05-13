interface inf(input logic clk);
  logic rst;
  logic valid_in;
  logic [127:0] plaintext;
  logic [255:0] key;
  logic [127:0] ciphertext;
  logic done;

  clocking cb_dri @(posedge clk);
    default input #1 output #0;
    output valid_in, plaintext, key;
  endclocking : cb_dri

  clocking cb_mon @(posedge clk);
    default input #0 output #0;
    input valid_in, plaintext, key, ciphertext, done;
  endclocking : cb_mon

  modport DRV ( clocking cb_dri );
  modport MON ( clocking cb_mon );

endinterface
