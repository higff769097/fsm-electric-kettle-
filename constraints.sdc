
set EXTCLK "clk" ;
set_units -time 1.0ns ;
set EXTCLK_PERIOD 10.0; #100MHz
create_clock -name "$EXTCLK" -period "$EXTCLK_PERIOD" -waveform "0
[expr $EXTCLK_PERIOD/2]" [get_ports clk]

set SKEW 0.200
set_clock_uncertainty $SKEW [get_clocks $EXTCLK]

set SRLATENCY 0.80
set SFLATENCY 0.75

set MINRISE  0.20
set MAXRISE  0.25
set MINFALL  0.15
set MAXFALL  0.10
set_clock_transition -rise -min $MINRISE [get_clocks $EXTCLK]
set_clock_transition -rise -max $MAXRISE [get_clocks $EXTCLK]
set_clock_transition -fall -min $MINFALL [get_clocks $EXTCLK]
set_clock_transition -fall -max $MAXFALL [get_clocks $EXTCLK]

set INPUT_DELAY 0.5
set OUTPUT_DELAY 1.5

set INPUT_DELAY 0.5
set_input_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports clk]
set INPUT_DELAY 0.5
set_input_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports rst]
set INPUT_DELAY 0.5
set_input_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports start_button]
set INPUT_DELAY 0.5
set_input_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports temperature_sensor]
set INPUT_DELAY 0.5
set_input_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports water_level_sensor]



set OUTPUT_DELAY 0.5
set_output_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports heater]
set OUTPUT_DELAY 0.5
set_output_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports indicator]
set OUTPUT_DELAY 0.5
set_output_delay -clock [get_clocks $EXTCLK] -add_delay 0.3 [get_ports shutdown]

