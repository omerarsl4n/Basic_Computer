# ==============================================================================
# Authors:              Doğu Erkan Arkadaş - Utkucan Doğan
#
# Cocotb Testbench:     For Signed Magnitude Adder/Subtractor
#
# Description:
# ------------------------------------
# Several test-benches as example for EE446
#
# License:
# ==============================================================================


import random
import warnings

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge
from cocotb.triggers import Edge
from cocotb.binary import BinaryValue
#from cocotb.regression import TestFactory


# @cocotb.test()
# async def au_fail_test(dut):
#     #Generate the clock
#     await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))

#     clkedge = FallingEdge(dut.clk)
#     A=10
#     B=5
#     dut.A.value=A
#     dut.B.value=B
#     dut.add.value=1
#     dut.sub.value=0      
#     await clkedge
#     #check if the module subtracted the values to get a fail
#     assert dut.Q.value == A - B    
@cocotb.test()
async def my_basic_comp_test(dut):
    """Setup testbench and run a test for my comp"""
    #Generate the clock
    await cocotb.start(Clock(dut.clk, 10, 'us').start(start_high=False))
    #set clkedge as the falling edge for triggers
    clkedge = RisingEdge(dut.clk)
    await clkedge
    for i in range(100):
        dut.incPC.value=1 ## increment PC to 100 which stores first instruction
        await clkedge
    await clkedge
    AC = 0 ##CLEAR AC
    assert dut.PC.value == 100
    await clkedge##T0 operation
    await clkedge##T1
    assert dut.IR.value == 0x7800
    await clkedge##T2
    await clkedge##T3
    assert dut.AC.value == AC    ##CLA OP FINSH
    AC = 0X1100 ##LOAD AC
    await clkedge##T0
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    await clkedge##T5
    assert dut.AC.value == AC ##LDA OP FINISH   
    DATA = 0X0011
    AC = AC + DATA ## ADD AC
    await clkedge##T0
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    await clkedge##T5
    assert dut.AC.value == AC ##ADD OP FINISH   1100 + 0011 = 1111
    DATA = 0X1110
    AC= AC & DATA ##AND AC
    await clkedge##T0
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    await clkedge##T5
    assert dut.AC.value == AC ##AND OP FINISH   1111 & 1110 = 1110
    AC = (~AC) & 0xffff ##CASTING ##Complement AC and convert unsigned for python
    await clkedge##T0
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    assert dut.AC.value == AC ##CMA OP FINISH   (1110)' = (EEEF)
    await clkedge##T0
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4             ## STA OP FINISH
    await clkedge##T0             ## ISZ OP START
    DATA = (AC + 1) & 0xffff ##CASTING
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    await clkedge##T5
    await clkedge##T6
    assert dut.DR.value == DATA  #ISZ OP FINISH   EEEF++ = EEEF0
    await clkedge##T0            
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    await clkedge##T5
    assert dut.PC.value == 501     #BSA OP FINISH
    AC = DATA ## LOAD AC
    await clkedge##T0            
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    await clkedge##T5
    assert dut.AC.value == AC  ##LDA OP FINISH  EEF0
    hold_msb = (AC & 0X8000) >>15 ##hold msb for left shift operation
    AC = (AC << 1) & 0XFFFF ## normal shift left
    AC = (AC) | hold_msb ## correct lsb with utilizing hold_msb
    await clkedge##T0            
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    assert dut.AC.value == AC  ##CIL OP FINISH  CIL(EEF0) = DDE1 
    await clkedge##T0            
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    assert dut.PC.value == 108  ##BUN I OP FINISH
    AC = (AC + 1) & 0xffff ##CASTING
    await clkedge##T0            
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    assert dut.AC.value == AC  ##INC OP FINISH, LAST INSTRUCTION IN THE TEST, remainings for check for interrupts.


    





    await clkedge##T0            ###TO CHECK INTERRUPT CYCLE ## AS AN ISR, I LOADED ADR(100) WHICH IS THE FIRST INSTRUNCTION IN THE TEST. 
    await clkedge##T1            ### SO IT CAN BE THOUGHT AS RESET INTERRUPT.
    await clkedge##T2
    await clkedge##T3
    assert dut.IEN.value == 1   ##IEN OP FINISH, SET IEN FIRST
    dut.FGI.value = 1           ##SET FGI TO CREATE INTRERRUPT
    AC = (AC + 1) & 0xffff ##CASTING     
    await clkedge##T0   
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    assert dut.AC.value == AC   ##INC OP FINISH AND INTERRUPT CYCLE START  
    assert dut.R.value == 1     
    assert dut.FGI.value == 1
    assert dut.IEN.value == 1 
    await clkedge
    await clkedge##T0           
    assert dut.PC.value == 0 
    assert dut.TR.value == 111
    await clkedge##T1 
    await clkedge##T2               ##END OF Interrupt cycle
    assert dut.PC.value == 1
    assert dut.IEN.value == 0
    assert dut.R.value == 0
    await clkedge##T0               ##BUN TO MEMORY 100 LOCATED AT THE ADDRES OF 1 AS ISR
    await clkedge##T1
    await clkedge##T2
    await clkedge##T3
    await clkedge##T4
    assert dut.PC.value == 100      ##Correctly Go to ISR and end of the test procedure.