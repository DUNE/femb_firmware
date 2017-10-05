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


create_clock -name "ProtoDUNE_SYS_CLK" -period 10.000ns [get_ports {ProtoDUNE_CLK}]
create_clock -name "ProtoDUNE_CMD_CLK" -period 500.000ns [get_ports {ProtoDUNE_CMD}]
create_clock -name "gxb_clk" 	  -period 10.000ns [get_ports {CLK_GXB_100MHz}]
create_clock -name "SYS_CLK_IN" -period 10.000ns [get_ports {CLK_100MHz_OSC}]


#create_clock -name "UDP_clk" 	  -period 8.000ns  [get_ports {CLK_UDP_125MHz}]


create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:0:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:1:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:2:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:3:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:4:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:5:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:6:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 5.000    {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|SBND_ASIC_RDOUT_V2:\CHK:7:SBND_ASIC_RDOUT_V2|SHIFT_latch} 
create_clock -period 100      {SFL_EPCS:SFL_EPCS_inst|CLK_CNT[2]}
##create_clock -period 500	   {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|ADC_CONV_I} 



#create_clock -name notaclock1 -period 100
#create_clock -name notaclock2 -period 100
#create_clock -name notaclock3 -period 100

create_generated_clock -name CLK_200MHz -source {alt_pll_inst|altpll_component|auto_generated|pll1|inclk[0]} -divide_by 1 -multiply_by 2 -duty_cycle 50.00 { alt_pll_inst|altpll_component|auto_generated|pll1|clk[0] }



# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty


set_clock_groups \
    -asynchronous \
    -group [get_clocks ProtoDUNE_SYS_CLK] \
    -group [get_clocks ProtoDUNE_CMD_CLK] \
	 -group [get_clocks SYS_CLK_IN] \
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
    -group [get_clocks {alt_pll_inst|altpll_component|auto_generated|pll1|clk[1]~1}] \
    -group [get_clocks {alt_pll_inst|altpll_component|auto_generated|pll1|clk[2]~1}] \
    -group [get_clocks {alt_pll_inst|altpll_component|auto_generated|pll1|clk[3]~1}] \
##	 -group [get_clocks {SBND_RDOUT_V1:SBND_RDOUT_V1_inst|ADC_CONV_I}] \


	 
set_input_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[3]} 10ns [get_ports {I2C_*}]		
set_input_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[3]} 10ns [get_ports {ASIC_SDO*}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_0[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_0[1]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_1[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_1[1]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_2[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_2[1]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_3[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_3[1]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_4[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_4[1]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_5[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_5[1]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_6[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_6[1]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_7[0]}]
set_input_delay -clock CLK_200MHz  1.5 [get_ports {ADC_FD_7[1]}]
set_input_delay -clock CLK_200MHz  5    {ADC_BUSY*}
set_input_delay -clock { SFL_EPCS:SFL_EPCS_inst|CLK_CNT[2] } 10 [get_ports {BRD_ID*}]
set_input_delay -clock { altera_reserved_tck } 25 [get_ports {SFL_EPCS:SFL_EPCS_inst|ADV_SFL:ADV_SFL_inst|altserial_flash_loader:altserial_flash_loader_component|\GEN_ASMI_TYPE_1:asmi_inst~ALTERA_DATA0}]
set_input_delay -clock { altera_reserved_tck } 25 [get_ports {altera_reserved_tck}]
set_input_delay -clock { altera_reserved_tck } 25 [get_ports {altera_reserved_tdi}]
set_input_delay -clock { altera_reserved_tck } 25 [get_ports {altera_reserved_tms}]


set_output_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[2]} 5 [get_ports {ADC_CLK*}]
set_output_delay -clock {alt_pll_inst|altpll_component|auto_generated|pll1|clk[2]} 5 [get_ports {ADC_CONV*}]
set_output_delay -clock { altera_reserved_tck } 15  [get_ports {SFL_EPCS:SFL_EPCS_inst|ADV_SFL:ADV_SFL_inst|altserial_flash_loader:altserial_flash_loader_component|\GEN_ASMI_TYPE_1:asmi_inst~ALTERA_DCLK}]
set_output_delay -clock { altera_reserved_tck } 15  [get_ports {SFL_EPCS:SFL_EPCS_inst|ADV_SFL:ADV_SFL_inst|altserial_flash_loader:altserial_flash_loader_component|\GEN_ASMI_TYPE_1:asmi_inst~ALTERA_SCE}]
set_output_delay -clock { altera_reserved_tck } 15  [get_ports {SFL_EPCS:SFL_EPCS_inst|ADV_SFL:ADV_SFL_inst|altserial_flash_loader:altserial_flash_loader_component|\GEN_ASMI_TYPE_1:asmi_inst~ALTERA_SDO}]
set_output_delay -clock { altera_reserved_tck } 15  [get_ports {altera_reserved_tdo}]
	

set_false_path -from * -to [get_ports {ADC_CONV* }]
set_false_path -from * -to [get_ports {ADC_CLK* }]
set_false_path -from * -to [get_ports {ADC_eclk_RST_L* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDXM_L* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDL_L*	 }]
set_false_path -from * -to [get_ports {ADC_eclk_READ_L* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDXL_L* }]	
set_false_path -from * -to [get_ports {ADC_eclk_RST_R*	 }]
set_false_path -from * -to [get_ports {ADC_eclk_IDXM_R* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDL_R*	 }]
set_false_path -from * -to [get_ports {ADC_eclk_READ_R* }]
set_false_path -from * -to [get_ports {ADC_eclk_IDXL_R* }]
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


