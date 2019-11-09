module Channel(
	input clk,
	input reset,
	input has_error,
	input IsTransmit,
	input [3:0] I_in,
	input [3:0] Q_in,
	output reg signed [3:0] I_out,
	output reg signed [3:0] Q_out
);


reg signed [3:0] noise_I; //000 001 011 111 110 100 000
reg signed [3:0] noise_Q; //110 100 000 001 011 111 110

reg [3:0] head_count;
reg [4:0] frame_count;

reg rest;
reg [3:0] rest_count;


always@(posedge clk or negedge reset) begin
	if(!reset) begin
		noise_I <= 4'b0000;
		noise_Q <= 4'b1110;
		head_count <= 4'd0;
		frame_count <= 5'd0;
		rest <= 1'b0;
		rest_count <= 4'b0;
		end
	else begin
		if(IsTransmit && !rest) begin
			// path-I
			if(noise_I[2:0] == 3'b100) begin //code_error,if any,is created when noise_I[2:0] == 3'b100
				if(has_error) begin // if code_error is allowed
					if(head_count>4'd4) I_out <= -I_in; //sending frame data
					else I_out <= -4'b0100; //sending head data					
				end
				else begin// if code_error is not allowed
					if(head_count>4'd4) I_out <= I_in + 4'b0010;
					else I_out <= 4'b0110 + 4'b0010;
				end
			end
			
			else begin
				if(head_count>4'd4) I_out <= I_in + noise_I;
				else I_out <= 4'b0100 + noise_I;
			end
			
			// path-Q
			if(noise_Q[2:0] == 3'b100) begin //code_error,if any,is created when noise_Q[2:0] == 3'b100
				if(has_error) begin // if code_error is allowed
					if(head_count>4'd4) Q_out <= -Q_in; //sending frame data
					else Q_out <= 4'b0100; //sending head data					
				end
				else begin// if code_error is not allowed
					if(head_count>4'd4) Q_out <= Q_in + 4'b0010;
					else Q_out <= -4'b0100 + 4'b0010;
				end
			end
			
			else begin
				if(head_count>4'd4) Q_out <= Q_in  + noise_Q;
				else Q_out <= -4'b0100 + noise_Q;
			end
			
			if(head_count<=4'd4) head_count <= head_count + 3'd1;
			else if(frame_count != 5'd31) frame_count <= frame_count + 5'd1;
			else begin
				frame_count <= 0;
				rest <= 1;
			end
		end
		
		else begin
			I_out <= noise_I;
			Q_out <= noise_Q;
			if(rest) begin
				if(rest_count == 4'd15) begin
					rest_count <= 4'd0;
					rest <= 1'b0;
					head_count <= 4'd0;
					frame_count <= 5'd0;
				end
				else rest_count <= rest_count + 4'd1;
			end
		end
		
		noise_I[3] <= noise_I[1];
		noise_I[2] <= noise_I[1];
		noise_I[1] <= noise_I[0];
		noise_I[0] <= !noise_I[2];
		
		noise_Q[3] <= noise_Q[1];
		noise_Q[2] <= noise_Q[1];
		noise_Q[1] <= noise_Q[0];
		noise_Q[0] <= !noise_Q[2];
	end
end

endmodule

		
		
		
		
	

