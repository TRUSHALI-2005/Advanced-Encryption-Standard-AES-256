////module subbytes(input clk,rst,valid_in,input [127:0] i_subbyte, output reg [127:0] o_subbyte, output reg valid_out);
////module shiftrows(input rst_shiftrows,clk_shiftrows,i_valid_shiftrows, input [127:0] i_shiftrows,output reg [127:0] o_shiftrows, output reg o_valid_shiftrows);
////module mixcolumns(input i_clk_mixcol, i_rst_mixcol,i_valid_mixcol,input [127:0] i_mixcol, output reg [127:0] o_mixcol, output reg o_valid_mixcol);
////module addroundkey(input i_clk_addround,i_valid_addround,i_rst_addround,input [127:0] i_data_addround,input [127:0] i_key_addround , output reg [127:0] o_addround,output reg o_valid_addround);
////module sbox(output reg [127:0] sbox_out);
////module syn_FIFO #(parameter DEPTH = 16, parameter DATA_WIDTH = 8) ( input wr_en,rd_en, input [DATA_WIDTH-1:0] data_in, output reg [DATA_WIDTH-1:0] data_out, output full,empty, input clk,rst, output reg valid_out);
//
//module top ( input clk, rst, valid_in, input [127:0] plaintext, input [255:0] key, output [127:0] ciphertext, output done );
//
//wire [1919:0] expanded_key;
////reg [7:0] SBOX [15:0][15:0];
//integer i,j;
//parameter DEPTH = 56, DATA_WIDTH_KEY = 256, DATA_WIDTH_DATA = 128;
//wire [127:0] temp_text;
//wire [127:0] temp  [0:16];
//wire [127:0] temp1 [0:12];
//wire [127:0] temp2 [0:12];
//wire [127:0] temp3 [0:12];
//
//wire valid  [0:16];
//wire valid1 [0:12];
//wire valid2 [0:12];
//wire valid3 [0:12];
//wand start;
//reg ready;
//wor empty,full;
//
////reg [2:0] state,next_state;
////parameter s0 = 3'b000, //IDLE
////          s1 = 3'b001, //Initial Addround
////          s2 = 3'b010, //13 rounda
////          s3 = 3'b011, //Last round without mixcol
////          s4 = 3'b100; //Done
//
//
//keyexpansion keyexpansion_DUT ( .key(key),
//                                  .valid(valid_in),
//                                  .rst(rst),
//                                  .clk(clk),
//                                  .round_key(expanded_key),
//                                  .valid_out(start1) );
//
//addroundkey addroundkey_INIT_DUT ( .i_clk_addround(clk),
//                                   .i_rst_addround(rst),
//                                   .i_valid_addround(start1),
//                                   .i_data_addround(plaintext),
//                                   .i_key_addround(expanded_key[127:0]),
//                                   .o_addround(temp[0]),
//                                   .o_valid_addround(valid[0]) );
//
//genvar k;
//
//generate
//  for( k = 0 ; k < 13 ; k = k + 1)
//  begin
//    subbytes subbytes_DUT ( .clk(clk),
//                            .rst(rst), 
//                            .valid_in(valid[k]), 
//                            .i_subbyte(temp[k]), 
//                            .o_subbyte(temp1[k]), 
//                            .valid_out(valid1[k]) );
//    
//    shiftrows shiftrows_DUT( .clk_shiftrows(clk), 
//                             .rst_shiftrows(rst), 
//                             .i_valid_shiftrows(valid1[k]),
//                             .i_shiftrows(temp1[k]),
//                             .o_shiftrows(temp2[k]),
//                             .o_valid_shiftrows(valid2[k]) );
//    
//   mixcolumns mixcol_DUT( .i_clk_mixcol(clk),
//                          .i_rst_mixcol(rst),
//                          .i_valid_mixcol(valid2[k]),
//                          .i_mixcol(temp2[k]),
//                          .o_mixcol(temp3[k]),
//                          .o_valid_mixcol(valid3[k]) );
//    
//    addroundkey addround_DUT( .i_clk_addround(clk),
//                              .i_rst_addround(rst),
//                              .i_valid_addround(valid3[k]),
//                              .i_data_addround(temp3[k]),
//                              .i_key_addround(expanded_key[(k+1)*128 +: 128]),
//                              .o_addround(temp[k+1]),
//                              .o_valid_addround(valid[k+1]) );
//  end
//endgenerate
//
//
//subbytes subbytes_DUT ( .clk(clk),
//                        .rst(rst), 
//                        .valid_in(valid[13]), 
//                        .i_subbyte(temp[13]), 
//                        .o_subbyte(temp[14]), 
//                        .valid_out(valid[14]) );
//    
//shiftrows shiftrows_DUT( .clk_shiftrows(clk), 
//                         .rst_shiftrows(rst), 
//                         .i_valid_shiftrows(valid[14]),
//                         .i_shiftrows(temp[14]),
//                         .o_shiftrows(temp[15]),
//                         .o_valid_shiftrows(valid[15]) );
//
//addroundkey addround_DUT( .i_clk_addround(clk),
//                          .i_rst_addround(rst),
//                          .i_valid_addround(valid[15]),
//                          .i_data_addround(temp[15]),
//                          .i_key_addround(expanded_key[1919:1792]),
//                          .o_addround(ciphertext),
//                          .o_valid_addround(done) );
//
////assign ready = (done == 0 && empty == 0) ? 1'b0 : 1'b1;
//
//
////always@(posedge clk)
////begin
////  if(!rst)
////  begin
////    expanded_key <= 0;
////  end
////
////  else
////  begin
////    state <= next_state;
////  end
////end
//
////always@(*)
////begin
////  case(state)
////    s0: if(valid_in) begin next_state = s1; expanded_key = key_expansion(key);end
////    s1: if(valid[1]) next_state = s2; 
////    s2: if(valid[13]) next_state = s3;
////    s3: if(valid[16]) next_state = s4; 
////    s4: next_state = s0;
////    default: next_state = s0;
////  endcase
////end
//
////always@(*)
////begin
////  case({state,next_state})
////    {s3,s4}: done = 1'b1;
////    default: done = 1'b0;
////  endcase
////end
//
////always@(posedge rst)
////begin
////  for(i = 0 ; i < 16 ; i = i + 1 )
////    for(j = 0 ; j < 16 ; j = j + 1)
////      SBOX[i][j] = sbox(i*16+j);
////end
//
////always@(key)
////  if(valid_in)
////expanded_key = key_expansion(key);
//
//////-----------------------KEYEXPANSION---------------------------------
////function [1919:0] key_expansion ( input [255:0] key );
////  reg [31:0] w [ 59:0] ;
////  reg [31:0] temp;
////  begin
////    //First 8 words as it is
////    for(i = 0 ; i < 8 ; i = i + 1)
////    begin
////		  w[i] = key[255-(i*32) -: 32];
////    end
////    
////    //Logic for next 52 words
////    for(i = 8 ; i < 60 ; i = i + 1)
////		begin
////			
////			temp = w[i-1];
////      
////      //If i% Nk == 0
////			if(i % 8 == 0)
////			begin
////				w[i] = w[i-8] ^ subword(rotword(temp)) ^ rcon(i/8) ;
////			end
////      
////      //If i%Nk ==4
////			else if( i% 8 == 4)
////			begin
////				w[i] = w[i-8] ^ subword(temp);
////			end
////      
////      //Otherwise
////			else
////			begin
////				w[i] = w[i-8] ^ temp;
////			end
////		
////    end
////
////    for (i = 0; i < 15 ; i = i + 1)
////    begin            
////      key_expansion[i*128 +: 128] = { w[i*4+0], w[i*4+1], w[i*4+2], w[i*4+3] } ;
////      $display("Key_expansion[%d] = %h",i,key_expansion[i*128 +: 128]);
////    end
////    
////  end
////
////endfunction
//////-----------------------------------------------------------------------
////
//////----------------------------Rotate Word-------------------------------
////function [31:0] rotword(input [31:0] word);
////	begin
////		rotword = {word[23:0],word[31:24]};
////	end
////endfunction
//////-----------------------------------------------------------------------
////
//////-----------------------------subword----------------------------------
////function [31:0] subword (input [31:0] word);
////	begin
////		subword = { SBOX[word[31:28]][word[27:24]], SBOX[word[23:20]][word[19:16]], SBOX[word[15:12]][word[11:8]], SBOX[word[7:4]][word[3:0]] };
////	end
////endfunction
//////-----------------------------------------------------------------------
////
//////------------------------------rcon define-----------------------------
////function [31:0] rcon;
////  input [3:0] round;
////  begin
////    case (round)
////      4'd1:  rcon = 32'h01000000;
////      4'd2:  rcon = 32'h02000000;
////      4'd3:  rcon = 32'h04000000;
////      4'd4:  rcon = 32'h08000000;
////      4'd5:  rcon = 32'h10000000;
////      4'd6:  rcon = 32'h20000000;
////      4'd7:  rcon = 32'h40000000;
////      4'd8:  rcon = 32'h80000000;
////      4'd9:  rcon = 32'h1B000000;
////      4'd10: rcon = 32'h36000000;
////      default: rcon = 32'h00000000;
////    endcase
////  end
////endfunction
//////-----------------------------------------------------------------------
////
//////------------------------------sbox genration--------------------------
////function [7:0] sbox (input [7:0] in);
////reg [7:0] temp;
////parameter [7:0] ci = 8'b0110_0011;
////integer i; 
////    begin
////      temp = inv(in);
////      for(i = 0; i < 8; i = i + 1)
////        sbox[i] = temp[i] ^ temp[(i+4)%8] ^ temp[(i+5)%8] ^ temp[(i+6)%8] ^ temp[(i+7)%8] ^ ci[i];
////	end
////endfunction
//////-----------------------------------------------------------------------
////
//////---------------------------GF INV-------------------------------------
////function [7:0] inv(input [7:0] inv_ip);
////  reg [7:0] inv_x;
////  begin
////    inv_x = inv_ip;
////    if(inv_x == 0)
////      inv = 0;
////      else
////      begin
////      	inv = mpy(inv_x,inv_x);               
////        inv_x = mpy(inv,inv);                
////        inv = mpy(inv,inv_x);                   
////        inv_x = mpy(inv_x,inv_x);              
////        inv = mpy(inv,inv_x);                 
////        inv_x = mpy(inv_x,inv_x);            
////        inv = mpy(inv,inv_x);               
////        inv_x = mpy(inv_x,inv_x);          
////        inv = mpy(inv,inv_x);             
////        inv_x = mpy(inv_x,inv_x);        
////        inv = mpy(inv,inv_x);           
////        inv_x = mpy(inv_x,inv_x);      
////        inv = mpy(inv,inv_x);         
////    end
////  end
////endfunction
//////-----------------------------------------------------------------------
////
//////---------------------------------GF------------------------------------  
////function [7:0] mpy(input [7:0] mpy_a, mpy_b);
////  reg [8:0] m;
////  reg [8:0] p;
////  integer i;
////  begin
////    p = 9'b1_0001_1011; 
////    m = 0;
////  
////    for (i = 0; i <8; i = i + 1) begin
////      m = m << 1;
////      if (m[8])
////        m = m ^ p;
////      if (mpy_b[7])
////        m = m ^ mpy_a;
////      mpy_b= mpy_b << 1;
////    end
////  
////    mpy = m[7:0];
////  end
////endfunction
//////-----------------------------------------------------------------------
//
//endmodule
//
//
//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//module subbytes(input clk,rst,valid_in,input [127:0] i_subbyte, output reg [127:0] o_subbyte, output reg valid_out);
//module shiftrows(input rst_shiftrows,clk_shiftrows,i_valid_shiftrows, input [127:0] i_shiftrows,output reg [127:0] o_shiftrows, output reg o_valid_shiftrows);
//module mixcolumns(input i_clk_mixcol, i_rst_mixcol,i_valid_mixcol,input [127:0] i_mixcol, output reg [127:0] o_mixcol, output reg o_valid_mixcol);
//module addroundkey(input i_clk_addround,i_valid_addround,i_rst_addround,input [127:0] i_data_addround,input [127:0] i_key_addround , output reg [127:0] o_addround,output reg o_valid_addround);
//module sbox(output reg [127:0] sbox_out);
//module syn_FIFO #(parameter DEPTH = 16, parameter DATA_WIDTH = 8) ( input wr_en,rd_en, input [DATA_WIDTH-1:0] data_in, output reg [DATA_WIDTH-1:0] data_out, output full,empty, input clk,rst, output reg valid_out);
// module mem(input rst, clk, i_valid_mem, input [127:0] i_mem,output reg [127:0] o_mem, output reg o_valid_mem);

