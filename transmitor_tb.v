`timescale 1ns/1ps

module transmitor_tb;
reg sys_clk,reset,init_tab;
wire [1:0] demodulation_out;
wire IsTransmit;
wire [3:0] BER;
wire decoder_out;

assign IsTransmit = 1;
assign BER = 4'b0000;

transmitor trans(.sys_clk(sys_clk),
					  .reset(reset),
					  .init_tab(init_tab),
					  .BER(BER),
					  .IsTransmit(IsTransmit),
					  .decoder_out(decoder_out)
					  );

initial begin
    sys_clk = 0;
	 reset = 1;
	 init_tab =0;
	 #1 init_tab = 1;
	 #1 init_tab = 0;
	 #1 reset=0;
	 #1 reset=1;
	 
end

always #5 sys_clk <= ~sys_clk;


endmodule
