module shiftrows(input rst_shiftrows,clk_shiftrows,i_valid_shiftrows, input [127:0] i_shiftrows,output reg [127:0] o_shiftrows, output reg o_valid_shiftrows);

always@(posedge clk_shiftrows or negedge rst_shiftrows)
begin

  if(!rst_shiftrows)
  begin
    o_shiftrows <= 0;
    o_valid_shiftrows <= 0;
  end

  else
  begin
    if(i_valid_shiftrows)
    begin
      o_shiftrows[127:96] <= {i_shiftrows[127:120],i_shiftrows[87:80],i_shiftrows[47:40],i_shiftrows[7:0]};
      o_shiftrows[95:64] <= {i_shiftrows[95:88],i_shiftrows[55:48],i_shiftrows[15:8],i_shiftrows[103:96]}; //shift by 1 byte left
      o_shiftrows[63:32] <= {i_shiftrows[63:56],i_shiftrows[23:16],i_shiftrows[111:104],i_shiftrows[71:64]}; //shift by 2 byte left
      o_shiftrows[31:0] <= {i_shiftrows[31:24],i_shiftrows[119:112],i_shiftrows[79:72],i_shiftrows[39:32]}; //shift by 3 byte left
      o_valid_shiftrows <= 1;
    end
    else
    begin
      o_shiftrows <= 0;
      o_valid_shiftrows <= 0;
    end
  end
end

endmodule
