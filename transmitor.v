module transmitor(
	input IsTransmit,
	input has_error,
	input sys_clk,
	input reset,
	input init_tab,
	output [8:0] channel_out
);

wire clk_1, clk_2, clk_128;
wire [3:0] I,Q;
wire m_out;
wire [1:0] conv_out;
wire [8:0] modulation_out;

assign has_error = 1;

ClkGen Cg(
    .sys_clk	(	sys_clk	),
    .reset		(	reset		),
    .clk_1		(	clk_1		),
    .clk_2		(	clk_2		),
	 .clk_128   (  clk_128  )
  );
  
 M_sequence_gen M(
	.clk(clk_128),
	.m_out(m_out),
	.reset(reset)
	);

conv_code Conv(
	.clk(clk_128),
	.reset(reset),
	.m_out(m_out),
	.conv_out(conv_out)
	);

QAM QAM(
	.clk(clk_1),
	.reset(reset),
	.init_tab(init_tab),
	.conv_in(conv_out),
	.modulation_out(modulation_out)
	);

Channel channel(
	.clk(clk_1),
	.reset(reset),
	.IsTransmit(IsTransmit),
	.channel_in(modulation_out),
	.channel_out(channel_out)
	);
	
endmodule