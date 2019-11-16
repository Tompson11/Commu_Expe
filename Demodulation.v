module Demodulation(
	input clk,
	input reset,
	input [8:0] GetSin,
	input [8:0] GetCos,
	input [8:0] channel_out,
	input [3:0] BER,
	output reg [1:0] demodulation_out,
	output reg [6:0] recev_read,
	output reg trigger_decode
	);

reg [19:0] sum_I;
reg [19:0] sum_Q;
reg [1:0] sample_count;

reg [4:0] symbol_count;
reg [3:0] error_count;

reg head_detected;

	
always@(posedge clk or negedge reset) begin
	if(!reset) begin
		sum_I <= 20'd0;
		sum_Q <= 20'd0;
		recev_read <= 7'd0;
		trigger_decode <= 1'b0;
		head_detected <= 1'b0;
		sample_count <= 2'b00;
		symbol_count <= 5'd0;
		error_count <= 4'd1;
	end
	else begin
		if(!head_detected) begin
			if( (channel_out[8]==1'b0 && channel_out[7:0]>8'd60) || (channel_out[8]==1'b1 && channel_out[7:0]<8'd196)) begin
				head_detected <= 1'b1;
				recev_read <= 7'd1;
				sample_count <= 2'b00;
				symbol_count <= 5'd0;
				sum_I <= 20'd0;
				sum_Q <= 20'd100 * {{11{channel_out[8]}},channel_out};
			end
		end
		else begin
			if(sample_count==2'b11) begin
				if(recev_read == 7'd32) begin //Starting time of a symbol
					trigger_decode <= 1'b1;
					
					if(BER == 4'd0 || error_count != BER) begin//if no bit error or current demodulation result is free of error
						case({sum_I[19],sum_Q[19]})
							2'b00 : demodulation_out <= 2'b01;
							2'b01 : demodulation_out <= 2'b11;
							2'b10 : demodulation_out <= 2'b00;
							2'b11 : demodulation_out <= 2'b10;
						endcase
						error_count <= error_count + 4'd1;
					end
					else begin // generate a bit error
						case({sum_I[19],sum_Q[19]})
							2'b00 : demodulation_out <= 2'b11;
							2'b01 : demodulation_out <= 2'b01;
							2'b10 : demodulation_out <= 2'b10;
							2'b11 : demodulation_out <= 2'b00;
						endcase
						error_count <= 4'd1;
					end
						
					
					recev_read <= 7'd1;
					sum_I <= 20'd0;
					sum_Q <= 20'd100 * {{11{channel_out[8]}},channel_out};
					
					if(symbol_count == 5'd31) begin //Start to detect a new frame if the current frame is over
						head_detected<=1'b0; 
						trigger_decode <= 1'b0;
					end
					
					symbol_count <= symbol_count + 5'd1;
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

	
		
		