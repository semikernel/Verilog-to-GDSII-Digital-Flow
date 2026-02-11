# =================================================================
# Synopsys Design Compiler Synthesis Script (Optimized for Worst Case)
# Project: UART_TX Synthesis (CSMC 0.5um)
# =================================================================

# 1. 环境准备
remove_design -designs

# 2. 读取设计
read_file -format verilog {./verilog/uart_tx.v}
current_design uart_tx

# 3. 设定工艺库与工作条件
# 显式指定 Worst Case 库和工作环境
set_operating_conditions -library IC05CScore_3lmaxv00 WORST
set_wire_load_model -name IPCORE001 -library IC05CScore_3lmaxv00

# 4. 设置驱动与负载约束
set_driving_cell -lib_cell NI01D5 -pin Y [all_inputs]
set_load 3.0 [all_outputs]
set_fanout_load 16 [all_outputs]

# 5. 设置设计规则约束 (DRC)
set_max_transition 3 [current_design]
set_max_capacitance 2 [current_design]
set_max_fanout 32 [current_design]

# 6. 定义时钟约束 (10MHz -> Period 100ns)
create_clock -name "clk" -period 100 -waveform { 0 50 } [get_ports clk]
set_dont_touch_network [get_clocks clk]

# 设置时钟不确定度 (考虑 Worst Case 下的抖动)
set_clock_uncertainty -setup 1 [get_clocks clk]
set_clock_uncertainty -hold 0.5 [get_clocks clk]

# 修复保持时间违例
set_fix_hold [get_clocks clk]

# 7. 输入输出延迟约束
set all_input_but_clock [remove_from_collection [all_inputs] [get_ports clk]]
set_input_delay 8 -clock clk $all_input_but_clock
set_output_delay -max 8 -clock clk [all_outputs]

# 8. 执行逻辑综合 (显式指定约束优先级)
# 使用 -map_effort high 来确保在 Worst Case 下尽可能优化时钟路径
compile -map_effort high -area_effort medium

# 9. 导出结果文件
sh mkdir -p result
write -format verilog -hierarchy -output result/uart_tx_dc.v
write_sdc result/uart_tx.sdc

# 10. 生成报告 (检查 Worst Case 下的 Slack)
sh mkdir -p report
report_timing -delay max -nworst 50 > "report/uart_tx_worst_path.rpt"
report_timing -delay min -nworst 50 > report/min_timing.rpt
report_constraint -all_violators > "report/all_violators.txt"
report_area > "report/area.txt"

echo "Synthesis with WORST CASE conditions completed!"
