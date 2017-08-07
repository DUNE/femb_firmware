--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: SBND_FPGA.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 07/16/2015 
--////  Description:  TOP LEVEL SBND FPGA FIRMWARE  
--////					
--////
--/////////////////////////////////////////////////////////////////////
--////
--//// Copyright (C) 2015 Brookhaven National Laboratory
--////
--/////////////////////////////////////////////////////////////////////

library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
USE work.sbndPkg.all;

entity SBND_FPGA is
	port 
	(
	
		SBND_TX			: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);	-- 1.5V PCML
		SFP_TX			: OUT STD_LOGIC_VECTOR (0 DOWNTO 0);
		SFP_RX			: IN  STD_LOGIC_VECTOR (0 DOWNTO 0);
		CLK_100MHz_OSC	: IN STD_LOGIC;	-- LVDS	  100MHz
		CLK_125MHz_OSC	: IN STD_LOGIC;	-- LVDS	  125MHz  Internal SERDES CLOCK				
--		CLK_125M_spare	: IN STD_LOGIC;	-- LVDS	  125MHz  Internal SERDES CLOCK		
		CLK_EXT			: IN STD_LOGIC;	-- LVDS
		CLK_DAQ			: IN STD_LOGIC;	-- LVDS
		
		SBND_CLK			: IN STD_LOGIC;	-- LVDS
		SBND_CMD			: IN STD_LOGIC;	-- LVDS		
		
--		FE_CS_L			: OUT STD_LOGIC;	-- 1.8V
--		FE_RST_L			: OUT STD_LOGIC;	-- 1.8V
--		FE_CK_L			: OUT STD_LOGIC;	-- 1.8V
--		FE_SDI_L			: OUT STD_LOGIC;	-- 1.8V
--		FE_SDO_L			: IN  STD_LOGIC;	-- 1.8V

		FE_CS_R			: OUT STD_LOGIC;	-- 1.8V
		FE_RST_R			: OUT STD_LOGIC;	-- 1.8V
		FE_CK_R			: OUT STD_LOGIC;	-- 1.8V
		FE_SDI_R			: OUT STD_LOGIC;	-- 1.8V
		FE_SDO_R			: IN  STD_LOGIC;	-- 1.8V
		
		
--		ADC_STRB_L		: OUT STD_LOGIC;
		ADC_SCK_L		: OUT STD_LOGIC;
		ADC_SDI_L		: OUT STD_LOGIC;
		ADC_SDO_L		: IN STD_LOGIC;
		ADC_CS_L        	: OUT STD_LOGIC;
		ADC_PD_L        	: OUT STD_LOGIC;

		ADC_STRB_R		: OUT STD_LOGIC;	-- LVDS	
		ADC_SDI_R		: OUT STD_LOGIC;	-- LVDS	USED TO BE ADC_REN_R		
		ADC_SDO_R		: IN STD_LOGIC;	-- LVDS		

		ADC_FD_0			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_1			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_2			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_3			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS		
		ADC_FD_4			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_5			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_6			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_7			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS				
		
	
		
		ADC_FF			: IN  STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
		ADC_FE			: IN  STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
		ADC_CS			: OUT STD_LOGIC_VECTOR(7 downto 1);  -- LVDS	
		ADC_CLK			: OUT STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
		ADC_SYNC			: OUT STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
		
		DAC_SELECT		: OUT STD_LOGIC;								-- 2.5V
		BRD_ID			: IN STD_LOGIC_VECTOR(4 downto 0);			-- 1.8V		
		DAC_CNTL			: OUT STD_LOGIC_VECTOR(5 downto 0);		-- 1.8V	
		DAC_CNTL_HIGH	: OUT STD_LOGIC;			-- LVDS		
		MISC_IO			: OUT STD_LOGIC_VECTOR(7 downto 0);			-- 2.5V
		TEST_IO			: INOUT STD_LOGIC_VECTOR(7 downto 0);		-- 1.8V		

		MISC_I_L			: IN  STD_LOGIC_VECTOR(3 downto 0);  -- LVDS	
--		MISC_I_L			: IN  STD_LOGIC_VECTOR(3 downto 0);  -- LVDS	
--		MISC_I_R			: IN  STD_LOGIC_VECTOR(3 downto 0);  -- LVDS		
		
		COM_OUT			: OUT STD_LOGIC;			-- LVDS
		I2C_SCL			: INOUT  STD_LOGIC;		-- 2.5V
		I2C_SDA			: INOUT STD_LOGIC;		-- 2.5V
--		I2C_SCL_DIF_P	: INOUT STD_LOGIC;		-- BUSED LVDS
--		I2C_SCL_DIF_N	: INOUT STD_LOGIC;		-- BUSED LVDS	
--		I2C_SDA_DIF_P	: INOUT STD_LOGIC;		-- BUSED LVDS
--		I2C_SDA_DIF_N	: INOUT STD_LOGIC;		-- BUSED LVDS	

--external clock --gss
		ADC_READ_L		: OUT STD_LOGIC;	-- LVDS
		ADC_IDXM_L		: OUT STD_LOGIC;	-- LVDS
		ADC_IDXL_L		: OUT STD_LOGIC;	-- LVDS
		ADC_IDL_L		: OUT STD_LOGIC;	-- LVDS
		ADC_RST_L		: OUT STD_LOGIC;	-- LVDS

--		ADC_READ_R		: OUT STD_LOGIC;	-- LVDS
--		ADC_IDXM_R		: OUT STD_LOGIC;	-- LVDS
--		ADC_IDXL_R		: OUT STD_LOGIC;	-- LVDS
--		ADC_IDL_R		: OUT STD_LOGIC;	-- LVDS
--		ADC_RST_R		: OUT STD_LOGIC;	-- LVDS		
--external clock --gss
	
		I2C_SDA_SCL 	: INOUT STD_LOGIC;		-- BUSED LVDS
		I2C_SDA_SDA		: INOUT STD_LOGIC;		-- BUSED LVDS		
		
		I2C_SCL_MISC	: INOUT STD_LOGIC;		-- 2.5V
		I2C_SDA_MISC	: INOUT STD_LOGIC		   -- 2.5V


	);

