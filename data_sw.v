module data_sw(
							clk,
							res,
							data_in,
							data_in_comp,
							sw,
							data_out
							);
input 					clk,res;//时钟和复位；
input[7:0]				data_in,data_in_comp;//数据原码和补码输入；
input					sw;//原码补码切换；
output[7:0]			data_out;//数据输出；

reg[7:0]				data_out;

always@(posedge clk or negedge res) 
if(!res) begin
	data_out<=0;
end
else begin
	data_out<=sw?data_in_comp:data_in;//原码补码切换；
end
endmodule
