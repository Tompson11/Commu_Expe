module Channel(
	input clk,
	input reset,
	input IsTransmit,
	input [8:0] channel_in,
	output reg signed [8:0] channel_out
);


reg signed [4:0] noise; //000 001 011 111 110 100 000
reg [1:0] noise_count;  

reg rest;
reg [3:0] rest_count;


always@(posedge clk or negedge reset) begin
	if(!reset) begin
		noise <= 5'b00000;
		noise_count <= 2'b00;
		rest <= 1'b0;
		rest_count <= 4'b0;
		end
	else begin
		if (noise_count == 2'b11) begin
			if(IsTransmit && !rest) channel_out <= channel_in + noise;
			else channel_out <= noise;
		end
		
		noise_count <= noise_count + 2'd1;
		
		noise[4] <= noise[2];
		noise[3] <= noise[2];
		noise[2] <= noise[1];
		noise[1] <= noise[0];
		noise[0] <= !noise[3];
	end
end

endmodule

		
		
		
		
	

