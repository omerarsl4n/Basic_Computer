module memory_unit(
	  input  clk, read,write,
	  input	[15:0] W_DATA,
	  input	[11:0] IN_ADR,
	  output reg [15:0] R_DATA
    );
reg [15:0]mem[4096];

initial begin
mem[1]   = 16'h4064;	//BUN to start
mem[100] = 16'h7800;	//CLA
mem[101] = 16'h20C8;	//LDA	200dec
mem[102] = 16'h10C9;	//ADD	201dec
mem[103] = 16'h80CA; 	//AND I	202dec
mem[104] = 16'h7200; 	//CMA
mem[105] = 16'h3190; 	//STA	400dec
mem[106] = 16'h6190; 	//ISZ	400dec
mem[107] = 16'h51F4; 	//BSA	500dec
mem[108] = 16'h7020; 	//INC

mem[109] = 16'hF080;	//ION, TO TEST INTERRUPT CYCLE
mem[110] = 16'h7020; 	//INC, DUMMY INSTR FOR SETTING FGI AND R




mem[200] = 16'h1100;	//DATA
mem[201] = 16'h0011; 	//DATA
mem[202] = 16'h012C; 	//decimal 300
mem[300] = 16'h1110;	//DATA

mem[501] = 16'hA320;	//LDA I	800dec
mem[502] = 16'h7040;	//CIL
mem[503] = 16'hC1F4;	//BUN I	500dec

mem[800] = 16'h0190;	//DATA 	400dec
end
always @(*)begin
		if(read) R_DATA = mem[IN_ADR];
end

always @(posedge clk)begin
	   if(write) mem[IN_ADR] = W_DATA;
end

endmodule


	 