module ClkGen(
  input 	sys_clk,
  input 	reset,
  output clk_1,
  output reg clk_2,
  output reg clk_128
  );
  
  assign clk_1 = sys_clk;
  reg [7:0] count128;
  
  always@(posedge clk_1 or negedge reset)
  begin
    if(!reset)
      begin
        clk_2 <= 1'b0;
		  clk_128 <= 1'b0;
		  count128 <= 8'd0;
      end
    else begin
      clk_2 <= ~clk_2;
		if(count128 == 8'd127) clk_128 = ~clk_128;
		count128 <= count128 + 8'd1;
	 end
  end
  
 endmodule