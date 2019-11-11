module ClkGen(
  input 	sys_clk,
  input 	reset,
  output clk_1,
  output reg clk_2,
  output reg clk_4,
  output reg clk_32,
  output reg clk_128
  );
  
  assign clk_1 = sys_clk;
  reg  count4;
  reg [3:0] count32;
  reg [5:0] count128;
  
  always@(posedge clk_1 or negedge reset)
  begin
    if(!reset)
      begin
        clk_2 <= 1'b0;
		  clk_4 <= 1'b0;
		  clk_32 <= 1'b0;
		  clk_128 <= 1'b0;
		  count4 <= 1'd0;
		  count32 <= 4'd0;
		  count128 <= 6'd0;
      end
    else begin
      clk_2 <= ~clk_2;
		if(count128 == 6'd63) clk_128 = ~clk_128;
		if(count32 == 4'd15) clk_32 = ~clk_32;
		if(count4 == 1'd1) clk_4 = ~clk_4;
		count128 <= count128 + 6'd1;
		count32 <= count32 + 4'd1;
		count4 <= count4 + 1'd1;
	 end
  end
  
 endmodule