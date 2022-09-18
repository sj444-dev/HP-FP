module mult_tb( ); 

  reg [15:0] A_59, B_59; 
	reg clk_59,rst_59; 
  wire [15:0] C_59; 
	reg [15:0] expectedout_59;

/*
module adder_pipe(
	input [15:0] numA59,
	input [15:0] numB59,
	input clk_59,
	input reset_59,
	output reg [15:0] Acc_result_59
);
*/

  mul_pipe DUT(A_59, B_59, clk_59, rst_59, C_59); 

initial  
begin 
clk_59=1'b0; 
forever #1 clk_59=~clk_59; 
end  


initial  
	begin 
	rst_59=1'b0;
	
	#2
	A_59=16'h5620;
	B_59=16'h5948;
	expectedout_59=16'h740B;
	#2
	A_59=16'h5630;
	B_59=16'hD590;
	expectedout_59=16'hF04D;
	#2
	A_59=16'hD1A0;
	B_59=16'h54F0;
	expectedout_59=16'hEAF1;
	#2
	A_59=16'hDC6C;
	B_59=16'hD420;
	expectedout_59=16'h748F;
	#2
	A_59=16'h0000;
	B_59=16'h0000;
	expectedout_59=16'h0000;
	#2
	A_59=16'h0000;
	B_59=16'hD750;
	expectedout_59=16'h000;
	#2
	A_59=16'h5620;
	B_59=16'h5948;
	expectedout_59=16'h740B;
	#2
	A_59=16'h5630;
	B_59=16'hD590;
	expectedout_59=16'hF04D;
	#2
	A_59=16'hD1A0;
	B_59=16'h54F0;
	expectedout_59=16'hEAF1;
	#2
	A_59=16'hDC6C;
	B_59=16'hD420;
	expectedout_59=16'h748F;
	#2
	A_59=16'h0000;
	B_59=16'h0000;
	expectedout_59=16'h0000;
	#2
	A_59=16'h0000;
	B_59=16'hD750;
	expectedout_59=16'h0000;
	#20
	$finish; 
end  
initial  
begin 
  $monitor("A=%h,B=%h, exp=%h, C=%h",A_59,B_59,expectedout_59,C_59); 
$dumpfile("pipelined_mult.vcd");
$dumpvars();
end  
endmodule

