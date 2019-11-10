module Synchronizer(
	input clk,
	input reset,
	input [3:0] I_receive,
	input [3:0] Q_receive,
	input IsDecoding,
	output reg [1:0] conv_out,
	output reg head_detected
);

reg [1:0] Cache[3:0];
reg [4:0] count1;

always@(posedge clk or negedge reset) begin
	if(!reset) begin
		Cache <= 0;
		count1 <= 5'd0;
		head_detected <= 1'b0;
	end
	else begin
		if(count1>=4'd8 && !IsDecoding) head_detected <= 1'b1; //When detecting the frame head, setting head_detected=1 to trigger the decoding;
		else head_detected <= 1'b0; //reset the head_detected;
		
		
		//inv_QAM
		if(I_receive >=4'd0) begin
			if(Q_receive >= 4'd0) begin
				Cache[0] <= ***; //result of inv_QAM for current input
				count1 <= count1 + *** - conv_out; // box filter
			end
			else begin
			
			
			end
		end
		else begin
			if(Q_receive >= 4'd0) begin
				Cache[0] <= ***;
				count1 <= count1 + *** - Cache[5];
			end
			else begin
			
			
			end
		end
		
		Cache[1] <= Cache[0];
		Cache[2] <= Cache[1];
		Cache[3] <= Cache[2];
		conv_out <= Cache[3];
	end
end
		
			
			
		
		

