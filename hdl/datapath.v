module datapath(
input	[2:0]S,alu_SEL,
input clk,readMEM,writeMEM,resetIR,writeIR,incIR,resetDR,writeDR,incDR,
		resetTR,writeTR,incTR,resetAR,writeAR,incAR,resetPC,writePC,incPC,
		resetAC,writeAC,incAC,resetIEN,writeIEN,resetR,writeR,
output wire [11:0] PC,AR,
output wire [15:0] IR,AC,DR,TR,
output wire IEN,R,CO,OVF,N,Z
);

wire [15:0] NOP,BUS_OUT,MEM_CONT,ALU_OUT;
wire [7:0]  INPR, OUTR;


memory_unit mymem(clk,readMEM,writeMEM,BUS_OUT,AR,MEM_CONT);

Register_sync_rw #(.WIDTH(12))	myAR(clk,resetAR,writeAR,incAR,BUS_OUT,AR);
Register_sync_rw #(.WIDTH(12))	myPC(clk,resetPC,writePC,incPC,BUS_OUT,PC);
Register_sync_rw #(.WIDTH(16))	myDR(clk,resetDR,writeDR,incDR,BUS_OUT,DR);
Register_sync_rw #(.WIDTH(16))	myAC(clk,resetAC,writeAC,incAC,ALU_OUT,AC);
Register_sync_rw #(.WIDTH(16))	myIR(clk,resetIR,writeIR,incIR,BUS_OUT,IR);
Register_sync_rw #(.WIDTH(16))	myTR(clk,resetTR,writeTR,incTR,BUS_OUT,TR);
Register_sync_rw #(.WIDTH(1))	   myIEN(clk,resetIEN,writeIEN,0,1,IEN);
Register_sync_rw #(.WIDTH(1))	   myR(clk,resetR,writeR,0,1,R);


W_bit_bus #(.WIDTH(16)) mybus(NOP,AR,PC,DR,AC,IR,TR,MEM_CONT,S,BUS_OUT);
ALU_implement #(.WIDTH(16)) myalu(CO,AC,DR,alu_SEL,ALU_OUT,CO,OVF,N,Z);
endmodule
