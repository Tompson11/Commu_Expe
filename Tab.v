module Tab(
	input [6:0] trans_read,
	input [6:0] recev_read,
	input init_tab,
	output reg signed [8:0] trans_sin,
	output reg signed [8:0] trans_cos,
	output reg signed [8:0] recev_sin,
	output reg signed [8:0] recev_cos
);

reg signed [8:0] sin_tab[127:0];
reg signed [8:0] cos_tab[127:0];

always @(posedge init_tab) begin
sin_tab[0] <= 9'd0;
sin_tab[1] <= 9'd4;
sin_tab[2] <= 9'd9;
sin_tab[3] <= 9'd14;
sin_tab[4] <= 9'd19;
sin_tab[5] <= 9'd24;
sin_tab[6] <= 9'd29;
sin_tab[7] <= 9'd33;
sin_tab[8] <= 9'd38;
sin_tab[9] <= 9'd42;
sin_tab[10] <= 9'd47;
sin_tab[11] <= 9'd51;
sin_tab[12] <= 9'd55;
sin_tab[13] <= 9'd59;
sin_tab[14] <= 9'd63;
sin_tab[15] <= 9'd67;
sin_tab[16] <= 9'd70;
sin_tab[17] <= 9'd74;
sin_tab[18] <= 9'd77;
sin_tab[19] <= 9'd80;
sin_tab[20] <= 9'd83;
sin_tab[21] <= 9'd85;
sin_tab[22] <= 9'd88;
sin_tab[23] <= 9'd90;
sin_tab[24] <= 9'd92;
sin_tab[25] <= 9'd94;
sin_tab[26] <= 9'd95;
sin_tab[27] <= 9'd97;
sin_tab[28] <= 9'd98;
sin_tab[29] <= 9'd98;
sin_tab[30] <= 9'd99;
sin_tab[31] <= 9'd99;
sin_tab[32] <= 9'd100;
sin_tab[33] <= 9'd99;
sin_tab[34] <= 9'd99;
sin_tab[35] <= 9'd98;
sin_tab[36] <= 9'd98;
sin_tab[37] <= 9'd97;
sin_tab[38] <= 9'd95;
sin_tab[39] <= 9'd94;
sin_tab[40] <= 9'd92;
sin_tab[41] <= 9'd90;
sin_tab[42] <= 9'd88;
sin_tab[43] <= 9'd85;
sin_tab[44] <= 9'd83;
sin_tab[45] <= 9'd80;
sin_tab[46] <= 9'd77;
sin_tab[47] <= 9'd74;
sin_tab[48] <= 9'd70;
sin_tab[49] <= 9'd67;
sin_tab[50] <= 9'd63;
sin_tab[51] <= 9'd59;
sin_tab[52] <= 9'd55;
sin_tab[53] <= 9'd51;
sin_tab[54] <= 9'd47;
sin_tab[55] <= 9'd42;
sin_tab[56] <= 9'd38;
sin_tab[57] <= 9'd33;
sin_tab[58] <= 9'd29;
sin_tab[59] <= 9'd24;
sin_tab[60] <= 9'd19;
sin_tab[61] <= 9'd14;
sin_tab[62] <= 9'd9;
sin_tab[63] <= 9'd4;
sin_tab[64] <= 9'd0;
sin_tab[65] <= -9'd5;
sin_tab[66] <= -9'd10;
sin_tab[67] <= -9'd15;
sin_tab[68] <= -9'd20;
sin_tab[69] <= -9'd25;
sin_tab[70] <= -9'd30;
sin_tab[71] <= -9'd34;
sin_tab[72] <= -9'd39;
sin_tab[73] <= -9'd43;
sin_tab[74] <= -9'd48;
sin_tab[75] <= -9'd52;
sin_tab[76] <= -9'd56;
sin_tab[77] <= -9'd60;
sin_tab[78] <= -9'd64;
sin_tab[79] <= -9'd68;
sin_tab[80] <= -9'd71;
sin_tab[81] <= -9'd75;
sin_tab[82] <= -9'd78;
sin_tab[83] <= -9'd81;
sin_tab[84] <= -9'd84;
sin_tab[85] <= -9'd86;
sin_tab[86] <= -9'd89;
sin_tab[87] <= -9'd91;
sin_tab[88] <= -9'd93;
sin_tab[89] <= -9'd95;
sin_tab[90] <= -9'd96;
sin_tab[91] <= -9'd98;
sin_tab[92] <= -9'd99;
sin_tab[93] <= -9'd99;
sin_tab[94] <= -9'd100;
sin_tab[95] <= -9'd100;
sin_tab[96] <= -9'd100;
sin_tab[97] <= -9'd100;
sin_tab[98] <= -9'd100;
sin_tab[99] <= -9'd99;
sin_tab[100] <= -9'd99;
sin_tab[101] <= -9'd98;
sin_tab[102] <= -9'd96;
sin_tab[103] <= -9'd95;
sin_tab[104] <= -9'd93;
sin_tab[105] <= -9'd91;
sin_tab[106] <= -9'd89;
sin_tab[107] <= -9'd86;
sin_tab[108] <= -9'd84;
sin_tab[109] <= -9'd81;
sin_tab[110] <= -9'd78;
sin_tab[111] <= -9'd75;
sin_tab[112] <= -9'd71;
sin_tab[113] <= -9'd68;
sin_tab[114] <= -9'd64;
sin_tab[115] <= -9'd60;
sin_tab[116] <= -9'd56;
sin_tab[117] <= -9'd52;
sin_tab[118] <= -9'd48;
sin_tab[119] <= -9'd43;
sin_tab[120] <= -9'd39;
sin_tab[121] <= -9'd34;
sin_tab[122] <= -9'd30;
sin_tab[123] <= -9'd25;
sin_tab[124] <= -9'd20;
sin_tab[125] <= -9'd15;
sin_tab[126] <= -9'd10;
sin_tab[127] <= -9'd5;

