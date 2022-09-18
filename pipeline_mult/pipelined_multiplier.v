module mul_pipe(
	input [15:0] numA59,
	input [15:0] numB59,
	input clk_59,
	input reset_59,
	output reg [15:0] Acc_result_59
);

/*----------Start of Multiplier variables-------------------*/

reg sign_A, sign_A1, sign_A2 = 0;
reg sign_B, sign_B1, sign_B2 = 0; 
reg sign_C, sign_C1, sign_C2, sign_C3 = 0;

reg [4:0] expA, expA1, expB, expB1 = 5'b00000;
reg [4:0] expC, expC1, expC2, expC3, expC4, expC5 = 5'b00000;

reg [9:0] manA, manB, manA1, manB1, manA2, manB2;
reg [10:0] normanA, normanB, normanA1, normanB1;
reg [21:0] proC, proC1;
reg [9:0] manC, manC1, manC2;


// End of variables

always@(numA59,numB59) begin
	sign_A = numA59[15];// Extarcting sign bits 
	sign_B = numB59[15];
	expA   = numA59[14:10];
	expB   = numB59[14:10]; 
	manB = numB59[9:0];
	manA = numA59[9:0];
	//$monitor("Stage 1 ---------------- sign_A=%b,sign_B=%b, expA=%b, expB=%b, manA = %b, manB = %b",sign_A,sign_B,expA,expB, manA, manB); 
end

always@(posedge clk_59) begin
	sign_A1 <= sign_A;
	sign_B1 <= sign_B;
	expA1 <= expA;
	expB1 <= expB;
	manA1 <= manA;
	manB1 <= manB;
end

//Stage 2
always@(sign_A1, sign_B1, expA1, expB1, manA1, manB1) begin
	if((numA59 == 16'b0) || (numB59 == 16'b0)) begin	
		sign_C = 0;
		expC = 5'b0;
		normanA = 11'b0; 
		normanB = 11'b0; end
	else begin
		sign_C = sign_A ^ sign_B;
		expC = expA1 + expB1 - 5'b01111;
		normanA = {1'b1, manA1};
		normanB = {1'b1, manB1}; end 
	//$monitor("Stage 2 ---------------- sign_A1=%b,sign_B1=%b, expA1=%b, expB1=%b, expC = %b, manA1 = %b, manB1 = %b",sign_A1,sign_B1,expA1,expB1,expC, manA1, manB1);
end

always@(posedge clk_59) begin
	sign_C1 <= sign_C;
	expC1 <= expC;
	normanA1 <= normanA;
	normanB1 <= normanB;
end

//Stage 3
always@(sign_C1, expC1, normanA1, normanB1) begin
	proC = normanA1 * normanB1;
end

always@(posedge clk_59) begin
	sign_C2 <= sign_C1;
	expC2 <= expC1;
	proC1 <= proC;
end


//Stage 4
always@(sign_C2, expC2, proC1) begin
	casex(proC1)
		22'b1xxxxxxxxxxxxxxxxxxxxx:
			  begin
			    manC = proC1[20:11];
			    expC3 = expC2 + 1;
			  end
		22'b01xxxxxxxxxxxxxxxxxxxx:
			  begin
			    manC = proC1[19:10];
			    expC3 = expC2;
			  end
		22'b001xxxxxxxxxxxxxxxxxxx:
			  begin
			    manC = proC1[18:9];
			    expC3 = expC2-1;
			  end
		22'b0001xxxxxxxxxxxxxxxxxx:
			  begin
			    manC = proC1[17:8];
			    expC3 = expC2-2;
			  end
		22'b00001xxxxxxxxxxxxxxxxx:
			  begin
			    manC = proC1[16:7];
			    expC3 = expC2-3;
			  end
		22'b000001xxxxxxxxxxxxxxxx:
			  begin
			    manC = proC1[15:6];
			    expC3 = expC2-4;
			  end
		22'b0000001xxxxxxxxxxxxxxx:
			  begin
			    manC = proC1[14:5];
			    expC3 = expC2-5;
			  end
		22'b00000001xxxxxxxxxxxxxx:
			  begin
			    manC = proC1[13:4];
			    expC3 = expC2-6;
			  end
		22'b000000001xxxxxxxxxxxxx:
			  begin
			    manC = proC1[12:3];
			    expC3 = expC2-7;
			  end
		22'b0000000001xxxxxxxxxxxx:
			  begin
			    manC = proC1[11:2];
			    expC3 = expC2-8;
			  end
		22'b00000000001xxxxxxxxxxx:
			  begin
			    manC = proC1[10:1];
			    expC3 = expC2-9;
			  end
		22'b000000000001xxxxxxxxxx:
			  begin
			    manC = proC1[9:0];
			    expC3 = expC2-10;
			  end
		22'b0000000000001xxxxxxxxx:
			  begin
			    manC = {proC1[8:0],1'b0};
			    expC3 = expC2-11;
			  end
		22'b00000000000001xxxxxxxx:
			  begin
			    manC = {proC1[7:0],2'b00};
			    expC3 = expC2-12;
			  end
		22'b000000000000001xxxxxxx:
			  begin
			    manC = {proC1[6:0],3'b000};
			    expC3 = expC2-13;
			  end
		22'b0000000000000001xxxxxx:
			  begin
			    manC = {proC1[5:0],4'b0000};
			    expC3 = expC2-14;
			  end
		22'b00000000000000001xxxxx:
			  begin
			    manC = {proC1[4:0],5'b0000};
			    expC3 = expC2-15;
			  end
		22'b000000000000000001xxxx:
			  begin
			    manC = {proC1[3:0],6'b0};
			    expC3 = expC2-16;
			  end
		22'b0000000000000000001xxx:
			  begin
			    manC = {proC1[2:0],7'b0};
			    expC3 = expC2-17;
			  end
		22'b00000000000000000001xx:
			  begin
			    manC = {proC1[1:0],8'b0};
			    expC3 = expC2-18;
			  end
		22'b000000000000000000001x:
			  begin
			    manC = {proC1[0],9'b0};
			    expC3 = expC2-19;
			  end
		default:
			  begin
			    manC = 10'b0;
			    expC3 = 5'b0; end
		endcase

end

always@(posedge clk_59) begin
	sign_C3 <= sign_C2;
	manC1 <= manC;
	expC4 <= expC3;
end

always@(sign_C3, manC1, expC4) begin
	#1; 
	Acc_result_59 = {sign_C3, expC4, manC1};
end
endmodule
