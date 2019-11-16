module conv_code(
	input clk,
	input m_out,
	input reset,
	output reg [1:0] conv_out
	);

reg [2:0] D;
reg signed [5:0] reset_count;

always@(posedge clk or negedge reset) begin
	if (~reset) begin
		D <= 3'b000;
		reset_count <= -6'd1;
	end
	else begin
		if(reset_count == 6'd30) begin
			D[2] <= 1'b0;
			D[1] <= 1'b0;
			D[0] <= m_out;
			reset_count <= 6'd0;
		end
		else begin
			D[2] <= D[1];
			D[1] <= D[0];
			D[0] <= m_out;
			reset_count <= reset_count + 6'd1;
		end
		
		conv_out[0] <= ^(3'b111 & D);
		conv_out[1] <= ^(3'b101 & D);
	end
end

endmodule
	


