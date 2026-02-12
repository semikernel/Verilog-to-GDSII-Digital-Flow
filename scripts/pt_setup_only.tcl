#################################################################################
# Script: pt_setup_only.tcl
# Purpose: Pre-layout STA focus on Setup Compliance
#################################################################################

# 1. 变量设置
set DESIGN_NAME     "uart_tx"
set REPORT_DIR      "./reports_pre_layout"
set DB_PATH         "/mnt/hgfs/share/Lab_Digital_IC_Design/csmc05/0.5um_Mixed_Process_HD_Standard&IO_library_IPCO-0073_5E12/CSMC05DPTMHD_FElib_V51/synopsys"

file mkdir $REPORT_DIR

# 2. 库与设计加载 (专注于 Worst Case 库)
set target_library "$DB_PATH/IC05CScore_3lmaxv00.db"
set link_library   "* $DB_PATH/IC05CScore_3lmaxv00.db"

read_verilog "../result/uart_tx_dc.v"
current_design $DESIGN_NAME
link

# 3. 操作环境 (Single Mode - Worst Case)
set_operating_conditions WORST -library IC05CScore_3lmaxv00

# 4. 时序约束
create_clock -name clk -period 100 [get_ports clk]

# 核心：设置较严的 Setup Margin，为 Layout 留出余量
# 给 Setup 1.0ns 的 Uncertainty，Hold 设为 0 (暂不关心)
set_clock_uncertainty -setup 1.0 [get_clocks clk]
set_clock_uncertainty -hold  0.0 [get_clocks clk]

# I/O 约束
set_input_delay  8.0 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay 8.0 -clock clk [all_outputs]

# 5. 时序分组 
# 将路径按类型分组，方便观察是输入延时太大、内部逻辑太长还是输出延时太大
group_path -name INPUTS  -from [all_inputs]
group_path -name OUTPUTS -to [all_outputs]
group_path -name REGS    -from [all_registers] -to [all_registers]

# 6. 静态时序分析报告 (Setup Only)
check_timing

# 报告每个分组最差的 20 条路径
# -nworst 2 表示显示到达同一终点的两条最差路径
report_timing -delay_type max \
              -max_paths 50 \
              -input_pins \
              -nets \
              -transition_time \
              -capacitance \
              > ${REPORT_DIR}/setup_priority_report.rpt

# 汇总报告：查看整体违例情况
report_constraint -all_violators -significant_digits 4 > ${REPORT_DIR}/summary_violations.rpt

report_timing -delay_type min -max_paths 10 > ${REPORT_DIR}/hold_debug_reference.rpt

puts "Pre-layout Setup Analysis Done."
