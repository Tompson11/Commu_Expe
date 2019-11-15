module M_sequence_gen(
input clk,
input reset,
output reg m_out,
output reg m_out2
);

reg [3:0] D;


always@(posedge clk or negedge reset)
begin
	if (~reset) begin
		D <= 4'b0001;
		m_out <= 0;
		m_out2 <= 0;
	end
	else begin
		m_out <= D[3];
		m_out2 <= D[3];
		D[3] <= D[2];
		D[2] <= D[1];
		D[1] <= D[0];
		D[0] <= ^(5'b10100 & {m_out,D});
	end
	
end

endmodule

	
	