end SBND_FPGA;


architecture SBND_FPGA_arch of SBND_FPGA is


COMPONENT sys_rst
	PORT
	(	clk 			: IN STD_LOGIC;
		reset_in 	: IN STD_LOGIC;
		start 		: OUT STD_LOGIC;
		RST_OUT 		: OUT STD_LOGIC
	);
END COMPONENT;


component alt_pll
	PORT
	(	inclk0	: IN STD_LOGIC;
		c0			: OUT STD_LOGIC ;
		c1			: OUT STD_LOGIC ;
		c2			: OUT STD_LOGIC ;
		c3			: OUT STD_LOGIC ;
		c4			: OUT STD_LOGIC 

	);
end component;


component LBNE_PLL
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
end component;

	
component lbne_pll2
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC 
	);
end component;


component LBNE_HSTX 
	PORT
	(
		GXB_TX_A			: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		rst				: IN STD_LOGIC;
		cal_clk_125MHz	: IN STD_LOGIC;
		gxb_clk			: IN STD_LOGIC;			
		Stream_EN		: IN STD_LOGIC;	
		PRBS_EN			: IN STD_LOGIC;	
		CNT_EN			: IN STD_LOGIC;			
		DATA_CLK			: IN STD_LOGIC;
		DATA_VALID		: IN STD_LOGIC;			
		LANE1_DATA		: IN STD_LOGIC_VECTOR(15 downto 0);
		LANE2_DATA		: IN STD_LOGIC_VECTOR(15 downto 0);
		LANE3_DATA		: IN STD_LOGIC_VECTOR(15 downto 0);		
		LANE4_DATA		: IN STD_LOGIC_VECTOR(15 downto 0)			
	);
end component;




COMPONENT alt_iobuf_diff
	PORT(i 		: IN STD_LOGIC;
		 oe 		: IN STD_LOGIC;
		 iobar 	: INOUT STD_LOGIC;
		 io 		: INOUT STD_LOGIC;
		 o 		: OUT STD_LOGIC
	);
END COMPONENT;




COMPONENT SFL_EPCS 
	PORT
	(	rst         : IN STD_LOGIC;				-- state machine reset
		clk         : IN STD_LOGIC;
		start_op		: IN STD_LOGIC;	
		JTAG_EEPROM	: IN STD_LOGIC;
		op_code	   : IN STD_LOGIC_VECTOR(7 downto 0);	
		address	   : IN STD_LOGIC_VECTOR(23 downto 0);	
		status		: OUT STD_LOGIC_VECTOR(31 downto 0);		
		DPM_WREN		: OUT STD_LOGIC;		
		DPM_ADDR		: OUT STD_LOGIC_VECTOR(7 downto 0);		
		DPM_Q	  		: IN  STD_LOGIC_VECTOR(31 downto 0);
		DPM_D			: OUT STD_LOGIC_VECTOR(31 downto 0)		
	);
END COMPONENT;



COMPONENT LBNE_TST_PULSE 
	PORT
	(
		sys_rst     	: IN STD_LOGIC;			
		clk_50Mhz    	: IN STD_LOGIC;				-- clock
		TP_ENABLE		: IN STD_LOGIC;
		LA_SYNC		 	: IN STD_LOGIC;		
		INTDAC_CLKWIDTH: IN STD_LOGIC_VECTOR(15 downto 0);			
		TP_AMPL			: IN STD_LOGIC_VECTOR(5 downto 0);
		TP_DLY			: IN STD_LOGIC_VECTOR(15 downto 0);
		TP_FREQ			: IN STD_LOGIC_VECTOR(15 downto 0);
		INTDAC_CLK		: OUT STD_LOGIC;	
		DAC_CNTL			: OUT STD_LOGIC_VECTOR(5 downto 0)
	);
END COMPONENT;


component clk_out
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC ;
		c1		: OUT STD_LOGIC ;
		c2		: OUT STD_LOGIC ;
		c3		: OUT STD_LOGIC 
	);
end component;

--external clock --gss
COMPONENT la_clk_gen
	PORT(
		sys_rst     	: IN STD_LOGIC;				-- clock
		clk    		 	: IN STD_LOGIC;				-- clock
		
		PERIOD			: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
				
		INV_ADC_RST	 	: IN STD_LOGIC;							-- invert
		OFST_ADC_RST	: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_ADC_RST	: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH

		INV_RDEN	 		: IN STD_LOGIC;							-- invert		
		OFST_RDEN	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_RDEN	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH

		INV_MSB_S	 	: IN STD_LOGIC;							-- invert		
		OFST_MSB_S		: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_MSB_S	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH

		INV_LSB_S	 	: IN STD_LOGIC;							-- invert		
		OFST_LSB_S	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_LSB_S	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
	
		INV_LSB_f	 	: IN STD_LOGIC;							-- invert		
		OFST_LSB_f1	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_LSB_f1	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		OFST_LSB_f2	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_LSB_f2	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		
		LA_ADC_RST 	 	: OUT STD_LOGIC;
		LA_RD_EN 	 	: OUT STD_LOGIC;
		LA_MSB_SIG 	 	: OUT STD_LOGIC;
		LA_LSB_SIG 	 	: OUT STD_LOGIC;
		LA_LSB_FCELL 	: OUT STD_LOGIC
	);
END COMPONENT;
--external clock --gss


SIGNAL   SIG_IN		:	STD_LOGIC;
SIGNAL	clk_200Mhz 		:  STD_LOGIC;
SIGNAL	clk_125Mhz 		:  STD_LOGIC;
SIGNAL	clk_100Mhz 		:  STD_LOGIC;
SIGNAL	clk_50Mhz		:  STD_LOGIC;
SIGNAL	clk_2Mhz			:  STD_LOGIC;
SIGNAL	LOC_CLK			:  STD_LOGIC;


