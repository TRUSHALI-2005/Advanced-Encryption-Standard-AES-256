module keyexpansion(input rst,clk,valid,input [255:0] key,output reg valid_out,output reg [1919:0] round_key);

parameter NK = 8, NR = 14; // The no of words in key
parameter KEY_SIZE = 2**NK; //The No of bits in key
// wire [KEY_SIZE-1:0] key; //Input key size = 8 words
// wire clk,rst;
// reg [1919:0] round_key;

integer i = 0,j=0;
reg [7:0] SBOX [15:0][15:0];

always @(posedge clk or negedge rst) 
begin
  if (!rst) 
  begin
    round_key <= {60{32'b0}};
    valid_out <= 0;
  end 
  else 
  begin
    if (valid) 
    begin
      round_key <= key_expansion(key);
      valid_out <= 1'b1;
    end
    else
    begin
      //round_key <= 0;
      valid_out <= 0;
    end
  end
end

always@(posedge rst)
begin
  for(i = 0 ; i < 16 ; i = i + 1 )
    for(j = 0 ; j < 16 ; j = j + 1)
      SBOX[i][j] = sbox(i*16+j);
end

//-----------------------KEYEXPANSION---------------------------------
function [1919:0] key_expansion ( input [255:0] key );
  reg [31:0] w [ 59:0] ;
  reg [31:0] temp;
  begin
    //First 8 words as it is
    for(i = 0 ; i < 8 ; i = i + 1)
    begin
		  w[i] = key[255-(i*32) -: 32];
    end
    
    //Logic for next 52 words
    for(i = 8 ; i < 60 ; i = i + 1)
		begin
			
			temp = w[i-1];
      
      //If i% Nk == 0
			if(i % 8 == 0)
			begin
				w[i] = w[i-8] ^ subword(rotword(temp)) ^ rcon(i/8) ;
			end
      
      //If i%Nk ==4
			else if( i% 8 == 4)
			begin
				w[i] = w[i-8] ^ subword(temp);
			end
      
      //Otherwise
			else
			begin
				w[i] = w[i-8] ^ temp;
			end
		
    end

    for (i = 0; i < 15 ; i = i + 1)
    begin            
      key_expansion[i*128 +: 128] = { w[i*4+0], w[i*4+1], w[i*4+2], w[i*4+3] } ;
      //$display("Key_expansion[%d] = %h",i,key_expansion[i*128 +: 128]);
    end
    
  end

endfunction

//Rotate Word
function [31:0] rotword(input [31:0] word);
	begin
		rotword = {word[23:0],word[31:24]};
	end
endfunction

//subword
function [31:0] subword (input [31:0] word);
	begin
		subword = { SBOX[word[31:28]][word[27:24]], SBOX[word[23:20]][word[19:16]], SBOX[word[15:12]][word[11:8]], SBOX[word[7:4]][word[3:0]] };
	end
endfunction

//rcon define
function [31:0] rcon;
        input [3:0] round;
        begin
            case (round)
                4'd1:  rcon = 32'h01000000;
                4'd2:  rcon = 32'h02000000;
                4'd3:  rcon = 32'h04000000;
                4'd4:  rcon = 32'h08000000;
                4'd5:  rcon = 32'h10000000;
                4'd6:  rcon = 32'h20000000;
                4'd7:  rcon = 32'h40000000;
                4'd8:  rcon = 32'h80000000;
                4'd9:  rcon = 32'h1B000000;
                4'd10: rcon = 32'h36000000;
                default: rcon = 32'h00000000;
            endcase
        end
    endfunction


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

