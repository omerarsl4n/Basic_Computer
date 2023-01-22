# Copyright (c) 2016 Technische Universitaet Dresden, Germany
# Chair for VLSI-Design, Diagnostic and Architecture
# Author: Martin Zabel
# All rights reserved.

CWD=$(shell pwd)

SIM ?= icarus
TOPLEVEL_LANG ?=verilog

VERILOG_SOURCES =$(CWD)/../hdl/ALU_implement.v
VERILOG_SOURCES +=$(CWD)/../hdl/BC_I.v
VERILOG_SOURCES +=$(CWD)/../hdl/controller.v
VERILOG_SOURCES +=$(CWD)/../hdl/datapath.v
VERILOG_SOURCES +=$(CWD)/../hdl/decod_3_to_8_opcode.v
VERILOG_SOURCES +=$(CWD)/../hdl/decod_4_to_16_time.v
VERILOG_SOURCES +=$(CWD)/../hdl/encod_8_to_3.v
VERILOG_SOURCES +=$(CWD)/../hdl/memory_unit.v
VERILOG_SOURCES +=$(CWD)/../hdl/Register_sync_rw.v
VERILOG_SOURCES +=$(CWD)/../hdl/W_bit_bus.v

TOPLEVEL = BC_I
MODULE := AU_cocotb_test
COCOTB_HDL_TIMEUNIT=1us
COCOTB_HDL_TIMEPRECISION=1us

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
