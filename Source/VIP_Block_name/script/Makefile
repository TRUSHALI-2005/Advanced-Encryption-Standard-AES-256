# -------- USER INPUT --------
FILE     ?=
PACKAGE  ?=
TB_NAME  ?=
WAVE     ?= 0
OPTIONS ?=

# -------- DERIVED PATHS --------
DIR        := $(abspath $(dir $(FILE)))
SRC_FILE   := $(notdir $(FILE))
TB_FILE    := $(SRC_FILE:.sv=_tb.sv)

LOG_FILE   := sim.log
WAVE_FILE  := $(TB_NAME).vcd

## -------- CHECKS --------
#ifeq ($(strip $(FILE)),)
#$(error FILE not set. Example: make test FILE=Training/Wave/design.sv TB_NAME=tb_sine_gen)
#endif
#
#ifeq ($(strip $(TB_NAME)),)
#$(error TB_NAME not set)
#endif

# -------- DEFAULT TARGET --------
all: compile simulate

# -------- COMPILE --------
compile:
	@echo "Compiling in $(DIR)"
	@cd $(DIR) && \
    vsimsa -c -do " \
        vlib work; \
        vmap work work; \
        vlog -sv {$(SRC_FILE)} {$(TB_FILE)}; \
        quit; \
    "

# -------- SIMULATE --------
simulate:
	@echo "Simulating in $(DIR)"
	@cd $(DIR) && \
    vsimsa -c -l $(LOG_FILE) -do " \
        vsim +access+r work.$(TB_NAME) $(OPTIONS); \
        if {$(WAVE) == 1} { \
            vcd file {$(WAVE_FILE)}; \
            vcd add -r /*; \
        }; \
        run -all; \
        quit; \
    "

# -------- CLEAN --------
clean:
	@echo "Cleaning generated files in $(DIR)"
	@rm -rf $(DIR)/work
	@rm -rf $(DIR)/compile
	@rm -rf $(DIR)/library.cfg
		@rm -f  $(DIR)/*.vcd
		@rm -f  $(DIR)/dataset.asdb
		@rm -f  $(DIR)/sim.log

.PHONY: all compile simulate test clean
#FILE ?=
#PACKAGE ?=  
#TB_NAME ?= 
#WAVE ?= 0
#
#DIR= $$(dirname "$(FILE)");
#NAME=$$(basename "$(FILE)".sv); 
#TB=$(DIR)/$(NAME)_tb.sv;
#WAVE_NAME := $(DIR)/$(TB_NAME).vcd;
##FILE := Training/Wave/design.sv Training/Wave/design_tb.sv
#
#all: build run
#
#build:
#	#echo "Starting Rivieria............"; \
#	#vsimsa -l sim.log -do \ 
#	#echo "Creating working library..."; \
#	#vlib work; \
#	#echo "mapping working library..."; \
#	#vmap work work; \
#	#echo "Compilation start..."; \
#	#echo $(DIR) \
#	#echo $(FILE); \
#	#echo $(TB); \
#	#vlog -sv $(FILE) $(PACKAGE) $(TB); \
#	#echo "Simulation start..."; \
#	##vsim -c -lib +access +r-->+ $$TB_NAME; 
#	#vsim -c work.$(TB_NAME); 
#	##asim +access+r --> $(TB_NAME) 
#	#echo "Waveform"; \
#	#vcd file $(DIR)/$(TB_NAME.vcd); \
#	#vcd add -r /*; \
#	#run -all; \
#	#q
#
#run_all:
#	vsimsa -l sim.log -do "\
#	vlib work \
#	vmap work work \
#	vlog -sv -dbg $(FILE) $(TB) \
#	vsim +access+r work.$(TB_NAME) \
#	vcd add wave -r sim:/$(TB_NAME)/* \
#	run -all \
#	quit" \
#	echo "DONE"
# 
#run_final:
#	vlib work \
#		vlog -sv $(FILE) \
#		vsimsa -c sine_gen -do "run -all"
#	
#simulate:
#	asim +access+r --> $(TB_NAME) \
#	  echo "Waveform"; \
#		vcd file $$DIR/$$TB_NAME.cd; \
#		vcd add -r /*; \
#	run -all; \
#	quit;  
#
#test:
#	@echo "Starting Riviera............"; \
#	vsimsa -c -l sim.log -do " \
#		echo Creating working library...; \
#		vlib work; \
#		echo Mapping working library...; \
#		vmap work work; \
#		echo Compilation start...; \
#		echo $(DIR); \
#		echo $(FILE); \
#		echo $(TB); \
#		vlog -sv $(FILE) $(PACKAGE) $(TB); \
#		echo Simulation start...; \
#		vsim +access+r work.$(TB_NAME); \
#		if {$(WAVE) == 1} { \
#			echo Waveform; \
#			echo $$(pwd); \
#			vcd file {$(WAVE_NAME)}; \
#			vcd add -r /*; \
#		}; \
#		run -all; \
#		echo Done Wave...; \
#		quit; \
#	"run:test:
#
#trial: 
#	@if [ "$(WAVE)" = "1" ]; then \
#													  echo "Waveform"; \
#	 fi; \
#
#run: 
#	@echo "Simulat the file...."; \
#	vsim work.$$TB_NAME; \
#	asim +access +r-->+ $$TB_NAME; \
#	if [ "$(WAVE)" = "1" ]; then \
#		vcd file $$DIR/$$TB_NAME.cd; \
#		vcd add -r /*; \
#	fi; \
#	run -all;
#

	#vsimsa -l sim.log -do "vlib work; vmap work work vlog "; \
	#if [ $$? -ne 0 ]; then \
	#	echo "U don't have valid Licence"; \
	#	exit 1; \
	#fi; \
	#echo "Creating Working Library.............."; \
	#vlib work; \
	#echo "Mapping Library................"; \
	#vmap work work; \
	#echo "-------------------------------------"; \
	#echo "FILE NAME: $(FILE)"; \
	#echo "TESTBENCH: $(TB)"; \
	#echo "EXTRA: $(EXTRA)"; \
	#echo "-------------------------------------"; \
	#vlog -sv "$$FILE" "$$TB" "$$EXTRA"; \
	#if [ $$? -ne 0 ]; then \
	#  echo "Compilation Failed"; \
	#	exit 1; \
	#fi; \
