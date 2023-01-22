module decod_4_to_16_time(
input [3:0] in,
output reg[15:0] out
);

always @(in)begin
	out = 4'b0000;
	case(in)
	0:  out[0] = 1;
	1:  out[1] = 1;
	2:  out[2] = 1;
	3:  out[3] = 1;
	4:  out[4] = 1;
	5:  out[5] = 1;
	6:  out[6] = 1;
	7:  out[7] = 1;
	8:  out[8] = 1;
	9:  out[9] = 1;
	10: out[10] = 1;
	11: out[11] = 1;
	12: out[12] = 1;
	13: out[13] = 1;
	14: out[14] = 1;
	15: out[15] = 1;
	endcase
end

endmodule

