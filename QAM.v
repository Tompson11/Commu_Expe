module QAM(
	input [1:0] conv_in,
	input clk,
	input reset,
	input [8:0] GetSin,
	input [8:0] GetCos,
	output reg signed [8:0] modulation_out,
	output reg [6:0] trans_read
	);


reg [1:0] current_conv;
reg signed [5:0] symbol_count;

reg rest;
reg [4:0] rest_count;

always@(posedge clk or negedge reset) begin
	if(~reset) begin
		trans_read <= 7'd0;
		current_conv <= 2'd0;
		modulation_out <= 9'd0;
		symbol_count <= -6'd2;
		rest <= 1'b0;
		rest_count <= 5'd0;
	end
	else begin
		if(trans_read == 7'd0) begin // starting time of a symbol
			if(!rest) begin // Start Sending a new symbol if not resting
				current_conv <= conv_in;
				case(conv_in)
					2'b00,2'b01:modulation_out <= GetCos;
					2'b10,2'b11:modulation_out <= -GetCos;
				endcase
				
				if(symbol_count == 6'd31) begin  //Have a rest if having sent 32 symbols
					rest <= 1'b1;
					symbol_count <= 6'd0;
				end
				else symbol_count <= symbol_count + 6'd1;
				
			end
			else begin // if resting
				modulation_out <= 9'd0;
				if(rest_count == 5'd30) begin // Terminating the rest if having rest for 16 symbols 
					rest <= 1'b0;
					rest_count <= 5'd0;
					symbol_count <= 6'd1;
				end
				else rest_count <= rest_count + 5'd1;
			end
		end
		else begin
			if(!rest) case(current_conv)
				 2'b00: modulation_out <= -GetSin + GetCos;
				 2'b01: modulation_out <= GetSin + GetCos;
				 2'b11: modulation_out <= GetSin - GetCos;
				 2'b10: modulation_out <= -GetSin - GetCos;
			endcase
			else modulation_out <= 9'd0;
		end
			
		trans_read <= trans_read + 7'd1;
	end
end


endmodule
	
			