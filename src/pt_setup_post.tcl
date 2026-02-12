#################################################################################
# Script: pt_setup_post.tcl
# Stage:  Post-Layout Sign-off STA (Setup Analysis)
#################################################################################

# 1. 变量与路径定义
set DESIGN_NAME     "uart_tx"
set LIB_PATH        "/mnt/hgfs/share/Lab_Digital_IC_Design/csmc05/0.5um_Mixed_Process_HD_Standard&IO_library_IPCO-0073_5E12/CSMC05DPTMHD_FElib_V51/synopsys"
set REPORT_DIR      "./report"

if {![file exists $REPORT_DIR]} { file mkdir $REPORT_DIR }

# 2. 库加载 (同时加载 max 和 min 库以备 link)
set target_library  "$LIB_PATH/IC05CScore_3lmaxv00.db $LIB_PATH/IC05CScore_3lminv00.db"
set link_library    "* $target_library"

# 3. 读取布线后网表与设计
read_verilog "../lab3_P&R/result/uart_tx_enc.v"
current_design $DESIGN_NAME
link

# 4. 反标版图寄生参数 (核心步骤)
# 读入真实版图提取的 RC 参数，替代线负载模型
read_parasitics -format SPEF "../lab3_P&R/result/uart_tx.spef"

# 5. 设定操作条件 (Setup 检查使用 Worst Case 慢速库)
set_operating_conditions -library IC05CScore_3lmaxv00 WORST

# 6. 时钟约束 (Propagated Clock)
create_clock -name "clk" -period 100 -waveform {0 50} [get_ports clk]
# 核心：通知工具计算真实时钟树延时，而非理想时钟
set_propagated_clock [get_clocks clk]
set_clock_uncertainty -setup 1.0 [get_clocks clk]

# 7. I/O 约束与环境设置
set_driving_cell -lib_cell NI01D5 -pin Y [remove_from_collection [all_inputs] [get_ports clk]]
set_load 3.0 [all_outputs]

set_input_delay  8.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 8.0 -clock clk [all_outputs]

# 8. 导出报告
# 报告所有违例
report_constraint -all_violators > "${REPORT_DIR}/uart_tx_nworst_path_post_setup.rpt"

# 报告前 10 条最差建立时间路径 (Max Delay)
report_timing -to [all_registers -data_pins] \
              -delay_type max \
              -max_paths 10 \
              -input_pins -nets -transition_time \
              > "${REPORT_DIR}/all_registers_setup.txt"

puts "Post-Layout Setup STA Completed."
