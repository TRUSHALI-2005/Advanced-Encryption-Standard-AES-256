class Random extends Test;
  
  function new(virtual inf inff);
    super.new(inff);
  endfunction : new
  
task main();
  Transaction trans;
  int num;
  reset();
  env.run();
  if($value$plusargs ("NUM=%d",num))
    $info("NUM = %0d",num);
  else
    num = 1;
  repeat(num) begin
  trans = new();
  trans.valid_in = 1'b1;
  if(!trans.randomize())
    $error("Randomization Failed");
  else
    begin
      send_data_gen(trans);
      @(posedge vif.clk)
      trans.valid_in = 1'b0;
      send_data_gen(trans);
  	  count++;
    end
   repeat(56) @(posedge vif.clk); 
  end
  endtask: main
  
endclass : Random