SIGNAL	reset 			:  STD_LOGIC;
SIGNAL	start					: STD_LOGIC;

--useless with ADC test board IO-1630-1A
SIGNAL	FE_CS_L				:  STD_LOGIC;		
SIGNAL	FE_RST_L			:  STD_LOGIC;
SIGNAL	FE_CK_L				:  STD_LOGIC;
SIGNAL	FE_SDI_L			:  STD_LOGIC;
SIGNAL	FE_SDO_L			:  STD_LOGIC;

SIGNAL	ADC_CS_tmp 			:  STD_LOGIC_VECTOR(7  DOWNTO 0);
SIGNAL	ADC_SDI_L_tmp 			:  STD_LOGIC;
SIGNAL	ADC_STRB_L  			:  STD_LOGIC;

--SIGNAL	en_out 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);

SIGNAL	ADC_CLK_tmp 			:  STD_LOGIC_VECTOR(7  DOWNTO 0);
SIGNAL	ADC_SYNC_tmp 			:  STD_LOGIC_VECTOR(7  DOWNTO 0);
SIGNAL	ADC_FD_0_tmp 			:  STD_LOGIC_VECTOR(7  DOWNTO 0);

SIGNAL	reg0_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg1_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg2_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg3_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg4_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg5_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg6_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg7_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg8_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg9_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg10_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg11_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg12_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg13_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg14_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg15_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg16_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg17_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg18_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg19_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
--external clock  --gss
SIGNAL	reg20_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg21_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg22_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg23_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg24_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg25_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg26_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg27_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg28_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg29_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg30_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg31_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg32_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg33_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg34_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg35_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
SIGNAL	reg36_p 			:  STD_LOGIC_VECTOR(31  DOWNTO 0);
--external clock  --gss

SIGNAL	DPM_WREN					:  STD_LOGIC;		
SIGNAL	DPM_ADDR					:  STD_LOGIC_VECTOR(7 downto 0);		
SIGNAL	DPM_Q						:  STD_LOGIC_VECTOR(31 downto 0);
SIGNAL	DPM_D						:  STD_LOGIC_VECTOR(31 downto 0);	

SIGNAL	FPGA_F_DPM_WREN		:  STD_LOGIC;		
SIGNAL	FPGA_F_DPM_ADDR		:  STD_LOGIC_VECTOR(7 downto 0);		
SIGNAL	FPGA_F_DPM_Q			:  STD_LOGIC_VECTOR(31 downto 0);
SIGNAL	FPGA_F_DPM_D			:  STD_LOGIC_VECTOR(31 downto 0);	

SIGNAL	LBNE_SPI_DPM_WREN		:  STD_LOGIC;		
SIGNAL	LBNE_SPI_DPM_ADDR		:  STD_LOGIC_VECTOR(7 downto 0);		
SIGNAL	LBNE_SPI_DPM_Q			:  STD_LOGIC_VECTOR(31 downto 0);
SIGNAL	LBNE_SPI_DPM_D			:  STD_LOGIC_VECTOR(31 downto 0);	



SIGNAL	ADC_SYNC_L				: STD_LOGIC;	-- LVDS		USE TO BE ADC_RCK_L
SIGNAL 	ADC_SYNC_R				: STD_LOGIC;	-- LVDS		USE TO BE ADC_RCK_R		

SIGNAL	rd_strb 					:  STD_LOGIC;
SIGNAL	wr_strb 					:  STD_LOGIC;
SIGNAL	WR_address				:  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	RD_address				:  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	data 						:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	rdout 					:  STD_LOGIC_VECTOR(31 DOWNTO 0);


SIGNAL	I2C_data      	  		:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	I2C_address    	 	:  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	I2C_WR    	 	 		:  STD_LOGIC;
SIGNAL	I2C_data_out	 		:  STD_LOGIC_VECTOR(31 DOWNTO 0);
		

SIGNAL	UDP_data        		:  STD_LOGIC_VECTOR(31 downto 0);	
SIGNAL	UDP_WR_address  		:  STD_LOGIC_VECTOR(15 downto 0); 
SIGNAL	UDP_RD_address  		:  STD_LOGIC_VECTOR(15 downto 0); 
SIGNAL	UDP_WR    	 	 		:  STD_LOGIC;	
SIGNAL	UDP_data_out	 		:  STD_LOGIC_VECTOR(31 downto 0);		
		
SIGNAL	SYS_RESET				:  STD_LOGIC;
SIGNAL	REG_RESET				:  STD_LOGIC;

SIGNAL	FPGA_F_ENABLE			:  STD_LOGIC;
SIGNAL 	FPGA_F_OP_CODE			:  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL 	FPGA_F_STRT_OP			:  STD_LOGIC;
SIGNAL 	FPGA_F_ADDR				:  STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL 	FPGA_F_status			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL 	INTDAC_CLKWIDTH		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	INTDAC_CLKEN				:  STD_LOGIC;
SIGNAL	INTDAC_CLK				:  STD_LOGIC;

SIGNAL	TS_RESET					:  STD_LOGIC;

SIGNAL	ADC_RESET				:  STD_LOGIC;
SIGNAL	FE_RESET					:  STD_LOGIC;
SIGNAL	WRITE_ADC_ASIC_SPI	:  STD_LOGIC;
SIGNAL	WRITE_FE_ASIC_SPI		:  STD_LOGIC;


SIGNAL 	CLK_select				: 	STD_LOGIC_VECTOR(7 downto 0); 		
SIGNAL 	CHP_select				:	STD_LOGIC_VECTOR(7 downto 0); 		
SIGNAL 	CHN_select				:	STD_LOGIC_VECTOR(7 downto 0); 
SIGNAL	TST_PATT_EN				:	STD_LOGIC_VECTOR(7 downto 0); 
SIGNAL	TST_PATT					:	STD_LOGIC_VECTOR(11 downto 0);
SIGNAL 	ADC_TEST_PAT_EN		:  STD_LOGIC;


SIGNAL	Header_P_event			:	STD_LOGIC_VECTOR(7 downto 0); 	-- Number of events packed per header  	

