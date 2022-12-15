module sig_inte(clk, rst_n, Xin, Yout);
input clk;
input rst_n;
input signed [8:0] Xin;
output signed [12:0] Yout;

reg signed[8:0] Xin_Reg[15:0];
reg [3:0] j; 
always @(posedge clk or negedge rst_n)
if (!rst_n)
	begin 
		for (j=4'd0; j<4'd15; j=j+4'd1)
			Xin_Reg[j]=9'd0;
	end
else
	begin
		for (j=4'd0; j<4'd15; j=j+4'd1)
			Xin_Reg[j+1] <= Xin_Reg[j];
		Xin_Reg[0] <= Xin;
	end

wire signed [9:0] csum_lvl_0 [7:0]; 

adder #(.DATA_WIDTH(9)) adder00 (
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[0]),
	.data_b(Xin_Reg[1]),
	.result(csum_lvl_0[0])
);

adder #(.DATA_WIDTH(9)) adder01(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[2]),
	.data_b(Xin_Reg[3]),
	.result(csum_lvl_0[1])
);

adder #(.DATA_WIDTH(9)) adder02(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[4]),
	.data_b(Xin_Reg[5]),
	.result(csum_lvl_0[2])
);

adder #(.DATA_WIDTH(9)) adder03(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[6]),
	.data_b(Xin_Reg[7]),
	.result(csum_lvl_0[3])
);

adder #(.DATA_WIDTH(9)) adder04(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[8]),
	.data_b(Xin_Reg[9]),
	.result(csum_lvl_0[4])
);

adder #(.DATA_WIDTH(9)) adder05(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[10]),
	.data_b(Xin_Reg[11]),
	.result(csum_lvl_0[5])
);

adder #(.DATA_WIDTH(9)) adder06(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[12]),
	.data_b(Xin_Reg[13]),
	.result(csum_lvl_0[6])
);

adder #(.DATA_WIDTH(9)) adder07(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[14]),
	.data_b(Xin_Reg[15]),
	.result(csum_lvl_0[7])
);

// -------------------------------------------

wire signed [10:0] csum_lvl_1 [3:0]; 

adder #(.DATA_WIDTH(10)) adder10(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_0[0]),
	.data_b(csum_lvl_0[1]),
	.result(csum_lvl_1[0])
);

adder #(.DATA_WIDTH(10)) adder11(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_0[2]),
	.data_b(csum_lvl_0[3]),
	.result(csum_lvl_1[1])
);

adder #(.DATA_WIDTH(10)) adder12(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_0[4]),
	.data_b(csum_lvl_0[5]),
	.result(csum_lvl_1[2])
);

adder #(.DATA_WIDTH(10)) adder13(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_0[6]),
	.data_b(csum_lvl_0[7]),
	.result(csum_lvl_1[3])
);

// -------------------------------------------

wire signed [11:0] csum_lvl_2 [1:0]; 

adder #(.DATA_WIDTH(11)) adder20(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_1[0]),
	.data_b(csum_lvl_1[1]),
	.result(csum_lvl_2[0])
);

adder #(.DATA_WIDTH(11)) adder21(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_1[2]),
	.data_b(csum_lvl_1[3]),
	.result(csum_lvl_2[1])
);

// ------------------------------------------

adder #(.DATA_WIDTH(12)) adder3(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_2[0]),
	.data_b(csum_lvl_2[1]),
	.result(Yout)
);


		
endmodule
