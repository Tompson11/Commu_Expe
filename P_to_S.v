module P_to_S(
	input [1:0] conv_out,
	input clk,
	input reset,
	output reg conv_S
);

reg status;
reg pre_conv1;


always@(posedge clk or negedge reset) begin
	if (~reset) status <= 0;
	
	else begin 
	if(~status) 
		begin
		conv_S <= conv_out[0];
		pre_conv1 <= conv_out[1];
		end
	else 
		conv_S <= pre_conv1;
	status <= ~status;
	end
end

endmodule
	