SIGNAL	LATCH_LOC_0				:	STD_LOGIC_VECTOR(7 downto 0);	
SIGNAL	LATCH_LOC_1				:	STD_LOGIC_VECTOR(7 downto 0);
SIGNAL	LATCH_LOC_2				:	STD_LOGIC_VECTOR(7 downto 0);
SIGNAL	LATCH_LOC_3				:	STD_LOGIC_VECTOR(7 downto 0);
SIGNAL	LATCH_LOC_4				:	STD_LOGIC_VECTOR(7 downto 0);	
SIGNAL	LATCH_LOC_5				:	STD_LOGIC_VECTOR(7 downto 0);
SIGNAL	LATCH_LOC_6				:	STD_LOGIC_VECTOR(7 downto 0);
SIGNAL	LATCH_LOC_7				:	STD_LOGIC_VECTOR(7 downto 0);	



SIGNAL	OUT_of_SYNC	 			:  STD_LOGIC_VECTOR(15 downto 0);		

SIGNAL	HS_DATA_LATCH 			:	STD_LOGIC;
	
SIGNAL	UDP_TST_LATCH			:	STD_LOGIC;
SIGNAL	UDP_TST_DATA			:	STD_LOGIC_VECTOR(15 downto 0);
	
	
	
	
SIGNAL	LANE1_DATA		 		:	STD_LOGIC_VECTOR(15 downto 0);
SIGNAL	LANE2_DATA		 		:	STD_LOGIC_VECTOR(15 downto 0);
SIGNAL	LANE3_DATA		 		:	STD_LOGIC_VECTOR(15 downto 0);
SIGNAL	LANE4_DATA		 		:	STD_LOGIC_VECTOR(15 downto 0);


SIGNAL	TP_SYNC					: STD_LOGIC;
SIGNAL	TP_AMPL					: STD_LOGIC_VECTOR(5 downto 0);
SIGNAL	TP_DLY					: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL	TP_FREQ					: STD_LOGIC_VECTOR(15 downto 0);



SIGNAL	Stream_EN				: STD_LOGIC;
SIGNAL	PRBS_EN					: STD_LOGIC;	
SIGNAL	CNT_EN					: STD_LOGIC;

SIGNAL	clk_200				: STD_LOGIC;

SIGNAL	TP_ENABLE			: STD_LOGIC;
SIGNAL	FPGADAC_MEAS   	: STD_LOGIC;
SIGNAL	ADC_MODE				: STD_LOGIC;
SIGNAL	test1					: STD_LOGIC;
SIGNAL	test2					: STD_LOGIC;

SIGNAL tmp_FE_CK_R	: STD_LOGIC;
SIGNAL tmp_FE_CK_L	: STD_LOGIC;
SIGNAL tmp_FE_CS_R	: STD_LOGIC;
SIGNAL tmp_FE_CS_L	: STD_LOGIC;
SIGNAL INTERNAL_EN: STD_LOGIC;
SIGNAL DAC_CK_EN: STD_LOGIC;
SIGNAL OUTPUT_EN: STD_LOGIC;

SIGNAL DAC_CNTL_tmp	: STD_LOGIC_VECTOR(5 downto 0);


SIGNAL	LA_idle 			:  STD_LOGIC;
SIGNAL	LA_idxle 		:  STD_LOGIC;
SIGNAL	LA_idxme 		:  STD_LOGIC;
SIGNAL	LA_rste 			:  STD_LOGIC;
SIGNAL	LA_reade 		:  STD_LOGIC;


begin

----- register map -------

	SYS_RESET				<= reg0_p(0);							-- SYSTEM RESET
	REG_RESET				<= reg0_p(1);							-- RESISTER RESET
	TS_RESET					<= reg0_p(2);							-- TIME_STAMP RESET
	ADC_RESET				<= reg1_p(0);		
	FE_RESET					<= reg1_p(1);			
	WRITE_ADC_ASIC_SPI 	<= reg2_p(0);	 	
	WRITE_FE_ASIC_SPI 	<= reg2_p(1);	 	
	TST_PATT_EN				<= reg3_p(7 downto 0);		
	TST_PATT					<= reg3_p(27 downto 16);
	ADC_TEST_PAT_EN	 	<= reg3_p(31);	 	
	
	LATCH_LOC_0				<= reg4_p(7 downto 0);		
	LATCH_LOC_1				<= reg4_p(15 downto 8);	
	LATCH_LOC_2				<= reg4_p(23 downto 16);	
	LATCH_LOC_3				<= reg4_p(31 downto 24);	
	LATCH_LOC_4				<= reg14_p(7 downto 0);	
	LATCH_LOC_5				<= reg14_p(15 downto 8);	
	LATCH_LOC_6				<= reg14_p(23 downto 16);	
	LATCH_LOC_7				<= reg14_p(31 downto 24);	

	TP_AMPL					<= reg5_p(5 downto 0);

	TP_ENABLE		    	<= reg16_p(0);	
	DAC_CK_EN            <= reg16_p(1);
    OUTPUT_EN            <= reg16_p(2);	
    INTERNAL_EN          <= reg16_p(3);	



	TP_FREQ		 			<= reg5_p(31 downto 16);
	TP_DLY					<= reg5_p(15 downto 8);

	
	CLK_select				<= reg6_p(7 downto 0);	
	--OUT_of_SYNC				reg6(31 downto 16);
	CHP_select				<= reg7_p(7 downto 0);	
	CHN_select				<= reg17_p(3 downto 0) & reg7_p(11 downto 8);	
	Header_P_event			<= reg8_p(7 downto 0);	

	Stream_EN				<= reg9_p(0);		
	PRBS_EN					<= reg9_p(1);		
	CNT_EN					<= reg9_p(2);		

	FPGA_F_OP_CODE			<= reg10_p(7 downto 0);				-- EPCS  OP CODE
	FPGA_F_STRT_OP			<= reg10_p(8);							-- START FLASH OPERATION
	--FPGA_F_ENABLE			<= reg10_p(31);						-- ENABLE EPCS PROGRAMMING 
	FPGA_F_ADDR				<= reg11_p(23 downto 0);			-- EPCS ADDRESS
	--FPGA_F_status			REG 12 
	FPGA_F_ENABLE			<= reg13_p(0);	

