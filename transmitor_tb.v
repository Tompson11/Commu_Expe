`timescale 1ns/1ps

module transmitor_tb;
reg sys_clk,reset;
wire out;
wire signed [3:0] channel_outI;
wire signed [3:0] channel_outQ;
wire IsTransmit;
wire has_error;

assign IsTransmit = 1;
assign has_error = 1;

transmitor trans(.sys_clk(sys_clk),
					  .reset(reset),
					  .has_error(has_error),
					  .IsTransmit(IsTransmit),
					  .channel_outI(channel_outI),
					  .channel_outQ(channel_outQ)
					  );

initial begin
    sys_clk = 0;
	 reset = 1;
	 #1 reset=0;
	 #1 reset=1;
end

always #5 sys_clk <= ~sys_clk;


endmodule
