module W_bit_bus #(parameter WIDTH=16)(
	  input	[WIDTH-1:0] DATA0, DATA1, DATA2, DATA3, DATA4, DATA5, DATA6, DATA7,
	  input	[2:0]	SEL,
	  output reg [WIDTH-1:0] Bus_content
    );
	 

always @(*)begin
	case(SEL)
		3'b000:	Bus_content = DATA0;
		3'b001:  Bus_content = DATA1;
		3'b010:  Bus_content = DATA2;
		3'b011:  Bus_content = DATA3;
		3'b100:	Bus_content = DATA4;
		3'b101:	Bus_content = DATA5;
		3'b110:	Bus_content = DATA6;
		3'b111:	Bus_content = DATA7;
	endcase
end


endmodule