--	tx_digitalreset		<=	reg20_p(1);  used bellow
    INTDAC_CLKWIDTH      <=  reg19_p(15 downto 0);
	INTDAC_CLKEN            <=  reg19_p(31);

    FPGADAC_MEAS			<=  reg16_p(7);
	DAC_SELECT				<=  reg16_p(8);	
	ADC_MODE					<=  reg18_p(0);
    SIG_IN				<= reg15_p(0);

--    en_out <= reg36_p (31 downto 0 );
--    en_out <= X"00000000";


-----  end of register map



sys_rst_inst : sys_rst
PORT MAP(	clk 			=> clk_50Mhz,
				reset_in 	=> SYS_RESET,
				start 		=> start,
				RST_OUT 		=> reset);
			
alt_pll_inst : alt_pll
	PORT MAP
	(
		inclk0		=> CLK_100MHz_OSC,
		c0				=> clk_200Mhz,
		c1				=> clk_125Mhz,
		c2				=> clk_100Mhz,
		c3				=> clk_50Mhz,
		c4				=> clk_2Mhz
	);
	
	

LBNE_HSTX_INST : LBNE_HSTX
	PORT MAP
	(
		GXB_TX_A			=> SBND_TX,
		rst				=> reset,
		cal_clk_125MHz	=> clk_125Mhz,
		gxb_clk			=> clk_125Mhz_OSC, --CLK_125M_spare,
		Stream_EN		=> NOT Stream_EN,
		PRBS_EN			=> PRBS_EN,
		CNT_EN			=>	CNT_EN,
		DATA_CLK			=> clk_100Mhz,
		DATA_VALID		=> HS_DATA_LATCH,	
		LANE1_DATA		=> LANE1_DATA,
		LANE2_DATA		=> LANE2_DATA,
		LANE3_DATA		=> LANE3_DATA,
		LANE4_DATA		=> LANE4_DATA
	);
	
		
	LOC_CLK		<= clk_50Mhz; 
			


 I2C_slave_inst1 : entity work.I2C_slave_32bit_A16
	PORT MAP
	(
		rst   	   		=> reset,
		sys_clk	   		=> clk_50Mhz,
		I2C_BRD_ADDR		=> b"0000101",
		SCL         		=> I2C_SDA_SCL, --_DIF_P,
		SDA        			=> I2C_SDA_SDA, --DIF_N,
		REG_ADDRESS			=> I2C_address,
		REG_DOUT				=> I2C_data_out,
		REG_DIN				=> I2C_data ,
		REG_WR_STRB 		=> I2C_WR
	);
	
--b2v_inst_29: alt_iobuf_diff			
--PORT MAP(i 		=> '0',
--			oe 	=> SIG_IN,
--			iobar => I2C_SDA_DIF_N,
--			io 	=> I2C_SDA_DIF_P,
--			o 		=> test1);		
--		
--b2v_inst_30 : alt_iobuf_diff	
--PORT MAP(i 		=> '0',
--			oe 	=> SIG_IN,
--			iobar => I2C_SCL_DIF_N,
--			io 	=> I2C_SCL_DIF_P,
--			o 		=> test2);
--				
	

 SBND_Registers_inst :  entity work.SBND_Registers 
	PORT MAP
	(
		rst         => reset or REG_RESET,	
		clk         => clk_100Mhz,

		BOARD_ID		=> x"00" & b"000" & BRD_ID,
		VERSION_ID	=> x"0100",
		
		I2C_data       => I2C_data,
		I2C_address    => I2C_address,
		I2C_WR    	 	=> I2C_WR , 
		I2C_data_out	=> I2C_data_out,	
		
		
		UDP_data       =>	UDP_data,
		UDP_WR_address => UDP_WR_address,
		UDP_RD_address => UDP_RD_address,
		UDP_WR    	 	=> UDP_WR ,
		UDP_data_out	=> UDP_data_out,
			
		
		DPM_B_WREN		=> DPM_WREN,
		DPM_B_ADDR		=> DPM_ADDR,
		DPM_B_Q			=> DPM_Q,
		DPM_B_D			=> DPM_D,

		reg0_i 	=> reg0_p,
		reg1_i 	=> reg1_p,		 
		reg2_i 	=> reg2_p,		 
		reg3_i 	=> reg3_p,	
		reg4_i 	=> reg4_p,
		reg5_i 	=> reg5_p,
		reg6_i 	=> OUT_of_SYNC & reg6_p(15 downto 0),
		reg7_i 	=> reg7_p,
		reg8_i 	=> reg8_p,
		reg9_i 	=> reg9_p,		 
		reg10_i 	=> reg10_p,
		reg11_i 	=> reg11_p,
		reg12_i 	=> FPGA_F_status,
		reg13_i 	=> reg13_p,
		reg14_i 	=> reg14_p,
		reg15_i 	=> reg15_p,	
		reg16_i 	=> reg16_p,
		reg17_i 	=> reg17_p,
		reg18_i 	=> reg18_p,
		reg19_i 	=> reg19_p,		 

		reg20_i     => reg20_p,
		reg21_i     => reg21_p,
		reg22_i     => reg22_p,
		reg23_i     => reg23_p,
		reg24_i     => reg24_p,
		reg25_i     => reg25_p,
		reg26_i     => reg26_p,
		reg27_i     => reg27_p,
		reg28_i     => reg28_p,
		reg29_i     => reg29_p,
		reg30_i     => reg30_p,
		reg31_i     => reg31_p,
		reg32_i     => reg32_p,
		reg33_i     => reg33_p,
		reg34_i     => reg34_p,
		reg35_i     => reg35_p,
		reg36_i     => reg36_p,
		 		 
		reg0_o 	=> reg0_p,
		reg1_o 	=> reg1_p,		 
		reg2_o 	=> reg2_p,		 
		reg3_o 	=> reg3_p,		
		reg4_o 	=> reg4_p,
		reg5_o 	=> reg5_p,
		reg6_o 	=> reg6_p,
		reg7_o 	=> reg7_p,
		reg8_o 	=> reg8_p,
		reg9_o 	=> reg9_p,		 
		reg10_o 	=> reg10_p,
		reg11_o 	=> reg11_p,
		reg12_o 	=> reg12_p,
		reg13_o 	=> reg13_p,
		reg14_o 	=> reg14_p,
		reg15_o 	=> reg15_p,
		reg16_o 	=> reg16_p,
		reg17_o 	=> reg17_p,
		reg18_o 	=> reg18_p,
		reg19_o 	=> reg19_p,		 

		reg20_o     => reg20_p,
		reg21_o     => reg21_p,
		reg22_o     => reg22_p,
		reg23_o     => reg23_p,
		reg24_o     => reg24_p,
		reg25_o     => reg25_p,
		reg26_o     => reg26_p,
		reg27_o     => reg27_p,
		reg28_o     => reg28_p,
		reg29_o     => reg29_p,
		reg30_o     => reg30_p,
		reg31_o     => reg31_p,
		reg32_o     => reg32_p,
		reg33_o     => reg33_p,
		reg34_o     => reg34_p,
		reg35_o     => reg35_p,
		reg36_o     => reg36_p

	);

	
	
	DPM_WREN		<=	LBNE_SPI_DPM_WREN	when (FPGA_F_ENABLE = '0') else
						FPGA_F_DPM_WREN;
	DPM_ADDR		<= LBNE_SPI_DPM_ADDR	when (FPGA_F_ENABLE = '0') else
						FPGA_F_DPM_ADDR;
	DPM_D			<= LBNE_SPI_DPM_D	when (FPGA_F_ENABLE = '0') else
						FPGA_F_DPM_D;

	FPGA_F_DPM_Q		<= DPM_Q;	
	LBNE_SPI_DPM_Q		<= DPM_Q;



