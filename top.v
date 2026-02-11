
module top(
							clk,
							res,
							data_in_a,
							data_in_b,
							en_data_in,
							sw,
							en_data_out,
							data_out
							);
input			clk,res;
input[3:0]		data_in_a;
input[3:0]		data_in_b;
input			en_data_in;
input			sw;
input			en_data_out;
output[7:0]		data_out;

wire[7:0]				w_data,w_data_comp;
data_pro	      U1  (
							.clk(clk),
							.res(res),
							.data_in_a(data_in_a),
							.data_in_b(data_in_b),
							.en_data_in(en_data_in),
							.data_out(w_data),
							.data_out_comp(w_data_comp),
							.en_data_out(en_data_out)
							);
data_sw        U2    (
							.clk(clk),
							.res(res),
							.data_in(w_data),
							.data_in_comp(w_data_comp),
							.sw(sw),
							.data_out(data_out)
							);
endmodule

