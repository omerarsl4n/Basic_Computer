module BC_I (
input clk,
input FGI,
output [11:0] PC,
output [11:0] AR,
output [15:0] IR,
output [15:0] AC,
output [15:0] DR
);

wire[2:0] SEL,alu_SEL;
wire[15:0] TR; //I add it intentionally to test interrupt cycle.

wire readMEM,writeMEM,resetIR,writeIR,incIR,resetDR,writeDR,incDR,
		resetTR,writeTR,incTR,resetAR,writeAR,incAR,resetPC,writePC,incPC,
		resetAC,writeAC,incAC,resetIEN,setIEN,resetR,setR,R,IEN,CO,OVF,N,Z;

controller mycont(clk,IR[15],CO,N,Z,IEN,FGI,R,IR, AC, DR, SEL,alu_SEL,readMEM,writeMEM,resetIR,writeIR,incIR,resetDR,writeDR,incDR,
		resetTR,writeTR,incTR,resetAR,writeAR,incAR,resetPC,writePC,incPC,
		resetAC,writeAC,incAC,resetIEN,setIEN,resetR,setR);
		
datapath mydatapath(SEL,alu_SEL,clk,readMEM,writeMEM,resetIR,writeIR,incIR,resetDR,writeDR,incDR,
		resetTR,writeTR,incTR,resetAR,writeAR,incAR,resetPC,writePC,incPC,
		resetAC,writeAC,incAC,resetIEN,setIEN,resetR,setR,PC,AR,IR,AC,DR,TR,IEN,R,CO,OVF,N,Z);
		


endmodule
