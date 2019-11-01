module transmitor(
	input sys_clk,
	input reset,
	output signed [2:0] I,
	output signed [2:0] Q
);

wire clk_1, clk_2;
wire m_out;
wire [1:0] conv_out;
wire conv_S;

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
	

endmodule