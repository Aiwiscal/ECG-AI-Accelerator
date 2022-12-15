module relu(clk, rst_n, Xin, Yout);
input clk;
input rst_n;
input signed [7:0] Xin;
output reg signed [7:0] Yout;

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		Yout <= 8'd0;
	else if (Xin[7] == 1'b1)
		Yout <= 8'd0;
	else
		Yout <= Xin;
end

endmodule
