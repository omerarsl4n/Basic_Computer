module controller(

input clk,I,CO,N,Z,IEN,FGI,R, 
input[15:0] IR, AC, DR,
output wire[2:0] SEL,alu_SEL,
output wire readMEM,writeMEM,resetIR,writeIR,incIR,resetDR,writeDR,incDR,
		resetTR,writeTR,incTR,resetAR,writeAR,incAR,resetPC,writePC,incPC,
		resetAC,writeAC,incAC,resetIEN,setIEN,resetR,setR
);

reg  Start;
wire INC_SC,CLR_SC;
wire [7:0]  D,X,AX;
wire [3:0]  SC;
wire [15:0] T;

Register_sync_rw #(.WIDTH(4))	mySC(.clk(clk), .reset(CLR_SC), .increment(INC_SC), .A(SC));
//SC CONTROL
assign INC_SC = 1;
assign CLR_SC = (T[5] & (D[0] | D[1] | D[2] | (D[5]))) | (T[4] & (D[3] | D[4] )) | (D[6]&T[6]) | (D[7]&T[3]);
//INTERRUPT CONTROL
assign setR = ( ((~T[0]) & (~T[1]) & (~T[2])) & FGI & IEN);
assign resetR = R & T[2];
//REGISTER CONTROL
assign   readMEM  = ((~R) & T[1]) | (~D[7]&I&T[3]) | (T[4] & (D[0] | D[1] | D[2] | D[6])) ;
assign   writeMEM = (D[3]&T[4]) | (D[5]&T[4]) | (D[6]&T[6]) | (R & T[1]) ;
assign	resetIR  = 0;
assign	writeIR  = (~R) & T[1];
assign	incIR    = 0;
assign	resetDR  = 0;
assign	writeDR  = (T[4] & (D[0] | D[1] | D[2] | D[6]));
assign	incDR    = (D[6]&T[5]);
assign	resetTR	= 0;
assign	writeTR  = R & T[0];
assign	incTR    = 0;
assign	resetAR  = R & T[0]; 
assign	writeAR  = ((~R) & T[0]) | ((~R) & T[2]) | (~D[7]&I&T[3]);
assign	incAR    = D[5]&T[4]; 
assign	resetPC  = (R & T[1]);
assign	writePC  = (D[4]&T[4]) | (D[5]&T[5]);
assign	incPC    = ((~R) & T[1]) | (R & T[2]) | (D[6]&T[6]&(DR==0)) | ((D[7]&~I&T[3]) & ((IR[4]& (~N)) | (IR[3]&N) | (IR[2] && Z) | (IR[1]&(~CO)) ));
assign	resetAC  = ((D[7]&~I&T[3]) & IR[11] );
assign	writeAC  = ((D[7]&~I&T[3]) & (IR[9] | IR[7] | IR[6])) | (T[5] & (D[0] | D[1] | D[2]));
assign	incAC    = ((D[7]&~I&T[3]) & IR[5] );
assign	resetIEN = ((D[7]&I&T[3]) & IR[6] ) | (R & T[2]);
assign 	setIEN	= ((D[7]&I&T[3]) & IR[7] );
/// FOR BUS SELECT
assign	X[0] = 0;
assign	X[1] = (D[4]&T[4]) | (D[5]&T[5]);
assign	X[2] = ((~R) & T[0]) | (D[5]&T[4]) | (R & T[0]);
assign	X[3] = (D[6]&T[6]);
assign	X[4] = (D[3]&T[4]);
assign	X[5] = ((~R) & T[2]) ;
assign	X[6] = (R & T[1]);
assign	X[7] = ((~R) & T[1]) | ( (~D[7])&T[3]&I ) | ( (D[0] | D[1] | D[2] | D[6]) & T[4]);
/// FOR ALU SEL
assign 	AX[0] = 0;
assign	AX[1] = D[1] & T[5];
assign	AX[2] = D[0] & T[5];
assign	AX[3] = D[2] & T[5];
assign	AX[4] = ( D[7]&T[3]&~I ) & IR[9];
assign	AX[5] = ( D[7]&T[3]&~I ) & IR[7];
assign	AX[6] = ( D[7]&T[3]&~I ) & IR[6];	
assign	AX[7] = 0;

encod_8_to_3 myencBUS(X,SEL);
encod_8_to_3 myencALU(AX,alu_SEL);
decod_3_to_8_opcode mydec3(IR[14:12],D);
decod_4_to_16_time  mydec4(SC,T);

endmodule
