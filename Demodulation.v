module Demodulation(
	input clk,
	input reset,
	input [8:0] GetSin,
	input [8:0] GetCos,
	input [8:0] channel_out,
	output reg [1:0] demodulation_out,
	output reg [6:0] recev_read
	);

reg [19:0] sum_I;
reg [19:0] sum_Q;
reg head_detectd;
reg [1:0] sample_count;
	
always@(posedge clk or negedge reset) begin
	if(!reset) begin
		sum_I <= 20'd0;
		sum_Q <= 20'd0;
		recev_read <= 7'd0;
		head_detectd <= 1'b0;
		sample_count <= 2'b00;
	end
	else begin
		if(!head_detectd) begin
			if( (channel_out[8]==1'b0 && channel_out[7:0]>8'd60) || (channel_out[8]==1'b1 && channel_out[7:0]<8'd196)) begin
				head_detectd <= 1'b1;
				recev_read <= 7'd1;
				sample_count <= 2'b00;
				sum_I <= 20'd0;
				sum_Q <= 20'd100 * {{11{channel_out[8]}},channel_out};
			end
		end
		else begin
			if(sample_count==2'b11) begin
				if(recev_read == 7'd32) begin
					case({sum_I[19],sum_Q[19]})
						2'b00 : demodulation_out <= 2'b01;
						2'b01 : demodulation_out <= 2'b11;
						2'b10 : demodulation_out <= 2'b00;
						2'b11 : demodulation_out <= 2'b10;
					endcase
					recev_read <= 7'd1;
					sum_I <= 20'd0;
					sum_Q <= 20'd100 * {{11{channel_out[8]}},channel_out};
				end
				else begin 
					sum_I <= sum_I + {{11{channel_out[8]}},channel_out} * {{11{GetSin[8]}},GetSin};
					sum_Q <= sum_Q + {{11{channel_out[8]}},channel_out} * {{11{GetCos[8]}},GetCos};
					recev_read <= recev_read + 7'd1;
				end
			end
			
			sample_count <= sample_count + 2'b01;
		end
	end
end

endmodule

	
		
		