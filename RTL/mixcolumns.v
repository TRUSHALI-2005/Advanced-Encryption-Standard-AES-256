module mixcolumns(input i_clk_mixcol, i_rst_mixcol,i_valid_mixcol,input [127:0] i_mixcol, output reg [127:0] o_mixcol, output reg o_valid_mixcol);

integer i;
parameter a0 = 8'h02, a1 = 8'h01, a2 = 8'h01, a3 = 8'h03;

always@(posedge i_clk_mixcol or negedge i_rst_mixcol)
begin

  if(!i_rst_mixcol)
  begin
    o_mixcol <= 0;
    o_valid_mixcol <= 0;
  end

  else
  begin

    if(i_valid_mixcol)
    begin
      for(i = 0 ; i < 4 ; i = i + 1)
      begin
        //o_mixcol[3*32+i*8 +: 8] <= mpy( a0 , i_mixcol[3*32+i*8 +: 8] ) ^ mpy( a3 , i_mixcol[2*32+i*8 +: 8] ) ^ i_mixcol[1*32+i*8 +: 8] ^ i_mixcol[0*32+i*8 +:8] ;
        //o_mixcol[2*32+i*8 +: 8] <= i_mixcol[3*32+i*8 +: 8] ^ mpy( a0 , i_mixcol[2*32+i*8 +: 8] ) ^ mpy( a3 , i_mixcol[1*32+i*8 +: 8] ) ^ i_mixcol[0*32+i*8 +:8] ;
        //o_mixcol[1*32+i*8 +: 8] <= i_mixcol[3*32+i*8 +: 8]  ^ i_mixcol[2*32+i*8 +: 8]  ^ mpy(a0 , i_mixcol[1*32+i*8 +: 8] ) ^ mpy(a3 , i_mixcol[0*32+i*8 +:8] ) ;
        //o_mixcol[0*32+i*8 +: 8] <= mpy( a3 , i_mixcol[3*32+i*8 +: 8] ) ^ i_mixcol[2*32+i*8 +: 8]  ^ i_mixcol[1*32+i*8 +: 8] ^ mpy(a0 , i_mixcol[0*32+i*8 +:8] ) ;
        o_mixcol[i*32+3*8 +: 8] <= mpy( a0, i_mixcol[ i*32+3*8 +: 8] ) ^
                                   mpy( a3, i_mixcol[ i*32+2*8 +: 8] ) ^
                                   i_mixcol[ i*32+8 +: 8] ^
                                   i_mixcol[ i*32 +: 8 ];

        o_mixcol[i*32+2*8 +: 8] <= i_mixcol[ i*32+3*8 +: 8] ^
                                   mpy( a0, i_mixcol[ i*32+2*8 +: 8] ) ^
                                   mpy( a3, i_mixcol[ i*32+1*8 +: 8] ) ^
                                   i_mixcol[ i*32 +: 8 ];

        o_mixcol[i*32+1*8 +: 8] <= i_mixcol[ i*32+3*8 +: 8] ^
                                   i_mixcol[ i*32+2*8 +: 8] ^
                                   mpy( a0, i_mixcol[ i*32+8 +: 8] ) ^
                                   mpy( a3, i_mixcol[ i*32 +: 8 ] );

        o_mixcol[i*32+0*8 +: 8] <= mpy( a3, i_mixcol[ i*32+3*8 +: 8] ) ^
                                   i_mixcol[ i*32+2*8 +: 8] ^
                                   i_mixcol[ i*32+8 +: 8] ^
                                   mpy( a0, i_mixcol[ i*32 +: 8 ] );
      end
      o_valid_mixcol <= 1;
    end

    else
    begin
      o_mixcol <= 0;
      o_valid_mixcol <= 0;
    end

  end
end

function [7:0] mpy(input [7:0] mpy_a, mpy_b);
  reg [8:0] m;
  reg [8:0] p;
  integer i;
  begin
    p = 9'b1_0001_1011; 
    m = 0;

    for (i = 0; i <8; i = i + 1) begin
      m = m << 1;
      if (m[8])
        m = m ^ p;
      if (mpy_b[7])
        m = m ^ mpy_a;
      mpy_b= mpy_b << 1;
    end

    mpy = m[7:0];
  end
endfunction

endmodule
