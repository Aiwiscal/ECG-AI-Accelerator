module sig_diff(clk, rst_n, Xin, Yout);
input clk;
input rst_n;
input signed [7:0] Xin;
output signed [8:0] Yout;

reg signed[7:0] Xin_Reg[1:0];
always @(posedge clk or negedge rst_n)
if (!rst_n)
	begin 
		Xin_Reg[0] <= 8'd0;
		Xin_Reg[1] <= 8'd0;
	end
else
	begin
		Xin_Reg[1] <= Xin_Reg[0];
		Xin_Reg[0] <= Xin;
	end

subtracter sub(
	.clk(clk),
	.rst_n(rst_n),
	.data_a(Xin_Reg[0]),
	.data_b(Xin_Reg[1]),
	.result(Yout)
);

endmodule
