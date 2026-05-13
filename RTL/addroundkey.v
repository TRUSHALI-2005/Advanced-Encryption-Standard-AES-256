module addroundkey(input i_clk_addround,i_valid_addround,i_rst_addround,input [127:0] i_data_addround,input [127:0] i_key_addround , output reg [127:0] o_addround,output reg o_valid_addround);

always@(posedge i_clk_addround or negedge i_rst_addround)
begin

  if(!i_rst_addround)
  begin
    o_addround <= 0;
    o_valid_addround <= 0;
  end

  else
  begin

    if(i_valid_addround)
    begin
      o_addround  <= (i_data_addround ^ i_key_addround);
      o_valid_addround <= 1;
      //$strobe($time,,"IP: %0h\t KEY: %0h", i_data_addround,i_key_addround);
      //$strobe("OP: %0h",o_addround);
    end

    else
    begin
      o_addround <= 32'h0;
      o_valid_addround <= 0;
    end

  end
end

endmodule
