module ClkGen(
  input 	sys_clk,
  input 	reset,
  output clk_1,
  output reg clk_2
  );
  
  assign clk_1 = sys_clk;
  
  always@(posedge clk_1 or negedge reset)
  begin
    if(!reset)
      begin
        clk_2 <= 1'b0;
      end
    else
      clk_2 <= ~clk_2;
  end
  

  endmodule