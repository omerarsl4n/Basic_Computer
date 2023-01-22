module ALU_implement #(parameter WIDTH=16)(
	  input  E,
	  input	[WIDTH-1:0] DATA_AC, DATA_DR,
	  input	[2:0]	SEL,
	  output reg [WIDTH-1:0] RES_OUT,
	  output reg CO,OVF,N,Z
    );
	 
always @(*)begin
	case(SEL)
		3'b001: {CO,RES_OUT} = DATA_AC + DATA_DR;		
		3'b010: RES_OUT = DATA_AC & DATA_DR;
		3'b011: RES_OUT = DATA_DR;
		3'b100: RES_OUT = ~DATA_AC;
		3'b101: begin
				  CO = DATA_AC[0];
				  RES_OUT = {E, DATA_AC[WIDTH-1:1]}; //SHR !!!!!!!!!!!!!!!!!!!!!!!!!!
				  end
		3'b110: begin
				  CO = DATA_AC[WIDTH-1];
				  RES_OUT = {DATA_AC[WIDTH-2:0],E};  //SHL   !!!!!!!!!!!!!!!!!!!!!!!!!!
				  end
	endcase
	
	if(RES_OUT[WIDTH-1]) N=1;
	else N=0;
	
	if(RES_OUT == 0) Z=1;
	else Z=0;
	
	if( (DATA_AC[WIDTH-2] == DATA_DR[WIDTH-2]) & (RES_OUT[WIDTH-1] != DATA_AC[WIDTH-1]) ) OVF = 1;
	else OVF = 0;	
end	

	
endmodule	 