module subbytes(input clk,rst,valid_in,input [127:0] i_subbyte, output reg [127:0] o_subbyte, output reg valid_out);

//store SBOX values
reg [7:0] SBOX [15:0][15:0];
integer i,j;

always@(posedge clk or negedge rst)
begin
	if(!rst)
	begin
					for( i = 0 ; i < 16 ; i = i + 1)
									for(j = 0 ; j < 16 ; j = j + 1)
													SBOX[i][j] <= 0;
					o_subbyte <= 0;
          valid_out <= 0;
	end
	else
	begin
    if(valid_in)
    begin
/*
      for(i = 0 ; i < 16 ; i = i + 1)
	      for(j = 0; j < 16 ; j = j + 1)
	    		SBOX[i][j] <= sbox(i*16+j);
  */    
	    for(i = 0 ; i < 16 ; i = i + 1)
        o_subbyte[i*8 +: 8] <=  SBOX[i_subbyte[(i*8)+4 +: 4]][i_subbyte[(i*8) +: 4]];

      valid_out <= 1'b1;
    end
    
    else
    begin
      o_subbyte <= 128'h0;
      valid_out <= 1'b0;
    end

  end

end
 
always @(posedge clk)
begin
      for(i = 0 ; i < 16 ; i = i + 1)
	      for(j = 0; j < 16 ; j = j + 1)
	    		SBOX[i][j] <= sbox(i*16+j);
end



//sbox genration
function [7:0] sbox (input [7:0] in);
reg [7:0] temp;
parameter [7:0] ci = 8'b0110_0011;
integer i; 
    begin
      temp = inv(in);
      for(i = 0; i < 8; i = i + 1)
        sbox[i] = temp[i] ^ temp[(i+4)%8] ^ temp[(i+5)%8] ^ temp[(i+6)%8] ^ temp[(i+7)%8] ^ ci[i];
	end
endfunction
  
function [7:0] inv(input [7:0] inv_ip);
    reg [7:0] inv_x;
    begin
      inv_x = inv_ip;
      if(inv_x == 0)
        inv = 0;
      else
        begin
      	    inv = mpy(inv_x,inv_x);               
            inv_x = mpy(inv,inv);                
            inv = mpy(inv,inv_x);                   
            inv_x = mpy(inv_x,inv_x);              
            inv = mpy(inv,inv_x);                 
            inv_x = mpy(inv_x,inv_x);            
            inv = mpy(inv,inv_x);               
            inv_x = mpy(inv_x,inv_x);          
            inv = mpy(inv,inv_x);             
            inv_x = mpy(inv_x,inv_x);        
            inv = mpy(inv,inv_x);           
            inv_x = mpy(inv_x,inv_x);      
            inv = mpy(inv,inv_x);         
        end
    end
  endfunction
  
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
