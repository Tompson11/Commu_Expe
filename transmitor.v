module transmitor(
	input IsTransmit,
	input has_error,
	input sys_clk,
	input reset,
	output signed [3:0] channel_outI,
	output signed [3:0] channel_outQ
);

wire clk_1, clk_2;
wire [3:0] I,Q;
wire m_out;
wire [1:0] conv_out;
wire conv_S;

assign has_error = 1;

ClkGen Cg(
    .sys_clk	(	sys_clk	),
    .reset		(	reset		),
    .clk_1		(	clk_1		),
    .clk_2		(	clk_2		)
  );
  
 M_sequence_gen M(
	.clk(clk_2),
	.m_out(m_out),
	.reset(reset)
	);

conv_code Conv(
	.clk(clk_2),
	.reset(reset),
	.m_out(m_out),
	.conv_out(conv_out)
	);

P_to_S P2S(
	.clk(clk_1),
	.conv_out(conv_out),
	.reset(reset),
	.conv_S(conv_S)
	);

QAM QAM(
	.clk(clk_1),
	.reset(reset),
	.conv_S(conv_S),
	.I(I),
	.Q(Q)
	);

Channel channel(
	.clk(clk_2),
	.reset(reset),
	.has_error(has_error),
	.IsTransmit(IsTransmit),
	.I_in(I),
	.Q_in(Q),
	.I_out(channel_outI),
	.Q_out(channel_outQ)
	);

endmodule