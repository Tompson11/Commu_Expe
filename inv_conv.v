module inv_conv(
	input clk,
	input reset,
	input trigger_decode,
	input [1:0] inv_QAM_out,
	output reg inv_conv_out
	);

reg [61:0] conv_path1,conv_path2,conv_path3,conv_path4;
reg [61:0] temp_path1,temp_path2,temp_path3,temp_path4;
reg [7:0] count,count1;
reg [9:0] offset [0:11];
reg [3:0] i;
reg [1:0] j,k;
reg [63:0] count2;
reg [30:0] inv_conv_out1,inv_conv_out2;
reg m;

always@(posedge clk or negedge reset) begin
if (~reset) begin
count2 <= 0;
end
else begin
count2 <=count2+1;
end
end

always@(posedge clk or negedge reset) begin
if(trigger_decode==1) begin
m <= 1;
end
else begin
m <= 0;
end
end
	
always@(posedge clk or negedge reset) begin
	if (~reset) begin
		conv_path1 <= 0;
		conv_path2 <= 0;
		conv_path3 <= 0;
		conv_path4 <= 0;
		temp_path1 <= 0;
		temp_path2 <= 0;
		temp_path3 <= 0;
		temp_path4 <= 0;
		count <= 0;
		offset[0]=0;
		offset[1]=512;
		offset[2]=512;
		offset[3]=512;
		inv_conv_out <= 0;
		inv_conv_out1 <= 0;
		inv_conv_out2 <= 0;
		j <= 0;
	end
	else begin
   if(m) begin	
		inv_conv_out <= inv_conv_out2[30-count];
		if(offset[4]<offset[5]) begin
			offset[0] <= offset[4];
			conv_path1[2*count+1 -:2] <= 2'b00;
		end
		else begin
			offset[0] <= offset[5];
			conv_path1[2*count+1 -:2] <= 2'b01;
		end
		
		if(offset[6]<offset[7]) begin
			offset[1] <= offset[6];
			conv_path2[2*count+1 -:2] <= 2'b10;
		end
		else begin
			offset[1] <= offset[7];
			conv_path2[2*count+1 -:2] <= 2'b11;
		end
		
		if(offset[8]<offset[9]) begin
			offset[2] <= offset[8];
			conv_path3[2*count+1 -:2] <= 2'b00;
		end
		else begin
			offset[2] <= offset[9];
			conv_path3[2*count+1 -:2] <= 2'b01;
		end
		
		if(offset[10]<offset[11]) begin
			offset[3] <= offset[10];
			conv_path4[2*count+1 -:2] <= 2'b10;
		end
		else begin
			offset[3] <= offset[11];
			conv_path4[2*count+1 -:2] <= 2'b11;
		end
		
		case({k,j})
			4'b0000: inv_conv_out1[count] <= 0;
			4'b0010: inv_conv_out1[count] <= 1;
			4'b0100: inv_conv_out1[count] <= 0;
			4'b0110: inv_conv_out1[count] <= 1;
			4'b1001: inv_conv_out1[count] <= 0;
			4'b1011: inv_conv_out1[count] <= 1;
			4'b1101: inv_conv_out1[count] <= 0;
			4'b1111: inv_conv_out1[count] <= 1;
		endcase
		
		if(count==0) begin
		
		offset[0] <= 0;
		offset[1] <= 512;
		offset[2] <= 512;
		offset[3] <= 512;
		
			j <= 0;
			if(offset[0]>offset[1]) begin
				j <= 1;
				if(offset[1]>offset[2]) begin
					j <= 2;
					if(offset[2]>offset[3]) begin
						j <= 3;
					end
				end
				else begin
					if(offset[1]>offset[3]) begin
						j <= 3;
					end
				end
			end
			else begin
				if(offset[0]>offset[2]) begin
					j <= 2;
					if(offset[2]>offset[3]) begin
						j <= 3;
					end
				end
				else begin
					if(offset[0]>offset[3]) begin
						j <= 3;
					end
				end
			end
			
			temp_path1 <= conv_path1;
			temp_path2 <= conv_path2;
			temp_path3 <= conv_path3;
			temp_path4 <= conv_path4;
			
			inv_conv_out2 <= inv_conv_out1;
			
		end
		else begin
		j <= k;
		end
		if(count == 30) begin
			count <= 0;
		end
		else begin
			count <= count+1;
		end
	end
	end
end

always@(negedge clk or negedge reset) begin
if(~reset) begin
offset[4]=0;
		offset[8]=0;
		for(i=5;i<8;i=i+1) begin
			offset[i] <= 512;
		end
		for(i=9;i<12;i=i+1) begin
			offset[i] <= 512;
		end
end
else begin
if(m) begin
if(count==0) begin
offset[4]=0;
		offset[8]=0;
		for(i=5;i<8;i=i+1) begin
			offset[i] <= 512;
		end
		for(i=9;i<12;i=i+1) begin
			offset[i] <= 512;
		end
end
		offset[4] <= offset[0]+{1'b0,inv_QAM_out[0]^0}+{1'b0,inv_QAM_out[1]^0};
		offset[5] <= offset[1]+{1'b0,inv_QAM_out[0]^1}+{1'b0,inv_QAM_out[1]^1};
		offset[6] <= offset[2]+{1'b0,inv_QAM_out[0]^1}+{1'b0,inv_QAM_out[1]^0};
		offset[7] <= offset[3]+{1'b0,inv_QAM_out[0]^0}+{1'b0,inv_QAM_out[1]^1};
		offset[8] <= offset[0]+{1'b0,inv_QAM_out[0]^1}+{1'b0,inv_QAM_out[1]^1};
		offset[9] <= offset[1]+{1'b0,inv_QAM_out[0]^0}+{1'b0,inv_QAM_out[1]^0};
		offset[10] <= offset[2]+{1'b0,inv_QAM_out[0]^0}+{1'b0,inv_QAM_out[1]^1};
		offset[11] <= offset[3]+{1'b0,inv_QAM_out[0]^1}+{1'b0,inv_QAM_out[1]^0};
		
		count1 <= count;
		if(count1 == 0) begin
			case(j)
			2'b00: k <= temp_path1[61:60];
			2'b01: k <= temp_path2[61:60];
			2'b10: k <= temp_path3[61:60];
			2'b11: k <= temp_path4[61:60];
			endcase
		end
		else begin
			case(k)
				2'b00: k <= temp_path1[61-2*count1 -:2];
				2'b01: k <= temp_path2[61-2*count1 -:2];
				2'b10: k <= temp_path3[61-2*count1 -:2];
				2'b11: k <= temp_path4[61-2*count1 -:2];
			endcase
		end
		end
end
end

endmodule