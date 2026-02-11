module data_pro(
							clk,
							res,
							data_in_a,
							data_in_b,
							en_data_in,
							data_out,
							data_out_comp,
							en_data_out
							);
input 					clk,res;//时钟和复位；
input[3:0]				data_in_a,data_in_b;//数据输入；
input					en_data_in;//数据输入使能；
output[7:0]			data_out,data_out_comp;//数据原码和补码输出；
input					en_data_out;//数据输出使能；

reg[3:0]				buf_a,buf_b;//数据输入寄存器；
reg[3:0]				buf_a_dealy,buf_b_dealy;//延时一拍寄存器；
reg[7:0]				data_out;

//补码转换；
assign					data_out_comp=data_out[7]?{data_out[7],~data_out[6:0]+1}:data_out;

always@(posedge clk or negedge res) 
if(!res) begin
	buf_a<=0;buf_b<=0;
	buf_a_dealy<=0;buf_b_dealy<=0;
	data_out<=0;
end
else begin
	//数据输入并加1；
	if(en_data_in) begin
		buf_a<=data_in_a+1;
		buf_b<=data_in_b+1;
	end
	//延时一拍；
	buf_a_dealy<=buf_a;
	buf_b_dealy<=buf_b;
	//乘法计算；
	if(en_data_out) begin
		data_out<=buf_a_dealy*buf_b_dealy;
	end	
end
endmodule



