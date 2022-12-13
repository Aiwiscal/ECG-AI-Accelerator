module conv_element_0_0(clk, rst_n, Xin, Yout);
input clk;
input rst_n;
input signed [7:0] Xin;
output reg signed [7:0] Yout;

reg signed[7:0] Xin_Reg[4:0];
reg [2:0] j;
// queue register buffer.
always @(posedge clk or negedge rst_n)
if (!rst_n)
	begin 
		for (j=3'd0; j<3'd4; j=j+3'd1)
			Xin_Reg[j]=8'd0;
	end
else
	begin
		for (j=3'd0; j<3'd4; j=j+3'd1)
			Xin_Reg[j+1] <= Xin_Reg[j];
		Xin_Reg[0] <= Xin;
	end
			
	
wire signed [7:0] coe[4:0];   
wire signed [15:0] Mout[4:0];   

// weights register
assign coe[4]=8'b00101010;
assign coe[3]=8'b01010001;
assign coe[2]=8'b01000011;
assign coe[1]=8'b10011110;
assign coe[0]=8'b11000011;

// 5 multipliers in parallel
multiplier	Umult0 (
	.clk (clk),
	.rst_n(rst_n),
	.data_a (coe[0]),
	.data_b (Xin_Reg[0]),
	.result (Mout[0]));
	
multiplier	Umult1 (
	.clk (clk),
	.rst_n(rst_n),
	.data_a (coe[1]),
	.data_b (Xin_Reg[1]),
	.result (Mout[1]));
	
multiplier	Umult2 (
	.clk (clk),
	.rst_n(rst_n),
	.data_a (coe[2]),
	.data_b (Xin_Reg[2]),
	.result (Mout[2]));
	
multiplier	Umult3 (
	.clk (clk),
	.rst_n(rst_n),
	.data_a (coe[3]),
	.data_b (Xin_Reg[3]),
	.result (Mout[3]));
	
multiplier	Umult4 (
	.clk (clk),
	.rst_n(rst_n),
	.data_a (coe[4]),
	.data_b (Xin_Reg[4]),
	.result (Mout[4]));


wire signed [16:0] csum_lvl_0[2:0];
// adder tree level 0
adder #(.DATA_WIDTH(16)) adder00(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Mout[0]),
	.data_b(Mout[1]),
	.result(csum_lvl_0[0])
);

adder #(.DATA_WIDTH(16)) adder01(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Mout[2]),
	.data_b(Mout[3]),
	.result(csum_lvl_0[1])
);

adder #(.DATA_WIDTH(16)) adder02(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Mout[4]),
	.data_b(16'd0),
	.result(csum_lvl_0[2])
);

// adder tree level 1
wire signed [17:0] csum_lvl_1[1:0];
adder #(.DATA_WIDTH(17)) adder10(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_0[0]),
	.data_b(csum_lvl_0[1]),
	.result(csum_lvl_1[0])
);

adder #(.DATA_WIDTH(17)) adder11(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_0[2]),
	.data_b(17'd0),
	.result(csum_lvl_1[1])
);

wire signed [18:0] yout;
// adder tree level 2
adder #(.DATA_WIDTH(18)) adder2(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(csum_lvl_1[0]),
	.data_b(csum_lvl_1[1]),
	.result(yout)
);

// rescaling
wire signed [18:0] yout_shift;
assign yout_shift = (yout >>> 8);

// data truncation
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		Yout <= 8'd0;
	else if (yout_shift[18] == 1'b1 && yout_shift < 19'b111_1111_1111_1000_0001)
		Yout <= 8'b1000_0001;
	else if (yout_shift[18] == 1'b0 && yout_shift > 19'b000_0000_0000_0111_1111)
		Yout <= 8'b0111_1111;
	else
		Yout <= yout_shift[7:0];
end
endmodule
