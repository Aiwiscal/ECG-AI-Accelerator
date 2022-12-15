module sig_rect(clk, rst_n, data, result);
input clk;
input rst_n;
input signed [8:0] data;
output reg signed [8:0] result;

reg signed [8:0] temp;

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		temp <= 9'd0;
	else if (data[8] == 1'b0)
		temp <= data;
	else
		temp <= ~data + 1'b1;
end

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		result <= 9'd0;
	else
		result <= temp;
end

endmodule
