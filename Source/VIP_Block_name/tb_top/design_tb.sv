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

string testname;
initial
  begin
//     t1 = new(inff);
    testcase();
    t1.main();
    wait(t1.count == t1.env.sco.num);
    $info("WAIT DONE %0t",$time);
    @(posedge inff.clk);
    $finish;
  end

always #10 clk = ~clk;

initial
begin
  $dumpfile("AES_dump.vcd");
  $dumpvars;
end

task testcase();
  if($value$plusargs ("TESTNAME=%s",testname))
  begin
    case(testname)
      "sanity" : begin t1 = Sanity::new(inff); end
      "all_zero": begin t1 = All_zero::new(inff); end
      "all_ones": begin t1 = All_ones::new(inff); end
      "alternate": begin t1 = Alternate::new(inff); end
      "random" : begin t1 = Random::new(inff); end
      default: $fatal("TESTNAME NOT FOUND");
    endcase
  end
endtask : testcase

endmodule : testbench
