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


always@(posedge clk or negedge reset) begin
	if(~reset) begin
		trans_read <= 7'd0;
		current_conv <= 2'd0;
		modulation_out <= 9'd0;
	end
	else begin
		if(trans_read == 7'd0) begin
			current_conv <= conv_in;
			case(conv_in)
				2'b00,2'b01:modulation_out <= GetCos;
				2'b10,2'b11:modulation_out <= -GetCos;
			endcase
		end
		else case(current_conv)
				 2'b00: modulation_out <= -GetSin + GetCos;
				 2'b01: modulation_out <= GetSin + GetCos;
				 2'b11: modulation_out <= GetSin - GetCos;
				 2'b10: modulation_out <= -GetSin - GetCos;
			  endcase
			
		trans_read <= trans_read + 7'd1;
	end
end


endmodule
	
			