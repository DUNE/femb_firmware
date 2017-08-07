#************************************************************
# THIS IS A WIZARD-GENERATED FILE.                           
#
# Version 13.1.4 Build 182 03/12/2014 SJ Full Version
#
#************************************************************

# Copyright (C) 1991-2014 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.





create_clock -name "CLK_REF_125MHz" -period 8.000 [get_ports {CLK_125M_spare}]
create_clock -name "SYS_clk" 			-period 10.000 [get_ports {CLK_100MHz_OSC}]


create_clock -name CLK_125MHz -period 8    [get_pins {PLL_serdes_inst|altpll_component|auto_generated|pll1|clk[0]}]
create_clock -name CLK_200MHz -period 5    [get_pins {alt_pll_inst|altpll_component|auto_generated|pll1|clk[0]}]
create_clock -name CLK_100MHz -period 10   [get_pins {alt_pll_inst|altpll_component|auto_generated|pll1|clk[1]}]
create_clock -name CLK_40MHz  -period 25   [get_pins {alt_pll_inst|altpll_component|auto_generated|pll1|clk[2]}]
create_clock -name CLK_10MHz  -period 100  [get_pins {alt_pll_inst|altpll_component|auto_generated|pll1|clk[3]}]



# Automatically constrain PLL and other generated clock

# Automatically calculate clock uncertainty to jitter and other effects.

derive_pll_clocks -create_base_clocks
derive_clock_uncertainty




set_clock_groups \
    -asynchronous \
    -group [get_clocks {CLK_125MHz}] \
    -group [get_clocks {CLK_200MHz}] \
    -group [get_clocks {CLK_100MHz}] \
    -group [get_clocks {CLK_40MHz}] \
    -group [get_clocks {CLK_10MHz}] \
	 -group [get_clocks {ADC_ASIC_TEST_inst1|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[0]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst1|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[1]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst1|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[2]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst1|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[3]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst1|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[4]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst2|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[0]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst2|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[1]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst2|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[2]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst2|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[3]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst2|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[4]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst3|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[0]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst3|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[1]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst3|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[2]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst3|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[3]}]\
	 -group [get_clocks {ADC_ASIC_TEST_inst3|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[4]}]\

	 


# Data constraints
#
#set_input_delay -clock { CLK_80MHz } -add_delay 12.5 [get_ports {ADC_FE1_SDO*}]
#set_input_delay -clock { CLK_80MHz } -add_delay 12.5 [get_ports {ADC_FE2_SDO*}]
#set_input_delay -clock { CLK_80MHz } -add_delay 12.5 [get_ports {ADC_FE3_SDO*}]
#set_input_delay -clock { CLK_80MHz } -add_delay 12.5 [get_ports {ADC_FE4_SDO*}]
#
#
#set_input_delay -clock { CLK_80MHz } -add_delay 12.5 [get_ports {IntDAC_SDO_FE*}]
#
#set_input_delay -clock { CLK_80MHz } -add_delay 5  [get_ports {TST*}]
#set_input_delay -clock { CLK_10MHz } -add_delay 10 [get_ports {SDO*}]







##
#set_false_path -from {UDP_IO:udp_io_inst1|tx_frame:tx_frame_inst|reg_address_S*} -to {UDP_IO:udp_io_inst1|tx_frame:tx_frame_inst|reg_data_s*}
#set_false_path -from [get_clocks {CLK_80MHz}]   -to [get_clocks {CLK_40MHz}]
#set_false_path -from [get_clocks {CLK_40MHz}] -to [get_clocks {CLK_80MHz}]
#set_false_path -from [get_clocks {CLK_80MHz}]   -to [get_clocks {CLK_10MHz]}]
#set_false_path -from {CLK_10MHz} -to {CLK_80MHz}
#set_false_path -from {CLK_80MHz} -to {CLK_10MHz}
#
#

