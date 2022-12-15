module sig_pulse(clk, rst_n, Xin, thr, Yout);
input clk;
input rst_n;
input signed [12:0] Xin;
input signed [12:0] thr;
output reg Yout;

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		Yout <= 1'b0;
	else
		Yout <= (Xin >= thr)?1'b1:1'b0;
end


endmodule
