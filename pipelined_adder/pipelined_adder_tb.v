module fpadder_tb( ); 

	reg [15:0] A_59, B_59; 
	reg clk_59,rst_59; 
	wire [15:0] C_59; 
	reg [15:0] expoutput;

  fpadder DUT(.A_59(A_59),.B_59(B_59),.C_59(C_59),.clk_59(clk_59)); 

initial  
begin 
clk_59=1'b0; 
forever #1 clk_59=~clk_59; 
end  


initial  
	begin 
	rst_59=1'b0;
	#200
	A_59=16'h5620;
	B_59=16'h5948;
	expoutput=16'h5C2C;
	#200
	A_59=16'h5630;
	B_59=16'hD590;
	expoutput=16'h4900;
	#200
	A_59=16'hD1A0;
	B_59=16'h54F0;
	expoutput=16'h5040;
	#200
	A_59=16'hDC6C;
	B_59=16'hD420;
	expoutput=16'hDD74;
	#200
	A_59=16'h0000;
	B_59=16'h0000;
	expoutput=16'h0000;
	#200
	A_59=16'h0000;
	B_59=16'hD750;
	expoutput=16'hD750;
	#200
	A_59=16'h5620;
	B_59=16'h5948;
	expoutput=16'h5C2C;
	#200
	A_59=16'h5630;
	B_59=16'hD590;
	expoutput=16'h4900;
	#200
	A_59=16'hD1A0;
	B_59=16'h54F0;
	expoutput=16'h5040;
	#200
	A_59=16'hDC6C;
	B_59=16'hD420;
	expoutput=16'hDD74;
	#200
	A_59=16'h0000;
	B_59=16'h0000;
	expoutput=16'h0000;
	#200
	A_59=16'h0000;
	B_59=16'hD750;
	expoutput=16'hD750;
	$finish; 
end  
initial  
begin 
$dumpfile("pipelined_adder.vcd");
$dumpvars();
end  
endmodule
