module Register_sync_rw #(parameter WIDTH=4)(
	  input  clk, reset,write, increment,
	  input	[WIDTH-1:0] DATA,
	  output reg [WIDTH-1:0] A
    );
	 
always@(posedge clk) begin
	case(reset)
		1'b0:if(write) A<=DATA;
			  else begin
					if(increment)A<=A+1;		//INCrement
					else A <= A; //Retain
			  end
		1'b1: A<=0;		//Reset
		default:A<=0;
	endcase
end
	 
endmodule	 