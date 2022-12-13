(* multstyle = "dsp" *)module multiplier(clk, rst_n, data_a, data_b, result);
input clk;
input rst_n;
input signed [7:0] data_a;
input signed [7:0] data_b;
output reg signed [15:0] result;

reg signed [15:0] temp;

always@(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				temp <= 16'd0;
			end
		else
			begin
				temp <= data_a * data_b;
			end
	end
// D-trigger
// For better timing performance, i.e., Higher Fmax.
always@(posedge clk or negedge rst_n)
begin
if(!rst_n)
			begin
				result <= 16'd0;
			end
		else
			begin
				result <= temp;
			end
end
endmodule