`include "mem.sv"
`include "addroundkey.sv"
`include "keyexpansion.sv"
`include "mixcolumns.sv"
`include "shiftrows.sv"
`include "subbytes.sv"

module top ( input clk, rst, valid_in, input [127:0] plaintext, input [255:0] key, output [127:0] ciphertext, output done );

wire [1919:0] expanded_key;
//reg [7:0] SBOX [15:0][15:0];
integer i,j;
parameter DATA_WIDTH_KEY = 256, DATA_WIDTH_DATA = 128;
wire [127:0] temp_pt;
wire [127:0] temp  [0:16];
wire [127:0] temp1 [0:12];
wire [127:0] temp2 [0:12];
wire [127:0] temp3 [0:12];

wire valid  [0:16];
wire valid1 [0:12];
wire valid2 [0:12];
wire valid3 [0:12];
wand start1;

keyexpansion keyexpansion_DUT ( .key(key),
                                  .valid(valid_in),
                                  .rst(rst),
                                  .clk(clk),
                                  .round_key(expanded_key),
                                  .valid_out(start1) );

mem mem_DUT ( .rst(rst), 
              .clk(clk), 
              .i_valid_mem(valid_in),
              .i_mem(plaintext),
              .o_mem(temp_pt),
              .o_valid_mem(start1) );

