###################################################################

# Created by write_sdc on Sun Jan 20 10:14:16 2019

###################################################################
set sdc_version 1.8

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current uA
set_operating_conditions WORST -library IC05CScore_3lmaxv00
set_wire_load_model -name IPCORE001 -library IC05CScore_3lmaxv00
set_max_fanout 32 [current_design]
set_max_capacitance 2 [current_design]
set_max_transition 3 [current_design]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports clk]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports rst_n]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[7]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[6]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[5]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[4]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[3]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[2]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[1]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports {rx_data[0]}]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports rx_int]
set_driving_cell -lib_cell NI01D5 -pin Y [get_ports clk_bps]
set_fanout_load 16 [get_ports rs232_tx]
set_fanout_load 16 [get_ports bps_start]
set_load -pin_load 3 [get_ports rs232_tx]
set_load -pin_load 3 [get_ports bps_start]
create_clock [get_ports clk]  -period 100  -waveform {0 50}
set_clock_uncertainty -setup 1  [get_clocks clk]
set_clock_uncertainty -hold 0.5  [get_clocks clk]
set_input_delay -clock clk  -max 8  [get_ports clk]
set_input_delay -clock clk  -max 8  [get_ports rst_n]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[7]}]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[6]}]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[5]}]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[4]}]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[3]}]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[2]}]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[1]}]
set_input_delay -clock clk  -max 8  [get_ports {rx_data[0]}]
set_input_delay -clock clk  -max 8  [get_ports rx_int]
set_input_delay -clock clk  -max 8  [get_ports clk_bps]
set_output_delay -clock clk  -max 8  [get_ports rs232_tx]
set_output_delay -clock clk  -max 8  [get_ports bps_start]
