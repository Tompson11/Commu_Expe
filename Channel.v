module Channel(
	input clk,
	input reset,
	input has_error,
	input [3:0] I_in,
	input [3:0] Q_in,
	output reg signed [3:0] I_out,
	output reg signed [3:0] Q_out
);


reg signed [3:0] noise_I; //000 001 011 111 110 100 000
reg signed [3:0] noise_Q; //110 100 000 001 011 111 110

always@(posedge clk or negedge reset) begin
	if(!reset) begin
		noise_I <= 4'b0000;
		noise_Q <= 4'b1110;
		end
	else begin
		if(noise_I[2:0] == 3'b100 && has_error) I_out <= -I_in;
		else I_out <= I_in + noise_I;
		
		if(noise_Q[2:0] == 3'b100 && has_error) Q_out <= -Q_in;
		else Q_out <= Q_in + noise_Q;
		
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

		
		
		
		
	