SFL_EPCS_inst	: SFL_EPCS
	PORT MAP
	(
		rst         => reset,			
		clk         => LOC_CLK,
		JTAG_EEPROM	=> FPGA_F_ENABLE,
		start_op		=> FPGA_F_STRT_OP,			
		op_code	   => FPGA_F_OP_CODE,	
		address	   => FPGA_F_ADDR, 		
		status		=> FPGA_F_status,		
		DPM_WREN		=> FPGA_F_DPM_WREN,
		DPM_ADDR		=> FPGA_F_DPM_ADDR,
		DPM_Q	  		=> FPGA_F_DPM_Q,
		DPM_D			=>	FPGA_F_DPM_D
		
	);



	SBND_RDOUT_V1_inst :	entity work.SBND_RDOUT_V1
	PORT MAP
	(

		sys_rst     	=> SYS_RESET or ADC_RESET,	
		TS_RESET			=> TS_RESET,					-- reset		
		clk_200Mhz    	=> clk_200Mhz,
		clk_sys	    	=> clk_100Mhz,
		clk_TS	    	=> clk_100Mhz,

		ADC_MODE			=> ADC_MODE,
		NOVA_TIME_SYNC	=>	clk_2Mhz,--  TP_ENABLE, connect to nova 2MHz
		LBNE_ADC_RST	=>	ADC_RESET,
		TP_SYNC			=> TP_SYNC,
		ADC_SYNC			=> ADC_SYNC_tmp,

		ADC_FD_0			=> ADC_FD_0,
		ADC_FD_1			=> ADC_FD_1,		
		ADC_FD_2			=> ADC_FD_2,		
		ADC_FD_3			=> ADC_FD_3,			
		ADC_FD_4			=> ADC_FD_4,		
		ADC_FD_5			=> ADC_FD_5,		
		ADC_FD_6			=> ADC_FD_6,		
		ADC_FD_7			=> ADC_FD_7,					
		
		ADC_F_CLK		=> x"00",
		ADC_FF			=> ADC_FF,
		ADC_FE			=> ADC_FE,
		ADC_CLK			=> ADC_CLK_tmp,
	
		CLK_select		=>	CLK_select,
		CHP_select		=>	CHP_select,			--: IN STD_LOGIC_VECTOR(7 downto 0); 		
		CHN_select		=>	CHN_select,			--: IN STD_LOGIC_VECTOR(7 downto 0); 
		TST_PATT_EN		=> TST_PATT_EN,		--: IN STD_LOGIC_VECTOR(7 downto 0); 
		TST_PATT			=> TST_PATT,			--: IN STD_LOGIC_VECTOR(11 downto 0);
		Header_P_event	=> Header_P_event,	--: IN STD_LOGIC_VECTOR(7 downto 0); 	-- Number of events packed per header 
		
		LATCH_LOC_0		=> LATCH_LOC_0,		--: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_1		=> LATCH_LOC_1,		--: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_2		=> LATCH_LOC_2,		--: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_3		=> LATCH_LOC_3,		--: IN STD_LOGIC_VECTOR(7 downto 0);	
		LATCH_LOC_4		=> LATCH_LOC_4,		--: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_5		=> LATCH_LOC_5,		--: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_6		=> LATCH_LOC_6,		--: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_7		=> LATCH_LOC_7,		--: IN STD_LOGIC_VECTOR(7 downto 0);	
		
		

		EN_TST_MODE		=> not reg9_p(3),
		OUT_of_SYNC		=> OUT_of_SYNC,
		DATA_VALID		=> HS_DATA_LATCH,
		LANE1_DATA		=> LANE1_DATA, 		-- : OUT STD_LOGIC_VECTOR(31 downto 0);
		LANE2_DATA		=> LANE2_DATA, 		-- : OUT STD_LOGIC_VECTOR(31 downto 0);
		LANE3_DATA		=> LANE3_DATA, 		-- : OUT STD_LOGIC_VECTOR(31 downto 0);
		LANE4_DATA		=> LANE4_DATA, 		-- : OUT STD_LOGIC_VECTOR(31 downto 0);
		UDP_TST_LATCH	=> UDP_TST_LATCH,
		UDP_TST_DATA	=> UDP_TST_DATA
	);	
	


