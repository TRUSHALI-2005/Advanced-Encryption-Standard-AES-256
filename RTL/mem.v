module mem(input rst, clk, i_valid_mem, input [127:0] i_mem,output reg [127:0] o_mem, output reg o_valid_mem);

  always@(posedge clk or negedge rst)
  begin
  
    if(!rst)
    begin
      o_mem <= 0;
      o_valid_mem <= 0;
    end
  
    else
    begin
      if(i_valid_mem)
      begin
        o_mem <= i_mem;
        o_valid_mem <= 1;
      end
      else
      begin
        o_mem <= 0;
        o_valid_mem <= 0;
      end
    end
  end

endmodule

