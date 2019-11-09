module QAM(
	input conv_S,
	input clk,
	input reset,
	output reg signed [3:0] I,
	output reg signed [3:0] Q
	);

reg sample_clk1;
reg sample_clk0;
reg count;
reg [1:0] digit;

always@(posedge clk or negedge reset) begin
	if(~reset) begin
		I <= 3'd0;
		Q <= 3'd0;
		sample_clk0 <= 0;
		sample_clk1 <= 0;
		count <= 0;
		digit <= 2'b00;
	end
	else begin
		if (~count) begin
			case(digit)
				2'b00: begin
					I <= -4'd4;
					Q <= 4'd4; end
				2'b01: begin
					I <= 4'd4;
					Q <= 4'd4; end
				2'b11: begin
					I <= 4'd4;
					Q <= -4'd4; end
				2'b10: begin
					I <= -4'd4; 
					Q <= -4'd4; end
			endcase
			sample_clk1 <= ~sample_clk1;
			sample_clk0 <= 0;
		end
		else begin
			sample_clk0 <= ~sample_clk0;
			sample_clk1 <= 0;
		end
		
		count <= ~count;
	end
end

always@(posedge sample_clk1) begin
	digit[1] <= conv_S;
end

always@(posedge sample_clk0) begin
	digit[0] <= conv_S;
end

endmodule
	
			