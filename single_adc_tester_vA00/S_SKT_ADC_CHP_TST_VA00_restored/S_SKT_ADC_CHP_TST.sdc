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





# Clock constraints



create_clock -name "gxb_clk" 	  -period 10.000ns [get_ports {CLK_GXB_100MHz}]
create_clock -name "SYS_CLK_IN" -period 10.000ns [get_ports {CLK_100MHz_OSC}]
create_clock -name "UDP_clk" 	  -period 8.000ns  [get_ports {CLK_UDP_125MHz}]


create_clock -period 5.000   {ADC_s_SKT_RDOUT:ADC_s_SKT_RDOUT_inst|SBND_ASIC_RDOUT_V2:\CHK:0:SBND_ASIC_RDOUT_V2|SHIFT_latch} 


create_generated_clock -name CLK_200MHz -source {alt_pll_inst|altpll_component|auto_generated|pll1|inclk[0]} -divide_by 1 -multiply_by 2 -duty_cycle 50.00 { alt_pll_inst|altpll_component|auto_generated|pll1|clk[0] }




# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty


set_clock_groups \
    -asynchronous \
    -group [get_clocks ProtoDUNE_SYS_CLK] \
    -group [get_clocks ProtoDUNE_CMD_CLK] \
    -group [get_clocks {SBND_HSTX_INST|ALTGX_TX_inst2|ALTGX_TX_alt_c3gxb_component|transmit_pcs0|clkout}] \
    -group [get_clocks {CLK_200MHz}] \
    -group [get_clocks {alt_pll_inst|altpll_component|auto_generated|pll1|clk[1]}] \
    -group [get_clocks {alt_pll_inst|altpll_component|auto_generated|pll1|clk[2]}] \
    -group [get_clocks {alt_pll_inst|altpll_component|auto_generated|pll1|clk[3]}] \
	 -group [get_clocks {ProtoDUNE_ADC_CLK_TOP_INST|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[0]}]\
	 -group [get_clocks {ProtoDUNE_ADC_CLK_TOP_INST|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[1]}]\
	 -group [get_clocks {ProtoDUNE_ADC_CLK_TOP_INST|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[2]}]\
	 -group [get_clocks {ProtoDUNE_ADC_CLK_TOP_INST|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[3]}]\
	 -group [get_clocks {ProtoDUNE_ADC_CLK_TOP_INST|ProtoDUNE_ADC_clk_gen_INST1|phase_pll_inst|altpll_component|auto_generated|pll1|clk[4]}]\
	 -group [get_clocks altera_reserved_tck] \
	 

	 
set_input_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[3]} 10ns [get_ports {I2C_*}]		
set_input_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[3]} 10ns [get_ports {ASIC_SDO*}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_0[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_0[1]}]

set_input_delay -clock CLK_200MHz  5    {ADC_BUSY*}


set_max_delay -from [get_clocks {ADC_s_SKT_RDOUT_inst|ADC_PLL_inst1|altpll_component|auto_generated|pll1|clk[0]}] -through [get_pins {ADC_s_SKT_RDOUT_inst|e_mux_inst|LPM_MUX_component|auto_generated|result_node[0]~0|combout}] -to [get_ports {ADC_CLK[0]}] 1
set_max_delay -from [get_clocks {ADC_s_SKT_RDOUT_inst|ADC_PLL_inst1|altpll_component|auto_generated|pll1|clk[1]}] -through [get_pins {ADC_s_SKT_RDOUT_inst|e_mux_inst|LPM_MUX_component|auto_generated|result_node[0]~0|combout}] -to [get_ports {ADC_CLK[0]}] 1
set_max_delay -from [get_clocks {ADC_s_SKT_RDOUT_inst|ADC_PLL_inst1|altpll_component|auto_generated|pll1|clk[2]}] -through [get_pins {ADC_s_SKT_RDOUT_inst|e_mux_inst|LPM_MUX_component|auto_generated|result_node[0]~0|combout}] -to [get_ports {ADC_CLK[0]}] 1
set_max_delay -from [get_clocks {ADC_s_SKT_RDOUT_inst|ADC_PLL_inst1|altpll_component|auto_generated|pll1|clk[3]}] -through [get_pins {ADC_s_SKT_RDOUT_inst|e_mux_inst|LPM_MUX_component|auto_generated|result_node[0]~0|combout}] -to [get_ports {ADC_CLK[0]}] 1


set_output_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[2]} 5 [get_ports {ADC_CLK*}]
set_output_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[2]} 5 [get_ports {ADC_CONV*}]




set_false_path -from * -to [get_ports {ADC_CONV* }]
set_false_path -from * -to [get_ports {ADC_CLK* }]
set_false_path -from * -to [get_ports {ADC_eclk_RST_L* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDXM_L* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDL_L*	 }]
set_false_path -from * -to [get_ports {ADC_eclk_READ_L* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDXL_L* }]	
set_false_path -from * -to [get_ports {OSC_CNTL1 }]
set_false_path -from * -to [get_ports {OSC_CNTL2 }]
set_false_path -from * -to [get_ports {OSC_CNTL3 }]
set_false_path -from * -to [get_ports {DAC_SELECT }]
set_false_path -from * -to [get_ports {JTAG_SEL }]
set_false_path -from * -to [get_ports {ANALOG_SEL }]
set_false_path -from * -to [get_ports {DAC_SELECT }]
set_false_path -from * -to [get_ports {ADC_CS* }]
set_false_path -from * -to [get_ports {ADC_SDI* }]
set_false_path -from * -to [get_ports {ASIC_SDI* }]
set_false_path -from * -to [get_ports {ASIC_CK* }]
set_false_path -from * -to [get_ports {ASIC_CS* }]
set_false_path -from * -to [get_ports {FE_RST_R* }]
set_false_path -from * -to [get_ports {FE_RST_L* }]		
set_false_path -from * -to [get_ports {DAC_CNTL* }]			
set_false_path -from * -to [get_ports {I2C_SCL* }]				
set_false_path -from * -to [get_ports {I2C_SDA* }]			


# tsu/th constraints
# tco constraints

## tpd constraints
#report_ucp -summary


