module Channel(
	input clk,
	input reset,
	input IsTransmit,
	input [8:0] channel_in,
	output reg signed [8:0] channel_out
);


reg signed [4:0] noise; //00000 00001 00011 00111 01111 11111 


always@(posedge clk or negedge reset) begin
	if(!reset) begin
		noise <= 5'b00000;
		channel_out <= 9'd0;
		end
	else begin
		if(IsTransmit) channel_out <= channel_in + {{4{noise[4]}},noise};
		else channel_out <= {{4{noise[4]}},noise};
		
		noise[4] <= noise[3];
		noise[3] <= noise[2];
		noise[2] <= noise[1];
		noise[1] <= noise[0];
		noise[0] <= !noise[4];
	end
end

endmodule

		
		
		
		
	

