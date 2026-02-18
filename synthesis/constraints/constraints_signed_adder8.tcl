##################################
# Input/Output Constraints File
##################################
set CLK_PERIOD 10.00 
set CLK_LATENCY 0.50
set CLK_SKEW 1.00
set CLK_JITTER 0.20
set SETUP_UNCERTAINTY [expr $CLK_SKEW + $CLK_JITTER]
set INPUT_DELAY 3.00
set OUTPUT_DELAY 3.00

#######################
### Clock constraints
#######################
# 1. Creating the clock object "clk" and attach it to port "SCLK"
create_clock -name clk -period $CLK_PERIOD -waveform {0.0 5.0} [get_ports SCLK]

# 2. Apply Latency and Uncertainty to the CLOCK OBJECT (not the port)
set_clock_latency $CLK_LATENCY [get_clocks clk]
set_clock_uncertainty -setup $SETUP_UNCERTAINTY [get_clocks clk]
set_clock_uncertainty -hold $CLK_SKEW [get_clocks clk]

# 3. Apply Transition to the CLOCK OBJECT
set_clock_transition -rise 0.1 [get_clocks clk]
set_clock_transition -fall 0.12 [get_clocks clk]

# Virtual clock for input/output signals
create_clock -name v_clk -period $CLK_PERIOD -waveform {0.0 5.0}

#######################
### Max transition/capacitance
#######################
set_max_transition 1.5 [current_design]
set_max_capacitance 0.2 [current_design]

#######################
#### Input constraints
#######################
# 4. Exclude the clock port SCLK from data input delays
set_input_delay $INPUT_DELAY -clock v_clk [remove_from_collection [all_inputs] [get_ports SCLK]]

set_max_fanout 1 [all_inputs]
set_input_transition -rise 0.1 [all_inputs]
set_input_transition -fall 0.12 [all_inputs]

#######################
#### Outputs constraints
#######################
set_output_delay $OUTPUT_DELAY -clock v_clk [all_outputs]
set_load 0.02 [all_outputs]