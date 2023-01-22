module encod_8_to_3(
input[7:0] X,
output reg[2:0] out_s	
);

always @(*)begin
	case(X)
		8'h01: out_s= 3'b000;
		8'h02: out_s= 3'b001;
		8'h04: out_s= 3'b010;
		8'h08: out_s= 3'b011;
		8'h10: out_s= 3'b100;
		8'h20: out_s= 3'b101;
		8'h40: out_s= 3'b110;
		8'h80: out_s= 3'b111;
	endcase
end


endmodule
