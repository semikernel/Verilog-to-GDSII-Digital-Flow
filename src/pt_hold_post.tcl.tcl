#################################################################################
# Script: pt_hold_post.tcl
# Stage:  Post-Layout Sign-off STA (Hold Analysis)
#################################################################################

# 1. 变量与路径定义
set DESIGN_NAME     "uart_tx"
set LIB_PATH        "/mnt/hgfs/share/Lab_Digital_IC_Design/csmc05/..."
set REPORT_DIR      "./report"

# 2. 库加载 (同上)
set target_library  "$LIB_PATH/IC05CScore_3lmaxv00.db $LIB_PATH/IC05CScore_3lminv00.db"
set link_library    "* $target_library"

# 3. 读取设计
read_verilog "../lab3_P&R/result/uart_tx_enc.v"
current_design $DESIGN_NAME
link

# 4. 反标版图寄生参数
read_parasitics -format SPEF "../lab3_P&R/result/uart_tx.spef"

# 5. 设定操作条件 (Hold 检查使用 Best Case 快速库)
set_operating_conditions -library IC05CScore_3lminv00 BEST

# 6. 时钟约束 (Propagated Clock)
create_clock -name "clk" -period 100 -waveform {0 50} [get_ports clk]
# 启用传播时钟分析时钟偏斜 (Skew)
set_propagated_clock [get_clocks clk]
set_clock_uncertainty -hold 0.5 [get_clocks clk]

# 7. I/O 约束与环境设置 (针对 Hold 库环境)
set_driving_cell -lib_cell NI01D5 -pin Y [remove_from_collection [all_inputs] [get_ports clk]]
set_load 3.0 [all_outputs]

set_input_delay  8.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 8.0 -clock clk [all_outputs]

# 8. 导出报告
# 报告所有违例
report_constraint -all_violators > "${REPORT_DIR}/uart_tx_nworst_path_post_hold.rpt"

# 报告前 10 条最短路径 (Min Delay / Hold)
report_timing -to [all_registers -data_pins] \
              -delay_type min \
              -max_paths 10 \
              -input_pins -nets -transition_time \
              > "${REPORT_DIR}/all_registers_hold.txt"

puts "Post-Layout Hold STA Completed."
