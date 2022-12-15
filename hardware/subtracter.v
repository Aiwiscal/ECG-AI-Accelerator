module subtracter(clk, rst_n, data_a, data_b, result);
input clk;
input rst_n;
input signed [7:0] data_a;
input signed [7:0] data_b;
output reg signed [8:0] result;

reg signed [8:0] temp;

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		temp <= 9'd0;
	else
		temp <= data_a - data_b;
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		result <= 9'd0;
	else
		result <= temp;
end

endmodule
