package port_pkg;
parameter ADD_WIDTH = 8;
parameter DATA_WIDTH = 8;
parameter WIDTH = 128;
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
endpackage

