`timescale 1ns/1ps

module transmitor_tb;
reg sys_clk,reset;
wire out;
wire signed [2:0] Q;
wire signed [2:0] I;

transmitor trans(.sys_clk(sys_clk),.Q(Q),.I(I),.reset(reset));

initial begin
    sys_clk = 0;
	 reset = 1;
	 #1 reset=0;
	 #1 reset=1;
end

always #5 sys_clk <= ~sys_clk;


endmodule
