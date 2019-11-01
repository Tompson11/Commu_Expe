`timescale 1ns/1ps

module M_sequence_gen_tb;
reg clk,reset;
wire m_out;

M_sequence_gen Mtest(.clk(clk),.m_out(m_out),.reset(reset));

initial begin
    clk = 0;
	 reset = 1;
	 #1 reset=0;
	 #1 reset=1;
end

always #5 clk <= ~clk;


endmodule