SBND_ASIC_CNTRL_inst :	entity work.SBND_ASIC_CNTRL
	PORT MAP
	(

		sys_rst     			=> SYS_RESET ,	
		clk_sys   				=> clk_100Mhz,
		
		ADC_ASIC_RESET			=>	ADC_RESET,
		FE_ASIC_RESET			=>	FE_RESET,
		WRITE_ADC_SPI			=> WRITE_ADC_ASIC_SPI,
		WRITE_FE_SPI			=> WRITE_FE_ASIC_SPI,
		ADC_FIFO_TM				=> ADC_TEST_PAT_EN,
		
		DPM_WREN		 			=> LBNE_SPI_DPM_WREN,
		DPM_ADDR		 			=> LBNE_SPI_DPM_ADDR,
		DPM_D			 			=> LBNE_SPI_DPM_D,
		DPM_Q						=> LBNE_SPI_DPM_Q,

		ASIC_ADC_CS				=> ADC_CS_tmp,	
		ASIC_ADC_SDO_L			=> ADC_SDO_L,	
		ASIC_ADC_SDI_L			=> ADC_SDI_L_tmp,	
		ASIC_ADC_CLK_STRB_L	=> ADC_STRB_L,
		ASIC_ADC_SDO_R			=> ADC_SDO_R,	
		ASIC_ADC_SDI_R			=> ADC_SDI_R,
		ASIC_ADC_CLK_STRB_R	=> ADC_STRB_R,
	
		ASIC_FE_CS_L			=> tmp_FE_CS_L,
		ASIC_FE_RST_L			=> FE_RST_L,	
		ASIC_FE_CK_L			=> tmp_FE_CK_L,
		ASIC_FE_SDI_L			=> FE_SDI_L,
		ASIC_FE_SDO_L			=> FE_SDO_L,
		ASIC_FE_CS_R			=> tmp_FE_CS_R,
		ASIC_FE_RST_R			=> FE_RST_R,
		ASIC_FE_CK_R			=> tmp_FE_CK_R,
		ASIC_FE_SDI_R			=> FE_SDI_R,	
		ASIC_FE_SDO_R			=> FE_SDO_R
		
	);
	ADC_CS <= ADC_CS_tmp(7 downto 1);
        ADC_CS_L <= ADC_CS_tmp(0) ;
        ADC_PD_L <= OUTPUT_EN ;
        ADC_SCK_L <= ADC_STRB_L ;
        ADC_SDI_L <= ADC_SDI_L_tmp; 

--        ADC_CS_L <= ADC_CS_tmp(0) when ( en_out(7) = '0' ) else '0';
--        ADC_PD_L <= OUTPUT_EN when ( en_out(8) = '0' ) else '0';
--        ADC_SCK_L <= ADC_STRB_L when ( en_out(9) = '0' ) else '0';
--        ADC_SDI_L <= ADC_SDI_L_tmp when ( en_out(10) = '0' ) else '0'; 
	
FE_CS_L <=	tmp_FE_CS_L;
FE_CS_R <=	tmp_FE_CS_R;
	
FE_CK_L <= tmp_FE_CK_L when ( tmp_FE_CS_L = '1' ) else 
           '0'         when ( DAC_CK_EN = '0' )   else
			  '0'         when (OUTPUT_EN = '1' ) else
			  INTDAC_CLK  when (INTDAC_CLKEN  = '1' ) else
			  DAC_CNTL_tmp(0) when (INTERNAL_EN = '1') else 
			  '0' ; 
FE_CK_R <= tmp_FE_CK_R when ( tmp_FE_CS_L = '1' ) else 
           '0'         when ( DAC_CK_EN = '0' )   else
			  '0'         when (OUTPUT_EN = '1' ) else
			  INTDAC_CLK  when (INTDAC_CLKEN = '1' ) else
			  DAC_CNTL_tmp(0) when (INTERNAL_EN = '1') else 
			  '0' ; 				 

--exteranl clock --gss
la_clk_gen_inst : la_clk_gen
PORT MAP( sys_rst 			=> SYS_RESET,
			 clk 					=> clk_200Mhz , --clk_100mhz,
			 
			 PERIOD 				=> reg20_P(15 downto 0),	
	
			 OFST_ADC_RST 		=> reg21_P(15 downto 0),		 
			 WDTH_ADC_RST 		=> reg22_P(15 downto 0),	
			 
			 OFST_RDEN 			=> reg23_P(15 downto 0),	 
			 WDTH_RDEN 			=> reg24_P(15 downto 0),
			 
			 OFST_MSB_S 		=> reg25_P(15 downto 0),		 
			 WDTH_MSB_S 		=> reg26_P(15 downto 0),	
			 
			 OFST_LSB_S 		=> reg27_P(15 downto 0),		 
			 WDTH_LSB_S 		=> reg28_P(15 downto 0),
			 
			 OFST_LSB_f1 		=> reg29_P(15 downto 0), 				 
			 WDTH_LSB_f1 		=> reg30_P(15 downto 0),
			 
			 OFST_LSB_f2 		=> reg31_P(15 downto 0),					 
			 WDTH_LSB_f2 		=> reg32_P(15 downto 0),
				 
			 INV_ADC_RST 		=> reg33_P(0),			 
			 INV_RDEN 			=> reg33_P(1),			 
			 INV_MSB_S 			=> reg33_P(2),			 
			 INV_LSB_S 			=> reg33_P(3),		
			 INV_LSB_f 			=> reg33_P(4),	
	
			 LA_ADC_RST 		=> LA_rste,
			 LA_RD_EN 			=> LA_reade,
			 LA_MSB_SIG		 	=> LA_idxme,
			 LA_LSB_SIG 		=> LA_idxle,
			 LA_LSB_FCELL 		=> LA_idle
        );

