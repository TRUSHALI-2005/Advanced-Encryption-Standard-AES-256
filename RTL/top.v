`include "mem.v"
`include "addroundkey.v"
`include "keyexpansion.v"
`include "mixcolumns.v"
`include "shiftrows.v"
`include "subbytes.v"

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
