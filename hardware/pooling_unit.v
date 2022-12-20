module pooling_unit(clk, rst_n, en_in, Xin, Yout);
input clk;
input rst_n;
input en_in;
input signed [7:0] Xin;
output reg signed [7:0] Yout;


reg signed [7:0] temp_in;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		temp_in <= 8'd0;
	else
		temp_in <= Xin;
end

reg [2:0] cnt;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			cnt <= 3'd0;
		end
	else if(cnt == 3'd5)
		begin
			cnt <= 3'd1;
		end
	else if(en_in == 1'b1)
		cnt <= cnt + 1'b1;
	else
		begin
			cnt <= 3'd0;
		end
end

reg signed [7:0] temp_out;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		temp_out <= 8'd0;
	else if (!en_in)
		temp_out <= 8'd0;
	else if (cnt == 3'd1)
		temp_out <= temp_in;
	else
		begin
			if(temp_in > temp_out) temp_out <= temp_in;
		end
end


always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		Yout <= 8'd0;
	else
		begin
			if (cnt == 3'd1) Yout <= temp_out;
		end
end

endmodule
