module conv_code(
	input clk,
	input m_out,
	input reset,
	output reg [1:0] conv_out
	);

reg [2:0] D;

always@(posedge clk or negedge reset) begin
	if (~reset) D <= 3'b000;
	else begin
		D[2] <= D[1];
		D[1] <= D[0];
		D[0] <= m_out;
		
		conv_out[0] <= ^(3'b111 & D);
		conv_out[1] <= ^(3'b101 & D);
	end
end

endmodule
	


