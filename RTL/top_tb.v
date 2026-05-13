`include "package.sv"
`include "interface.sv"
import port_pkg::*;

module testbench;
bit clk;
inf inff(clk);

Test t1;

top DUT ( .clk(inff.clk),
          .rst(inff.rst),
          .valid_in(inff.valid_in),
          .plaintext(inff.plaintext),
          .key(inff.key),
          .ciphertext(inff.ciphertext),
          .done(inff.done) );

initial
  begin
    t1 = new(inff);
    inff.rst = 1'b0;
    reset();
    t1.run();
  end

always #10 clk = ~clk;

task reset();
  $display("RESET TASK");
  inff.rst = 1'b0;
  inff.plaintext = 128'b0;
  inff.key = 256'b0;
  inff.valid_in = 'b0;
  @(posedge inff.clk);
  @(posedge inff.clk);
  inff.rst = 1'b1;
  @(posedge inff.clk);
  $display("RESET DONE");
endtask : reset

initial
begin
  $dumpfile("AES_dump.vcd");
  $dumpvars;
end
endmodule : testbench