addroundkey addroundkey_INIT_DUT ( .i_clk_addround(clk),
                                   .i_rst_addround(rst),
                                   .i_valid_addround(start1),
                                   .i_data_addround(temp_pt),
                                   .i_key_addround(expanded_key[127:0]),
                                   .o_addround(temp[0]),
                                   .o_valid_addround(valid[0]) );

genvar k;

generate
  for( k = 0 ; k < 13 ; k = k + 1)
  begin
    subbytes subbytes_DUT ( .clk(clk),
                            .rst(rst), 
                            .valid_in(valid[k]), 
                            .i_subbyte(temp[k]), 
                            .o_subbyte(temp1[k]), 
                            .valid_out(valid1[k]) );
    
    shiftrows shiftrows_DUT( .clk_shiftrows(clk), 
                             .rst_shiftrows(rst), 
                             .i_valid_shiftrows(valid1[k]),
                             .i_shiftrows(temp1[k]),
                             .o_shiftrows(temp2[k]),
                             .o_valid_shiftrows(valid2[k]) );
    
   mixcolumns mixcol_DUT( .i_clk_mixcol(clk),
                          .i_rst_mixcol(rst),
                          .i_valid_mixcol(valid2[k]),
                          .i_mixcol(temp2[k]),
                          .o_mixcol(temp3[k]),
                          .o_valid_mixcol(valid3[k]) );
    
    addroundkey addround_DUT( .i_clk_addround(clk),
                              .i_rst_addround(rst),
                              .i_valid_addround(valid3[k]),
                              .i_data_addround(temp3[k]),
                              .i_key_addround(expanded_key[(k+1)*128 +: 128]),
                              .o_addround(temp[k+1]),
                              .o_valid_addround(valid[k+1]) );
  end
endgenerate


subbytes subbytes_DUT ( .clk(clk),
                        .rst(rst), 
                        .valid_in(valid[13]), 
                        .i_subbyte(temp[13]), 
                        .o_subbyte(temp[14]), 
                        .valid_out(valid[14]) );
    
shiftrows shiftrows_DUT( .clk_shiftrows(clk), 
                         .rst_shiftrows(rst), 
                         .i_valid_shiftrows(valid[14]),
                         .i_shiftrows(temp[14]),
                         .o_shiftrows(temp[15]),
                         .o_valid_shiftrows(valid[15]) );

addroundkey addround_DUT( .i_clk_addround(clk),
                          .i_rst_addround(rst),
                          .i_valid_addround(valid[15]),
                          .i_data_addround(temp[15]),
                          .i_key_addround(expanded_key[1919:1792]),
                          .o_addround(ciphertext),
                          .o_valid_addround(done) );

    
endmodule
