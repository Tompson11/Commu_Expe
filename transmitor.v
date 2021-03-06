module transmitor(
	input IsTransmit,
	input [3:0] BER,
	input sys_clk,
	input reset,
	input init_tab,
	output decoder_out,
	output m_out2
);

wire clk_1, clk_2, clk_4, clk_32, clk_128;
wire [3:0] I,Q;
wire m_out;
wire [1:0] conv_out;
wire [8:0] modulation_out;
wire [8:0] channel_out;
wire [6:0] trans_read,recev_read;
wire [8:0] trans_sin,trans_cos,recev_sin,recev_cos;
wire [1:0] demodulation_out;
wire trigger_decode;


ClkGen Cg(
    .sys_clk	(	sys_clk	),
    .reset		(	reset		),
    .clk_1		(	clk_1		),
    .clk_2		(	clk_2		),
	 .clk_4     (  clk_4    ),
	 .clk_32    (  clk_32    ),
	 .clk_128   (  clk_128  )
  );
  
 M_sequence_gen M(
	.clk(clk_128),
	.m_out(m_out),
	.m_out2(m_out2),
	.reset(reset)
	);

conv_code Conv(
	.clk(clk_128),
	.reset(reset),
	.m_out(m_out),
	.conv_out(conv_out)
	);

Tab tab( 
	.trans_read(trans_read),
	.recev_read(recev_read),
	.init_tab(init_tab),
	.trans_sin(trans_sin),
	.trans_cos(trans_cos),
	.recev_sin(recev_sin),
	.recev_cos(recev_cos)
);

QAM QAM(
	.clk(clk_1),
	.reset(reset),
	.conv_in(conv_out),
	.GetSin(trans_sin),
	.GetCos(trans_cos),
	.modulation_out(modulation_out),
	.trans_read(trans_read)
	);

Channel channel(
	.clk(clk_1),
	.reset(reset),
	.IsTransmit(IsTransmit),
	.channel_in(modulation_out),
	.channel_out(channel_out)
	);

Demodulation demodulation(
	.clk(clk_1),
	.reset(reset),
	.BER(BER),
	.GetSin(recev_sin),
	.GetCos(recev_cos),
	.channel_out(channel_out),
	.demodulation_out(demodulation_out),
	.recev_read(recev_read),
	.trigger_decode(trigger_decode)
);

inv_conv decoder(
	.clk(~clk_128),
	.reset(reset),
	.trigger_decode(trigger_decode),
	.inv_QAM_out(demodulation_out),
	.inv_conv_out(decoder_out)
);

endmodule