cos_tab[0] <= 9'd100;
cos_tab[1] <= 9'd99;
cos_tab[2] <= 9'd99;
cos_tab[3] <= 9'd98;
cos_tab[4] <= 9'd98;
cos_tab[5] <= 9'd97;
cos_tab[6] <= 9'd95;
cos_tab[7] <= 9'd94;
cos_tab[8] <= 9'd92;
cos_tab[9] <= 9'd90;
cos_tab[10] <= 9'd88;
cos_tab[11] <= 9'd85;
cos_tab[12] <= 9'd83;
cos_tab[13] <= 9'd80;
cos_tab[14] <= 9'd77;
cos_tab[15] <= 9'd74;
cos_tab[16] <= 9'd70;
cos_tab[17] <= 9'd67;
cos_tab[18] <= 9'd63;
cos_tab[19] <= 9'd59;
cos_tab[20] <= 9'd55;
cos_tab[21] <= 9'd51;
cos_tab[22] <= 9'd47;
cos_tab[23] <= 9'd42;
cos_tab[24] <= 9'd38;
cos_tab[25] <= 9'd33;
cos_tab[26] <= 9'd29;
cos_tab[27] <= 9'd24;
cos_tab[28] <= 9'd19;
cos_tab[29] <= 9'd14;
cos_tab[30] <= 9'd9;
cos_tab[31] <= 9'd4;
cos_tab[32] <= 9'd0;
cos_tab[33] <= -9'd5;
cos_tab[34] <= -9'd10;
cos_tab[35] <= -9'd15;
cos_tab[36] <= -9'd20;
cos_tab[37] <= -9'd25;
cos_tab[38] <= -9'd30;
cos_tab[39] <= -9'd34;
cos_tab[40] <= -9'd39;
cos_tab[41] <= -9'd43;
cos_tab[42] <= -9'd48;
cos_tab[43] <= -9'd52;
cos_tab[44] <= -9'd56;
cos_tab[45] <= -9'd60;
cos_tab[46] <= -9'd64;
cos_tab[47] <= -9'd68;
cos_tab[48] <= -9'd71;
cos_tab[49] <= -9'd75;
cos_tab[50] <= -9'd78;
cos_tab[51] <= -9'd81;
cos_tab[52] <= -9'd84;
cos_tab[53] <= -9'd86;
cos_tab[54] <= -9'd89;
cos_tab[55] <= -9'd91;
cos_tab[56] <= -9'd93;
cos_tab[57] <= -9'd95;
cos_tab[58] <= -9'd96;
cos_tab[59] <= -9'd98;
cos_tab[60] <= -9'd99;
cos_tab[61] <= -9'd99;
cos_tab[62] <= -9'd100;
cos_tab[63] <= -9'd100;
cos_tab[64] <= -9'd100;
cos_tab[65] <= -9'd100;
cos_tab[66] <= -9'd100;
cos_tab[67] <= -9'd99;
cos_tab[68] <= -9'd99;
cos_tab[69] <= -9'd98;
cos_tab[70] <= -9'd96;
cos_tab[71] <= -9'd95;
cos_tab[72] <= -9'd93;
cos_tab[73] <= -9'd91;
cos_tab[74] <= -9'd89;
cos_tab[75] <= -9'd86;
cos_tab[76] <= -9'd84;
cos_tab[77] <= -9'd81;
cos_tab[78] <= -9'd78;
cos_tab[79] <= -9'd75;
cos_tab[80] <= -9'd71;
cos_tab[81] <= -9'd68;
cos_tab[82] <= -9'd64;
cos_tab[83] <= -9'd60;
cos_tab[84] <= -9'd56;
cos_tab[85] <= -9'd52;
cos_tab[86] <= -9'd48;
cos_tab[87] <= -9'd43;
cos_tab[88] <= -9'd39;
cos_tab[89] <= -9'd34;
cos_tab[90] <= -9'd30;
cos_tab[91] <= -9'd25;
cos_tab[92] <= -9'd20;
cos_tab[93] <= -9'd15;
cos_tab[94] <= -9'd10;
cos_tab[95] <= -9'd5;
cos_tab[96] <= -9'd1;
cos_tab[97] <= 9'd4;
cos_tab[98] <= 9'd9;
cos_tab[99] <= 9'd14;
cos_tab[100] <= 9'd19;
cos_tab[101] <= 9'd24;
cos_tab[102] <= 9'd29;
cos_tab[103] <= 9'd33;
cos_tab[104] <= 9'd38;
cos_tab[105] <= 9'd42;
cos_tab[106] <= 9'd47;
cos_tab[107] <= 9'd51;
cos_tab[108] <= 9'd55;
cos_tab[109] <= 9'd59;
cos_tab[110] <= 9'd63;
cos_tab[111] <= 9'd67;
cos_tab[112] <= 9'd70;
cos_tab[113] <= 9'd74;
cos_tab[114] <= 9'd77;
cos_tab[115] <= 9'd80;
cos_tab[116] <= 9'd83;
cos_tab[117] <= 9'd85;
cos_tab[118] <= 9'd88;
cos_tab[119] <= 9'd90;
cos_tab[120] <= 9'd92;
cos_tab[121] <= 9'd94;
cos_tab[122] <= 9'd95;
cos_tab[123] <= 9'd97;
cos_tab[124] <= 9'd98;
cos_tab[125] <= 9'd98;
cos_tab[126] <= 9'd99;
cos_tab[127] <= 9'd99;
end

always@(*) begin
	trans_sin <= sin_tab[trans_read];
	trans_cos <= cos_tab[trans_read];
end

always@(*) begin
	recev_sin <= sin_tab[recev_read << 2];
	recev_cos <= cos_tab[recev_read << 2];
end

endmodule