--ADC_RST_L		<= LA_rste  when ( en_out(0) = '0' ) else '0' ;
--ADC_READ_L		<= LA_reade when ( en_out(1) = '0' ) else '0' ;
--ADC_IDXM_L		<= LA_idxme when ( en_out(2) = '0' ) else '0' ;
--ADC_IDXL_L		<= LA_idxle when ( en_out(3) = '0' ) else '0' ;
--ADC_IDL_L		<= LA_idle  when ( en_out(4) = '0' ) else '0' ;
ADC_RST_L		<= LA_rste  ;
ADC_READ_L		<= LA_reade ;
ADC_IDXM_L		<= LA_idxme ;
ADC_IDXL_L		<= LA_idxle ;
ADC_IDL_L		<= LA_idle  ;

--		ADC_READ_R		<= LA_reade;
--		ADC_IDXM_R		<=LA_idxme;
--		ADC_IDXL_R		<=LA_idxle;
--		ADC_IDL_R		<=LA_idle;
--		ADC_RST_R		<=LA_rste;  
			
--exteranl clock --gss

LBNE_TST_PULSE_inst : LBNE_TST_PULSE 
	PORT MAP 
	(
		sys_rst 				=> SYS_RESET,	
		clk_50Mhz			=> clk_50Mhz,
		TP_ENABLE			=> TP_ENABLE,
		LA_SYNC		 		=> TP_SYNC,	
		INTDAC_CLKWIDTH   => INTDAC_CLKWIDTH,
		TP_AMPL				=> TP_AMPL,
		TP_DLY				=>	x"00" & TP_DLY,
		TP_FREQ				=> TP_FREQ,	 
		INTDAC_CLK        => INTDAC_CLK,
		DAC_CNTL				=> DAC_CNTL_tmp
	);

--	DAC_CNTL				<= DAC_CNTL_tmp;	
   DAC_CNTL <= DAC_CNTL_tmp when (FPGADAC_MEAS = '0' ) else TP_AMPL;  --For DAC measurement
   DAC_CNTL_HIGH <= '1';	-- tie high 
--	REG_RD_BK <= clk_64;
	
--MISC_IO(0) <= LA_rste  ;  
--MISC_IO(1) <= LA_reade ;
--MISC_IO(2) <= LA_idxme ;
--MISC_IO(3) <= LA_idxle ;
--MISC_IO(4) <= LA_idle  ;

--MISC_IO(0) <= LA_rste  when ( en_out(0) = '0' ) else '0';  
--MISC_IO(1) <= LA_reade when ( en_out(1) = '0' ) else '0';
--MISC_IO(2) <= LA_idxme when ( en_out(2) = '0' ) else '0';
--MISC_IO(3) <= LA_idxle when ( en_out(3) = '0' ) else '0';
--MISC_IO(4) <= LA_idle  when ( en_out(4) = '0' ) else '0';

--MISC_IO(5) <= ADC_CLK_tmp(0) ;		
--ADC_CLK(0)		<= ADC_CLK_tmp(0) when ( en_out(5) = '0' ) else '0';
--ADC_CLK(7 downto 1) <= "0000000";
--ADC_CLK		<= ADC_CLK_tmp;
--MISC_IO(5) <= FE_CK_R;		
--MISC_IO(6) <= FE_SDI_R;	
--MISC_IO(6) <= ADC_SYNC_tmp(0) when ( en_out(6) = '0' ) else '0' ;	
--ADC_SYNC(0)			<= ADC_SYNC_tmp(0) when ( en_out(6) = '0' ) else '0';
--ADC_SYNC(7 downto 1) <= ADC_SYNC_tmp(7 downto 1);
--ADC_SYNC			<= ADC_SYNC_tmp;
--MISC_IO(7) <= FE_SDO_R;	
--MISC_IO(7) <= MISC_I_L(0);	

--	MISC_IO(0)	<= test1;	
--	MISC_IO(2)	<= clk_200Mhz;	
--	MISC_IO(4)	<= test2;	
--	MISC_IO(6)	<= clk_2Mhz;	
--	MISC_IO(8)	<= 'Z';	
--	MISC_IO(10)	<= 'Z';	
--	MISC_IO(12)	<= 'Z';	
--	MISC_IO(14)	<= 'Z';	
--	MISC_IO(15)	<= '1';	


--	MISC_IO(1)	<= '0';	
--	MISC_IO(3)	<= '0';	
--	MISC_IO(5)	<= '0';	
--	MISC_IO(7)	<= '0';	
--	MISC_IO(9)	<= '0';	
--	MISC_IO(11)	<= '0';	
--	MISC_IO(13)	<= '0';	
	
	
udp_io_inst1 : entity work.udp_io
PORT MAP(	SPF_OUT 				=> SFP_RX(0),
				SFP_IN 				=> SFP_TX(0),
				reset 				=> reset,
				start 				=> start,
				BRD_IP				=> x"C0A87901",
				BRD_MAC				=> x"AABBCCDDEE10",
				clk_125MHz 			=> CLK_125MHz_OSC,
				gxb_cal_blk_clk	=> CLK_125MHz,
				config_clk_40MHz 	=> clk_50MHz,
				clk_io 				=> clk_100Mhz,
				FRAME_SIZE			=> x"1f8",
				tx_fifo_clk 		=> clk_100MHz,
				tx_fifo_wr 			=> UDP_TST_LATCH,
				tx_fifo_in 			=> UDP_TST_DATA,
				tx_fifo_used		=> open,
				header_user_info 	=> (others => '0'),
				rdout 				=> UDP_data_out,
				system_status 		=> x"00001000",
				TIME_OUT_wait 		=> x"00005000",
				wr_strb 				=> UDP_WR,
				rd_strb 				=> open,
				WR_address 			=> UDP_WR_address,
				RD_address 			=> UDP_RD_address,
				data 					=> UDP_data,
				LED					=> open);

	
end SBND_FPGA_arch;
