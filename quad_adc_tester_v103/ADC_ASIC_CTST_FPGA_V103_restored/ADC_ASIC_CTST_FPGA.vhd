--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: ADC_ASC_CTST_FPGA.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 07/13/2017
--////  Description:  TOP LEVEL DUNE ADC ASIC CHIP TESTER
--////					
--////
--/////////////////////////////////////////////////////////////////////
--////
--//// Copyright (C) 2017 Brookhaven National Laboratory
--////
--/////////////////////////////////////////////////////////////////////

library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.StdRtlPkg.all;

entity ADC_ASIC_CTST_FPGA is
	port 
	(

		SFP_TX			: OUT STD_LOGIC_VECTOR (0 DOWNTO 0);
		SFP_RX			: IN  STD_LOGIC_VECTOR (0 DOWNTO 0);
		CLK_100MHz_OSC	: IN STD_LOGIC;	-- LVDS	  100MHz
		CLK_125M_spare	: IN STD_LOGIC;	-- LVDS	  125MHz  Internal SERDES CLOCK		

		DAC_SELECT		: OUT STD_LOGIC;								-- 2.5V
		BRD_ID			: IN STD_LOGIC_VECTOR(4 downto 0);			-- 1.8V		
		DAC_CNTL			: INOUT STD_LOGIC_VECTOR(6 downto 0);		-- 1.8V		
	
		ANALOG_SEL		: OUT STD_LOGIC;	
		JTAG_SEL			: OUT STD_LOGIC;	
		MISC_IOB			: INOUT  STD_LOGIC_VECTOR (7 DOWNTO 0);

		OSC_CNTL1		: OUT STD_LOGIC;			-- 2.5V   100MHz
		OSC_CNTL2		: OUT STD_LOGIC;			-- 2.5V	 125MHz
		OSC_CNTL3		: OUT STD_LOGIC;			-- 2.5V	 100MHz		
	
		MISC				: INOUT STD_LOGIC_VECTOR(9 downto 0);			-- 2.5V		
		LED				: OUT STD_LOGIC_VECTOR(7 downto 0);
		
		TST_SW1			: IN  STD_LOGIC;
		TST_SW2			: IN  STD_LOGIC;		
		TST_SW3			: IN  STD_LOGIC;			
		TST_SW4			: IN  STD_LOGIC;			
				

		INA_SDA			: INOUT STD_LOGIC;		
		INA_SCL			: INOUT STD_LOGIC;

		INB_SDA			: INOUT STD_LOGIC;
		INB_SCL			: INOUT STD_LOGIC;

		T_SDI				: OUT STD_LOGIC;	
		T_SCK				: OUT STD_LOGIC;			
		T_CS				: OUT STD_LOGIC;	
		T_SDO				: IN  STD_LOGIC;
		T_Drdy_N			: IN  STD_LOGIC;

			
		SPI_SDO_ADC1	: IN   STD_LOGIC;
		SPI_SDI_ADC1	: OUT  STD_LOGIC;
		SPI_CS_ADC1		: OUT  STD_LOGIC;
		SPI_CK_ADC1		: OUT  STD_LOGIC;


		SPI_CK_FE1		: OUT  STD_LOGIC;
		SPI_CS_FE1		: OUT  STD_LOGIC;
		SPI_SDI_FE1		: OUT  STD_LOGIC;
		SPI_SDO_FE1		: IN   STD_LOGIC;
		RST_FE1			: OUT  STD_LOGIC;
				
				


		ADC1_eclk_READ	: OUT  STD_LOGIC;
		ADC1_eclk_IDL	: OUT  STD_LOGIC;
		ADC1_eclk_IDXM	: OUT  STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL
		ADC1_eclk_RST	: OUT  STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL
		ADC1_eclk_IDXL	: OUT  STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL



		ADC1_FD			: IN STD_LOGIC_VECTOR(1 downto 0);	
		ADC1_FF			: IN  STD_LOGIC;

		ADC1_CONV		: OUT STD_LOGIC;

		ADC1_BUSY		: IN  STD_LOGIC;

		ADC1_CLK			: OUT STD_LOGIC;


		DAC1_SYNC		: OUT STD_LOGIC;
		DAC1_SCLK		: OUT STD_LOGIC;
		DAC1_DIN			: OUT STD_LOGIC;

		MUX_A0_ADC1		: OUT STD_LOGIC;
		MUX_A1_ADC1		: OUT STD_LOGIC;
		PWR_EN_ADC1		: OUT STD_LOGIC;
		SW_TST_ADC1		: OUT STD_LOGIC;



		SPI_CK_ADC2		: OUT STD_LOGIC;
		SPI_CS_ADC2		: OUT STD_LOGIC;
		SPI_SDI_ADC2	: OUT STD_LOGIC;
		SPI_SDO_ADC2	: IN STD_LOGIC;

		SPI_CK_FE2		: OUT STD_LOGIC;
		SPI_CS_FE2		: OUT STD_LOGIC;
		SPI_SDI_FE2		: OUT STD_LOGIC;
		SPI_SDO_FE2		: IN STD_LOGIC;
		RST_FE2			: OUT STD_LOGIC;







		ADC2_FD			: IN STD_LOGIC_VECTOR(1 downto 0);	
		ADC2_CLK			: OUT STD_LOGIC;    -- INVERTED ON SCH  need to fix in HDL
		ADC2_BUSY		: IN STD_LOGIC;
		ADC2_CONV		: OUT STD_LOGIC;
		ADC2_FF			: IN STD_LOGIC;
		
		ADC2_eclk_IDXL	: OUT  STD_LOGIC;  -- INVERTED ON SCH need to fix in HDL
		ADC2_eclk_READ	: OUT  STD_LOGIC;  -- INVERTED ON SCH need to fix in HDL
		ADC2_eclk_IDXM	: OUT  STD_LOGIC;
		ADC2_eclk_IDL	: OUT  STD_LOGIC;
		ADC2_eclk_RST	: OUT  STD_LOGIC;


		DAC2_DIN			: OUT STD_LOGIC;
		DAC2_SYNC		: OUT STD_LOGIC;
		DAC2_SCLK		: OUT STD_LOGIC;

		SW_TST_ADC2		: OUT STD_LOGIC;
		PWR_EN_ADC2		: OUT STD_LOGIC;
		MUX_A0_ADC2		: OUT STD_LOGIC;
		MUX_A1_ADC2		: OUT STD_LOGIC;





		SPI_CK_FE3		: OUT STD_LOGIC;
		SPI_CS_FE3		: OUT STD_LOGIC;
		SPI_SDI_FE3		: OUT STD_LOGIC;
		SPI_SDO_FE3		: IN  STD_LOGIC;
		RST_FE3			: OUT STD_LOGIC;

		SPI_SDO_ADC3	: IN STD_LOGIC;
		SPI_SDI_ADC3	: OUT STD_LOGIC;
		SPI_CS_ADC3		: OUT STD_LOGIC;
		SPI_CK_ADC3		: OUT STD_LOGIC;

		
		
		

		
		ADC3_eclk_READ	: OUT STD_LOGIC;
		ADC3_eclk_IDXL	: OUT STD_LOGIC;
		ADC3_eclk_IDXM	: OUT STD_LOGIC;
		ADC3_eclk_IDL	: OUT STD_LOGIC;
		ADC3_eclk_RST	: OUT STD_LOGIC;

		ADC3_FD			: IN STD_LOGIC_VECTOR(1 downto 0);	
		ADC3_CLK			: OUT STD_LOGIC;
		ADC3_BUSY		: IN STD_LOGIC;
		ADC3_CONV		: OUT STD_LOGIC;
		ADC3_FF			: IN STD_LOGIC;


		DAC3_SYNC		: OUT STD_LOGIC;
		DAC3_SCLK		: OUT STD_LOGIC;
		DAC3_DIN			: OUT STD_LOGIC;


		SW_TST_ADC3		: OUT STD_LOGIC;
		PWR_EN_ADC3		: OUT STD_LOGIC;
		MUX_A0_ADC3		: OUT STD_LOGIC;
		MUX_A1_ADC3		: OUT STD_LOGIC;





		SPI_SDO_FE4		: IN  STD_LOGIC;
		SPI_SDI_FE4		: OUT STD_LOGIC;
		SPI_CS_FE4		: OUT STD_LOGIC;
		SPI_CK_FE4		: OUT STD_LOGIC;
		RST_FE4			: OUT STD_LOGIC;

		SPI_CK_ADC4		: OUT STD_LOGIC;
		SPI_CS_ADC4		: OUT STD_LOGIC;
		SPI_SDI_ADC4	: OUT STD_LOGIC;
		SPI_SDO_ADC4	: IN  STD_LOGIC;

		
		

		
		ADC4_eclk_IDXL	: OUT STD_LOGIC;
		ADC4_eclk_READ	: OUT STD_LOGIC;
		ADC4_eclk_RST	: OUT STD_LOGIC;
		ADC4_eclk_IDXM	: OUT STD_LOGIC;
		ADC4_eclk_IDL	: OUT STD_LOGIC;

		ADC4_FD			: IN STD_LOGIC_VECTOR(1 downto 0);	
		ADC4_BUSY		: IN STD_LOGIC;
		ADC4_CLK			: OUT STD_LOGIC;
		ADC4_FF			: IN STD_LOGIC;
		ADC4_CONV		: OUT STD_LOGIC;



		DAC4_SYNC		: OUT STD_LOGIC;
		DAC4_SCLK		: OUT STD_LOGIC;
		DAC4_DIN			: OUT STD_LOGIC;


		MUX_A0_ADC4		: OUT STD_LOGIC;
		MUX_A1_ADC4		: OUT STD_LOGIC;
		PWR_EN_ADC4		: OUT STD_LOGIC;
		SW_TST_ADC4		: OUT STD_LOGIC


	);

end ADC_ASIC_CTST_FPGA;


architecture ADC_ASIC_CTST_FPGA_arch of ADC_ASIC_CTST_FPGA is




	component CLK_SELECT is
		port (
			inclk1x   : in  std_logic := 'X'; -- inclk1x
			inclk0x   : in  std_logic := 'X'; -- inclk0x
			clkselect : in  std_logic := 'X'; -- clkselect
			outclk    : out std_logic         -- outclk
		);
	end component CLK_SELECT;



SIGNAL	clk_125MHz 		:  STD_LOGIC;
SIGNAL	clk_200MHz 		:  STD_LOGIC;
SIGNAL	clk_100MHz		:  STD_LOGIC;
SIGNAL	clk_50MHz		:  STD_LOGIC;
SIGNAL	clk_40MHz		:  STD_LOGIC;
SIGNAL	clk_10MHz		:  STD_LOGIC;

SIGNAL	start 			:  STD_LOGIC;

SIGNAL	SYSTEM_RESET	: STD_LOGIC;	
SIGNAL	reset 			:  STD_LOGIC;

SIGNAL 	PWR_OUT_1		: STD_LOGIC;
SIGNAL 	PWR_OUT_2		: STD_LOGIC;
SIGNAL 	PWR_OUT_3		: STD_LOGIC;
SIGNAL 	PWR_OUT_4		: STD_LOGIC;

SIGNAL	ALG_RESET		: STD_LOGIC;	
SIGNAL	REG_RESET		: STD_LOGIC;	
SIGNAL	UDP_RESET		: STD_LOGIC;	


SIGNAL	UDP_LATCH		: STD_LOGIC;
SIGNAL	UDP_DATA			: STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL	UDP_FRAME_SIZE	: STD_LOGIC_VECTOR(11 DOWNTO 0);

SIGNAL	HS_DATA_ADC1	: STD_LOGIC_VECTOR(15 downto 0); 
SIGNAL	HS_LATCH_ADC1	: STD_LOGIC;	
SIGNAL	HS_DATA_ADC2	: STD_LOGIC_VECTOR(15 downto 0); 
SIGNAL	HS_LATCH_ADC2	: STD_LOGIC;	
SIGNAL	HS_DATA_ADC3	: STD_LOGIC_VECTOR(15 downto 0); 
SIGNAL	HS_LATCH_ADC3	: STD_LOGIC;	
SIGNAL	HS_DATA_ADC4	: STD_LOGIC_VECTOR(15 downto 0); 
SIGNAL	HS_LATCH_ADC4	: STD_LOGIC;	

SIGNAL	rd_strb 			:  STD_LOGIC;
SIGNAL	wr_strb 			:  STD_LOGIC;
SIGNAL	WR_address		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	RD_address		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	data 				:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	rdout 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg0_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg1_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg2_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg3_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg4_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg5_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg6_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg7_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg8_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg9_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg10_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg11_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg12_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg13_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg14_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg15_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg16_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg17_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg18_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg19_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg20_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg21_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg22_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg23_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg24_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg25_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg26_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg27_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg28_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg29_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg30_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg31_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg32_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg33_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg34_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg35_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg36_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg37_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg38_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg39_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg40_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg41_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg42_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg43_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg44_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg45_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg46_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg47_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg48_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg49_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg50_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg51_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg52_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg53_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg54_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg55_p 			:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	reg56_p			:  STD_LOGIC_VECTOR(31 downto 0);	
SIGNAL	reg57_p			:  STD_LOGIC_VECTOR(31 downto 0);	
SIGNAL	reg58_p			:  STD_LOGIC_VECTOR(31 downto 0);		
SIGNAL	reg59_p			:  STD_LOGIC_VECTOR(31 downto 0);	
SIGNAL	reg60_p			:  STD_LOGIC_VECTOR(31 downto 0);		
SIGNAL	reg61_p			:  STD_LOGIC_VECTOR(31 downto 0);	
SIGNAL	reg62_p			:  STD_LOGIC_VECTOR(31 downto 0);	
SIGNAL	reg63_p			:  STD_LOGIC_VECTOR(31 downto 0);					


SIGNAL SPI_1				: STD_LOGIC_VECTOR(143 downto 0);  
SIGNAL SPI_2				: STD_LOGIC_VECTOR(143 downto 0);  
SIGNAL SPI_3				: STD_LOGIC_VECTOR(143 downto 0);  
SIGNAL SPI_4				: STD_LOGIC_VECTOR(143 downto 0);
SIGNAL SPI_5				: STD_LOGIC_VECTOR(143 downto 0);
		
SIGNAL I2C_WR_STRB1 		: STD_LOGIC;
SIGNAL I2C_RD_STRB1 		: STD_LOGIC;

SIGNAL I2C_WR_STRB2 		: STD_LOGIC;
SIGNAL I2C_RD_STRB2 		: STD_LOGIC;

SIGNAL I2C_DEV_ADDR		: STD_LOGIC_VECTOR(7 downto 0);		
SIGNAL I2C_NUM_BYTES		: STD_LOGIC_VECTOR(3 downto 0);	  --I2C_NUM_BYTES --  For Writes 0 = address only,  1 = address + 1byte , 2 =  address + 2 bytes .... up to 4 bytes																		  --I2C_NUM_BYTES --  For Reads  0 = read 1 byte,   1 = read 1 byte,  2 = read 2 bytes  ..  up to 4 bytes
SIGNAL I2C_ADDRESS		: STD_LOGIC_VECTOR(7 downto 0);	  -- used only with WR_STRB
SIGNAL I2C_DIN				: STD_LOGIC_VECTOR(31 downto 0);   -- in
SIGNAL I2C_DOUT1			: STD_LOGIC_VECTOR(31 downto 0);	  -- OUT		
SIGNAL I2C_DOUT2			: STD_LOGIC_VECTOR(31 downto 0);	  -- OUT		

SIGNAL CHN_SELECT			: STD_LOGIC_VECTOR(7 DOWNTO 0);		
SIGNAL CHP_SELECT			: STD_LOGIC_VECTOR(7 DOWNTO 0);		
SIGNAL PWR_CNTL			: STD_LOGIC_VECTOR(3 DOWNTO 0);		
SIGNAL LED_CNTL			: STD_LOGIC_VECTOR(7 DOWNTO 0);	
SIGNAL SET_DAC				: STD_LOGIC;
SIGNAL TP_MODE_SELECT	: sTD_LOGIC_VECTOR(3 downto 0);		
SIGNAL TP_PERIOD			: STD_LOGIC_VECTOR(15 downto 0);	--true  period is  TP_PERIOD_P + TP_PERIOD_N
SIGNAL TP_SHIFT			: STD_LOGIC_VECTOR(15 downto 0);	--true  period is  TP_PERIOD_P + TP_PERIOD_N	 
SIGNAL DAC_VALUE			: STD_LOGIC_VECTOR(15 downto 0);		
SIGNAL WIB_MODE			: STD_LOGIC;
SIGNAL ADC_clk_SEL		: STD_LOGIC_VECTOR(3 downto 0);
SIGNAL LATCH_LOC_ADC1	: STD_LOGIC_VECTOR(7 downto 0); 	
SIGNAL LATCH_LOC_ADC2	: STD_LOGIC_VECTOR(7 downto 0); 	
SIGNAL LATCH_LOC_ADC3	: STD_LOGIC_VECTOR(7 downto 0); 	
SIGNAL LATCH_LOC_ADC4	: STD_LOGIC_VECTOR(7 downto 0); 
SIGNAL ADC_TST_PATT_EN	: STD_LOGIC; 
SIGNAL ADC_TST_PATT		: STD_LOGIC_VECTOR(11 downto 0); 
SIGNAL SPI_STATUS			: STD_LOGIC_VECTOR(7 DOWNTO 0);	
		
SIGNAL FE_ASIC_RESET		: STD_LOGIC;		
SIGNAL ADC_ASIC_RESET	: STD_LOGIC;	
SIGNAL SOFT_ADC_RESET 	: STD_LOGIC;	
SIGNAL WRITE_FE_SPI		: STD_LOGIC;		
SIGNAL WRITE_ADC_SPI		: STD_LOGIC;			

	
SIGNAL CLK_DIS				: STD_LOGIC_VECTOR(3 downto 0);  -- OFFSET	
SIGNAL pll_STEP0_ADC1	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP1_ADC1	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP2_ADC1	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET		
SIGNAL INV_RST_ADC1		: STD_LOGIC;							-- invert
SIGNAL OFST_RST_ADC1		: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_RST_ADC1		: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_READ_ADC1		: STD_LOGIC;							-- invert		
SIGNAL OFST_READ_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_READ_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXM_ADC1		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXM_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXM_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXL_ADC1		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXL_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXL_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDL_ADC1		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDL_f1_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f1_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL OFST_IDL_f2_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f2_ADC1	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH		
	
SIGNAL pll_STEP0_ADC2	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP1_ADC2	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP2_ADC2	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET		
SIGNAL INV_RST_ADC2		: STD_LOGIC;							-- invert
SIGNAL OFST_RST_ADC2		: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_RST_ADC2		: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_READ_ADC2		: STD_LOGIC;							-- invert		
SIGNAL OFST_READ_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_READ_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXM_ADC2		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXM_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXM_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXL_ADC2		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXL_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXL_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDL_ADC2		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDL_f1_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f1_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL OFST_IDL_f2_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f2_ADC2	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH		
	
		
SIGNAL pll_STEP0_ADC3	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP1_ADC3	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP2_ADC3	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET		
SIGNAL INV_RST_ADC3		: STD_LOGIC;							-- invert
SIGNAL OFST_RST_ADC3		: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_RST_ADC3		: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_READ_ADC3		: STD_LOGIC;							-- invert		
SIGNAL OFST_READ_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_READ_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXM_ADC3		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXM_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXM_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXL_ADC3		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXL_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXL_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDL_ADC3		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDL_f1_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f1_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL OFST_IDL_f2_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f2_ADC3	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH	

SIGNAL pll_STEP0_ADC4	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP1_ADC4	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
SIGNAL pll_STEP2_ADC4	: STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET		
SIGNAL INV_RST_ADC4		: STD_LOGIC;							-- invert
SIGNAL OFST_RST_ADC4		: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_RST_ADC4		: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_READ_ADC4		: STD_LOGIC;							-- invert		
SIGNAL OFST_READ_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_READ_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXM_ADC4		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXM_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXM_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDXL_ADC4		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDXL_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDXL_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL INV_IDL_ADC4		: STD_LOGIC;							-- invert		
SIGNAL OFST_IDL_f1_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f1_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
SIGNAL OFST_IDL_f2_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
SIGNAL WDTH_IDL_f2_ADC4	: STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH			


SIGNAL ADC_HEADER			:  STD_LOGIC_VECTOR(31 downto 0);	
SIGNAL ADC_SYNC			:  STD_LOGIC_VECTOR(7 downto 0);	
SIGNAL clk_SPD_select	: STD_LOGIC;				
SIGNAL ADC_CLK				: STD_LOGIC;				
SIGNAL STOP_ADC			: STD_LOGIC;				



SIGNAL ADC1_eclk_IDXM_i	: STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL
SIGNAL ADC1_eclk_RST_i	: STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL
SIGNAL ADC1_eclk_IDXL_i	: STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL
		
		
SIGNAL ADC2_eclk_IDXL_i	: STD_LOGIC;  -- INVERTED ON SCH need to fix in HDL
SIGNAL ADC2_eclk_READ_i	: STD_LOGIC;  -- INVERTED ON SCH need to fix in HDL






begin


sys_rst_inst : entity work.sys_rst
PORT MAP(	clk 		=> clk_40MHz,
				reset_in => SYSTEM_RESET,
				start		=> start,
				RST_OUT 	=> reset);

			
alt_pll_inst : entity work.alt_pll
	PORT MAP
	(
		inclk0		=> CLK_100MHz_OSC,
		c0				=> clk_200MHz,
		c1				=> clk_100MHZ,
		c2				=> clk_40MHz,
		c3				=> clk_10MHz
	);

	
PLL_serdes_inst : entity work.PLL_serdes
	PORT MAP
	(
		inclk0		=> CLK_100MHz_OSC,
		c0				=> clk_125MHz,
		c1				=> clk_50MHz
	);
	


CLK_SELECT_inst : CLK_SELECT
	port MAP (
		inclk1x   => clk_100MHZ,
		inclk0x   => clk_200MHZ,
		clkselect => clk_SPD_select,
		outclk    => ADC_CLK
	);



	----------- FIX BOARD LAYOUT ISSUE---------
	---------------inverted pairs------------
ADC1_eclk_IDXM	<= not ADC1_eclk_IDXM_i;
ADC1_eclk_RST	<= not ADC1_eclk_RST_i;
ADC1_eclk_IDXL	<= not ADC1_eclk_IDXL_i;
ADC2_eclk_IDXL	<= not ADC2_eclk_IDXL_i;
ADC2_eclk_READ	<= not ADC2_eclk_READ_i;
	
--------------------------------------	
	
	
	
	
OSC_CNTL1	<= '1';
OSC_CNTL2	<= '1';
OSC_CNTL3	<= '1';


SYSTEM_RESET	<= reg0_p(0);
REG_RESET		<= reg0_p(1) or reset ;
ALG_RESET		<= reg0_p(2) or reset ;
UDP_RESET		<= reg0_p(3) or reset ;


PWR_CNTL			<= reg1_p(3 downto 0);
LED_CNTL			<= reg1_p(15 downto 8);



	

WRITE_FE_SPI	<= reg2_p(0);	
WRITE_ADC_SPI	<= reg2_p(1);		

FE_ASIC_RESET	<= reg2_p(4);	
ADC_ASIC_RESET	<= reg2_p(5);		
SOFT_ADC_RESET <= reg2_p(6);	
		
--reg2_p(23 DOWNTO 16) <=  SPI_STATUS;		
	
	
CHP_SELECT		<= reg3_p(7 downto 0);	
CHN_SELECT		<= reg3_p(15 downto 8);
WIB_MODE			<= reg3_p(31);

	
	
DAC_VALUE		<= reg4_p(15 downto 0);
TP_MODE_SELECT	<= reg4_p(19 downto 16);
SET_DAC			<= reg4_p(31);

TP_PERIOD		<= reg5_p(15 downto 0);
TP_SHIFT			<= reg5_p(31 downto 16);


ADC_TST_PATT		<= reg6_p(11 downto 0);
ADC_TST_PATT_EN	<= reg6_p(16);

		
		
clk_SPD_select	<= reg7_p(8);	
		
ADC_clk_SEL		<= reg7_p(3 DOWNTO 0);

LATCH_LOC_ADC1	<= reg8_p(7 DOWNTO 0);
LATCH_LOC_ADC2	<= reg8_p(15 DOWNTO 8);
LATCH_LOC_ADC3	<= reg8_p(23 DOWNTO 16);
LATCH_LOC_ADC4	<= reg8_p(31 DOWNTO 24);


STOP_ADC			<=	reg9_p(0);	
-- reg9 HEADER CHECK + busy check


INV_RST_ADC1	<= reg10_p(0);
INV_READ_ADC1	<=	reg10_p(1);
INV_IDXM_ADC1	<= reg10_p(2);
INV_IDXL_ADC1	<= reg10_p(3);
INV_IDL_ADC1	<= reg10_p(4);
CLK_DIS(0)		<= reg10_p(5);

INV_RST_ADC2	<= reg10_p(8);
INV_READ_ADC2	<=	reg10_p(9);
INV_IDXM_ADC2	<= reg10_p(10);
INV_IDXL_ADC2	<= reg10_p(11);
INV_IDL_ADC2	<= reg10_p(12);
CLK_DIS(1)		<= reg10_p(13);

INV_RST_ADC3	<= reg10_p(16);
INV_READ_ADC3	<=	reg10_p(17);
INV_IDXM_ADC3	<= reg10_p(18);
INV_IDXL_ADC3	<= reg10_p(19);
INV_IDL_ADC3	<= reg10_p(20);
CLK_DIS(2)		<= reg10_p(21);

INV_RST_ADC4	<= reg10_p(24);
INV_READ_ADC4	<=	reg10_p(25);
INV_IDXM_ADC4	<= reg10_p(26);
INV_IDXL_ADC4	<= reg10_p(27);
INV_IDL_ADC4	<= reg10_p(28);
CLK_DIS(3)		<= reg10_p(29);

OFST_RST_ADC1		<= reg11_p(15 DOWNTO 0);
WDTH_RST_ADC1		<= reg11_p(31 DOWNTO 16);
OFST_READ_ADC1		<= reg12_p(15 DOWNTO 0);
WDTH_READ_ADC1		<= reg12_p(31 DOWNTO 16);
OFST_IDXM_ADC1		<= reg13_p(15 DOWNTO 0);
WDTH_IDXM_ADC1		<= reg13_p(31 DOWNTO 16);
OFST_IDXL_ADC1		<= reg14_p(15 DOWNTO 0);
WDTH_IDXL_ADC1		<= reg14_p(31 DOWNTO 16);
OFST_IDL_f1_ADC1	<= reg15_p(15 DOWNTO 0);
WDTH_IDL_f1_ADC1	<= reg15_p(31 DOWNTO 16);
OFST_IDL_f2_ADC1	<= reg16_p(15 DOWNTO 0);
WDTH_IDL_f2_ADC1	<= reg16_p(31 DOWNTO 16);
	
pll_STEP0_ADC1		<= reg17_p;
pll_STEP1_ADC1		<= reg18_p;
pll_STEP2_ADC1		<= reg19_p;

OFST_RST_ADC2		<= reg20_p(15 DOWNTO 0);
WDTH_RST_ADC2		<= reg20_p(31 DOWNTO 16);
OFST_READ_ADC2		<= reg21_p(15 DOWNTO 0);
WDTH_READ_ADC2		<= reg21_p(31 DOWNTO 16);
OFST_IDXM_ADC2		<= reg22_p(15 DOWNTO 0);
WDTH_IDXM_ADC2		<= reg22_p(31 DOWNTO 16);
OFST_IDXL_ADC2		<= reg23_p(15 DOWNTO 0);
WDTH_IDXL_ADC2		<= reg23_p(31 DOWNTO 16);
OFST_IDL_f1_ADC2	<= reg24_p(15 DOWNTO 0);
WDTH_IDL_f1_ADC2	<= reg24_p(31 DOWNTO 16);
OFST_IDL_f2_ADC2	<= reg25_p(15 DOWNTO 0);
WDTH_IDL_f2_ADC2	<= reg25_p(31 DOWNTO 16);
	
pll_STEP0_ADC2		<= reg26_p;
pll_STEP1_ADC2		<= reg27_p;
pll_STEP2_ADC2		<= reg28_p;	
	
OFST_RST_ADC3		<= reg29_p(15 DOWNTO 0);
WDTH_RST_ADC3		<= reg29_p(31 DOWNTO 16);
OFST_READ_ADC3		<= reg30_p(15 DOWNTO 0);
WDTH_READ_ADC3		<= reg30_p(31 DOWNTO 16);
OFST_IDXM_ADC3		<= reg31_p(15 DOWNTO 0);
WDTH_IDXM_ADC3		<= reg31_p(31 DOWNTO 16);
OFST_IDXL_ADC3		<= reg32_p(15 DOWNTO 0);
WDTH_IDXL_ADC3		<= reg32_p(31 DOWNTO 16);
OFST_IDL_f1_ADC3	<= reg33_p(15 DOWNTO 0);
WDTH_IDL_f1_ADC3	<= reg33_p(31 DOWNTO 16);
OFST_IDL_f2_ADC3	<= reg34_p(15 DOWNTO 0);
WDTH_IDL_f2_ADC3	<= reg34_p(31 DOWNTO 16);
	
pll_STEP0_ADC3		<= reg35_p;
pll_STEP1_ADC3		<= reg36_p;
pll_STEP2_ADC3		<= reg37_p;	
		
OFST_RST_ADC4		<= reg38_p(15 DOWNTO 0);
WDTH_RST_ADC4		<= reg38_p(31 DOWNTO 16);
OFST_READ_ADC4		<= reg39_p(15 DOWNTO 0);
WDTH_READ_ADC4		<= reg39_p(31 DOWNTO 16);
OFST_IDXM_ADC4		<= reg40_p(15 DOWNTO 0);
WDTH_IDXM_ADC4		<= reg40_p(31 DOWNTO 16);
OFST_IDXL_ADC4		<= reg41_p(15 DOWNTO 0);
WDTH_IDXL_ADC4		<= reg41_p(31 DOWNTO 16);
OFST_IDL_f1_ADC4	<= reg42_p(15 DOWNTO 0);
WDTH_IDL_f1_ADC4	<= reg42_p(31 DOWNTO 16);
OFST_IDL_f2_ADC4	<= reg43_p(15 DOWNTO 0);
WDTH_IDL_f2_ADC4	<= reg43_p(31 DOWNTO 16);
	
pll_STEP0_ADC4		<= reg44_p;
pll_STEP1_ADC4		<= reg45_p;
pll_STEP2_ADC4		<= reg46_p;		
	
	
	
I2C_WR_STRB1			<=  reg56_p(0);
I2C_RD_STRB1			<=	 reg56_p(1);
I2C_WR_STRB2			<=  reg56_p(2);
I2C_RD_STRB2			<=	 reg56_p(3);
I2C_NUM_BYTES			<=	 reg57_p(3 downto 0);--   : STD_LOGIC_VECTOR(3 downto 0);
I2C_ADDRESS				<=  reg57_p(15 downto 8);--	: STD_LOGIC_VECTOR(7 downto 0);
I2C_DEV_ADDR			<=  reg57_p(23 downto 16);	
I2C_DIN					<=  reg58_p;--	: STD_LOGIC_VECTOR(7 downto 0);
reg59_p 			      <=	 I2C_DOUT1; --			: STD_LOGIC_VECTOR(31 downto 0);	
reg60_p 			      <=	 I2C_DOUT2; --			: STD_LOGIC_VECTOR(31 downto 0);	
	


	
	
UDP_DATA			<=	HS_DATA_ADC1  when (CHP_SELECT = x"01") else
						HS_DATA_ADC2  when (CHP_SELECT = x"02") else
						HS_DATA_ADC3  when (CHP_SELECT = x"03") else
						HS_DATA_ADC4  when (CHP_SELECT = x"04") else
						x"0000";


UDP_LATCH 		<= HS_LATCH_ADC1  when (CHP_SELECT = x"01") else
						HS_LATCH_ADC2  when (CHP_SELECT = x"02") else		
						HS_LATCH_ADC3  when (CHP_SELECT = x"03") else		
						HS_LATCH_ADC4  when (CHP_SELECT = x"04") else
						'0';


UDP_FRAME_SIZE	<= reg63_p(11 DOWNTO 0);



PWR_CNTRL_inst : entity work.PWR_CNTRL
	PORT  MAP
	(
		clk_40MHz     		=> clk_10MHz,
		PWR_IN				=> PWR_CNTL,
		PWR_OUT_1			=> PWR_OUT_1,               
		PWR_OUT_2			=> PWR_OUT_2,                      
		PWR_OUT_3			=> PWR_OUT_3,                     
		PWR_OUT_4			=> PWR_OUT_4);



ADC_ASIC_TEST_inst1	: entity work.ADC_ASIC_TEST
PORT MAP(
		clk_200MHZ    	=> ADC_CLK,
		clk_100MHZ    	=> clk_100MHZ,
		clk_40MHZ     	=> clk_40MHZ,		
		clk_10MHZ      => clk_10MHZ,		
		reset       	=>	ALG_RESET,	
		STOP_ADC			=> STOP_ADC	,

		CHN_SELECT		=>	CHN_SELECT,
		PWR_CNTL			=>	PWR_OUT_1,
		
		LED_CNTL			=> LED_CNTL(1 downto 0),
		LED				=> LED(1 downto 0),
		SET_DAC			=> SET_DAc,
		TP_MODE_SELECT	=> TP_MODE_SELECT,
		TP_PERIOD		=> TP_PERIOD,	
		TP_SHIFT			=> TP_SHIFT,
		DAC_VALUE		=> DAC_VALUE,

		WIB_MODE			=> WIB_MODE,
		ADC_clk_SEL		=> ADC_clk_SEL(0),
		LATCH_LOC		=> LATCH_LOC_ADC1,
		ADC_TST_PATT_EN=> ADC_TST_PATT_EN,
		ADC_TST_PATT	=> ADC_TST_PATT,
		ADC_header		=> ADC_HEADER(7 downto 0),
		
		SPI_STATUS		=> SPI_STATUS(1 DOWNTO 0),
		
		FE_ASIC_RESET	=>	 FE_ASIC_RESET,
		ADC_ASIC_RESET	=> ADC_ASIC_RESET,
		SOFT_ADC_RESET => SOFT_ADC_RESET ,
		WRITE_FE_SPI	=> WRITE_FE_SPI,
		WRITE_ADC_SPI	=> WRITE_ADC_SPI,	
		FE_SPI_SDI		=> SPI_5,
		ADC_SPI_SDI		=> SPI_1,



		CLK_DIS			=> CLK_DIS(0),
		pll_STEP0		=> pll_STEP0_ADC1,
		pll_STEP1		=> pll_STEP1_ADC1,
		pll_STEP2		=> pll_STEP2_ADC1,
		INV_RST	 		=> INV_RST_ADC1,	
		OFST_RST			=> OFST_RST_ADC1,	
		WDTH_RST			=> WDTH_RST_ADC1,
		INV_READ 		=> INV_READ_ADC1,
		OFST_READ	 	=> OFST_READ_ADC1,
		WDTH_READ		=> WDTH_READ_ADC1,
		INV_IDXM			=> INV_IDXM_ADC1,	
		OFST_IDXM		=> OFST_IDXM_ADC1,	
		WDTH_IDXM		=> WDTH_IDXM_ADC1,
		INV_IDXL			=> INV_IDXL_ADC1,	
		OFST_IDXL		=> OFST_IDXL_ADC1,
		WDTH_IDXL		=> WDTH_IDXL_ADC1,
		INV_IDL			=> INV_IDL_ADC1,	
		OFST_IDL_f1		=> OFST_IDL_f1_ADC1,
		WDTH_IDL_f1		=> WDTH_IDL_f1_ADC1,
		OFST_IDL_f2		=> OFST_IDL_f2_ADC1,
		WDTH_IDL_f2		=> WDTH_IDL_f2_ADC1,
		

		ADC_eclk_READ	=> ADC1_eclk_READ,
		ADC_eclk_IDL	=> ADC1_eclk_IDL,
		ADC_eclk_IDXM	=> ADC1_eclk_IDXM_i,
		ADC_eclk_RST	=> ADC1_eclk_RST_i,
		ADC_eclk_IDXL	=> ADC1_eclk_IDXL_i,

		ADC_FD			=> ADC1_FD,
		ADC_FF			=> ADC1_FF,
		ADC_CONV			=> ADC1_CONV,	
		ADC_BUSY			=> ADC1_BUSY,	
		ADC_CLK			=> ADC1_CLK,
		
		
		
		SPI_SDO_ADC		=> SPI_SDO_ADC1,
		SPI_SDI_ADC		=> SPI_SDI_ADC1,
		SPI_CS_ADC		=> SPI_CS_ADC1,
		SPI_CK_ADC		=> SPI_CK_ADC1,

		SPI_CK_FE		=> SPI_CK_FE1,
		SPI_CS_FE		=> SPI_CS_FE1,
		SPI_SDI_FE		=> SPI_SDI_FE1,
		SPI_SDO_FE		=> SPI_SDO_FE1,
		RST_FE			=> RST_FE1,
						
		
		
		DAC_SYNC			=> DAC1_SYNC,
		DAC_SCLK			=> DAC1_SCLK,
		DAC_DIN			=> DAC1_DIN,

		MUX_A0_ADC		=> MUX_A0_ADC1,
		MUX_A1_ADC		=> MUX_A1_ADC1,
		PWR_EN_ADC		=> PWR_EN_ADC1,
		SW_TST_ADC		=> SW_TST_ADC1,
		
		HS_DATA			=> HS_DATA_ADC1,
		HS_LATCH			=> HS_LATCH_ADC1

	);

	


ADC_ASIC_TEST_inst2	: entity work.ADC_ASIC_TEST
PORT MAP(
		clk_200MHZ    	=> ADC_CLK,
		clk_100MHZ    	=> clk_100MHZ,
		clk_40MHZ     	=> clk_40MHZ,		
		clk_10MHZ      => clk_10MHZ,		
		reset       	=>	ALG_RESET,	
		STOP_ADC			=> STOP_ADC	,
		
		CHN_SELECT		=>	CHN_SELECT,
		PWR_CNTL			=>	PWR_OUT_2,
		
		LED_CNTL			=> LED_CNTL(3 downto 2),
		LED				=> LED(3 downto 2),
		SET_DAC			=> SET_DAc,
		TP_MODE_SELECT	=> TP_MODE_SELECT,
		TP_PERIOD		=> TP_PERIOD,	
		TP_SHIFT			=> TP_SHIFT,
		DAC_VALUE		=> DAC_VALUE,

		WIB_MODE			=> WIB_MODE,
		ADC_clk_SEL		=> ADC_clk_SEL(1),
		LATCH_LOC		=> LATCH_LOC_ADC2,
		ADC_TST_PATT_EN=> ADC_TST_PATT_EN,
		ADC_TST_PATT	=> ADC_TST_PATT,
		ADC_header		=>  ADC_HEADER(15 downto 8),
		
		SPI_STATUS		=> SPI_STATUS(3 DOWNTO 2),
		
		FE_ASIC_RESET	=>	FE_ASIC_RESET,
		ADC_ASIC_RESET	=> ADC_ASIC_RESET,
		SOFT_ADC_RESET => SOFT_ADC_RESET ,
		WRITE_FE_SPI	=> WRITE_FE_SPI,
		WRITE_ADC_SPI	=> WRITE_ADC_SPI,	
		FE_SPI_SDI		=> SPI_5,
		ADC_SPI_SDI		=> SPI_2,



		CLK_DIS			=> CLK_DIS(1),
		pll_STEP0		=> pll_STEP0_ADC2,
		pll_STEP1		=> pll_STEP1_ADC2,
		pll_STEP2		=> pll_STEP2_ADC2,
		INV_RST	 		=> INV_RST_ADC2,	
		OFST_RST			=> OFST_RST_ADC2,	
		WDTH_RST			=> WDTH_RST_ADC2,
		INV_READ 		=> INV_READ_ADC2,
		OFST_READ	 	=> OFST_READ_ADC2,
		WDTH_READ		=> WDTH_READ_ADC2,
		INV_IDXM			=> INV_IDXM_ADC2,	
		OFST_IDXM		=> OFST_IDXM_ADC2,	
		WDTH_IDXM		=> WDTH_IDXM_ADC2,
		INV_IDXL			=> INV_IDXL_ADC2,	
		OFST_IDXL		=> OFST_IDXL_ADC2,
		WDTH_IDXL		=> WDTH_IDXL_ADC2,
		INV_IDL			=> INV_IDL_ADC2,	
		OFST_IDL_f1		=> OFST_IDL_f1_ADC2,
		WDTH_IDL_f1		=> WDTH_IDL_f1_ADC2,
		OFST_IDL_f2		=> OFST_IDL_f2_ADC2,
		WDTH_IDL_f2		=> WDTH_IDL_f2_ADC2,
		

		ADC_eclk_READ	=> ADC2_eclk_READ_i,
		ADC_eclk_IDL	=> ADC2_eclk_IDL,
		ADC_eclk_IDXM	=> ADC2_eclk_IDXM,
		ADC_eclk_RST	=> ADC2_eclk_RST,
		ADC_eclk_IDXL	=> ADC2_eclk_IDXL_i,

		ADC_FD			=> ADC2_FD,
		ADC_FF			=> ADC2_FF,
		ADC_CONV			=> ADC2_CONV,	
		ADC_BUSY			=> ADC2_BUSY,	
		ADC_CLK			=> ADC2_CLK,
		
		
		
		SPI_SDO_ADC		=> SPI_SDO_ADC2,
		SPI_SDI_ADC		=> SPI_SDI_ADC2,
		SPI_CS_ADC		=> SPI_CS_ADC2,
		SPI_CK_ADC		=> SPI_CK_ADC2,

		SPI_CK_FE		=> SPI_CK_FE2,
		SPI_CS_FE		=> SPI_CS_FE2,
		SPI_SDI_FE		=> SPI_SDI_FE2,
		SPI_SDO_FE		=> SPI_SDO_FE2,
		RST_FE			=> RST_FE2,
						
		
		
		DAC_SYNC			=> DAC2_SYNC,
		DAC_SCLK			=> DAC2_SCLK,
		DAC_DIN			=> DAC2_DIN,

		MUX_A0_ADC		=> MUX_A0_ADC2,
		MUX_A1_ADC		=> MUX_A1_ADC2,
		PWR_EN_ADC		=> PWR_EN_ADC2,
		SW_TST_ADC		=> SW_TST_ADC2,
		
		HS_DATA			=> HS_DATA_ADC2,
		HS_LATCH			=> HS_LATCH_ADC2

	);

	


ADC_ASIC_TEST_inst3	: entity work.ADC_ASIC_TEST
PORT MAP(
		clk_200MHZ    	=> ADC_CLK,
		clk_100MHZ    	=> clk_100MHZ,
		clk_40MHZ     	=> clk_40MHZ,		
		clk_10MHZ      => clk_10MHZ,		
		reset       	=>	ALG_RESET,	
		STOP_ADC			=> STOP_ADC	,
		CHN_SELECT		=>	CHN_SELECT,
		PWR_CNTL			=>	PWR_OUT_3,
		
		LED_CNTL			=> LED_CNTL(5 downto 4),
		LED				=> LED(5 downto 4),
		SET_DAC			=> SET_DAc,
		TP_MODE_SELECT	=> TP_MODE_SELECT,
		TP_PERIOD		=> TP_PERIOD,	
		TP_SHIFT			=> TP_SHIFT,
		DAC_VALUE		=> DAC_VALUE,

		WIB_MODE			=> WIB_MODE,
		ADC_clk_SEL		=> ADC_clk_SEL(2),
		LATCH_LOC		=> LATCH_LOC_ADC3,
		ADC_TST_PATT_EN=> ADC_TST_PATT_EN,
		ADC_TST_PATT	=> ADC_TST_PATT,
		ADC_header		=> ADC_HEADER(23 downto 16),
		
		SPI_STATUS		=> SPI_STATUS(5 DOWNTO 4),
		
		FE_ASIC_RESET	=>	 FE_ASIC_RESET,
		ADC_ASIC_RESET	=> ADC_ASIC_RESET,
		SOFT_ADC_RESET => SOFT_ADC_RESET ,
		WRITE_FE_SPI	=> WRITE_FE_SPI,
		WRITE_ADC_SPI	=> WRITE_ADC_SPI,	
		FE_SPI_SDI		=> SPI_5,
		ADC_SPI_SDI		=> SPI_3,



		CLK_DIS			=> CLK_DIS(2),
		pll_STEP0		=> pll_STEP0_ADC3,
		pll_STEP1		=> pll_STEP1_ADC3,
		pll_STEP2		=> pll_STEP2_ADC3,
		INV_RST	 		=> INV_RST_ADC3,
		OFST_RST			=> OFST_RST_ADC3,	
		WDTH_RST			=> WDTH_RST_ADC3,
		INV_READ 		=> INV_READ_ADC3,
		OFST_READ	 	=> OFST_READ_ADC3,
		WDTH_READ		=> WDTH_READ_ADC3,
		INV_IDXM			=> INV_IDXM_ADC3,	
		OFST_IDXM		=> OFST_IDXM_ADC3,	
		WDTH_IDXM		=> WDTH_IDXM_ADC3,
		INV_IDXL			=> INV_IDXL_ADC3,	
		OFST_IDXL		=> OFST_IDXL_ADC3,
		WDTH_IDXL		=> WDTH_IDXL_ADC3,
		INV_IDL			=> INV_IDL_ADC3,	
		OFST_IDL_f1		=> OFST_IDL_f1_ADC3,
		WDTH_IDL_f1		=> WDTH_IDL_f1_ADC3,
		OFST_IDL_f2		=> OFST_IDL_f2_ADC3,
		WDTH_IDL_f2		=> WDTH_IDL_f2_ADC3,
		

		ADC_eclk_READ	=> ADC3_eclk_READ,
		ADC_eclk_IDL	=> ADC3_eclk_IDL,
		ADC_eclk_IDXM	=> ADC3_eclk_IDXM,
		ADC_eclk_RST	=> ADC3_eclk_RST,
		ADC_eclk_IDXL	=> ADC3_eclk_IDXL,

		ADC_FD			=> ADC3_FD,
		ADC_FF			=> ADC3_FF,
		ADC_CONV			=> ADC3_CONV,	
		ADC_BUSY			=> ADC3_BUSY,	
		ADC_CLK			=> ADC3_CLK,
		
		
		
		SPI_SDO_ADC		=> SPI_SDO_ADC3,
		SPI_SDI_ADC		=> SPI_SDI_ADC3,
		SPI_CS_ADC		=> SPI_CS_ADC3,
		SPI_CK_ADC		=> SPI_CK_ADC3,

		SPI_CK_FE		=> SPI_CK_FE3,
		SPI_CS_FE		=> SPI_CS_FE3,
		SPI_SDI_FE		=> SPI_SDI_FE3,
		SPI_SDO_FE		=> SPI_SDO_FE3,
		RST_FE			=> RST_FE3,
						
		
		
		DAC_SYNC			=> DAC3_SYNC,
		DAC_SCLK			=> DAC3_SCLK,
		DAC_DIN			=> DAC3_DIN,

		MUX_A0_ADC		=> MUX_A0_ADC3,
		MUX_A1_ADC		=> MUX_A1_ADC3,
		PWR_EN_ADC		=> PWR_EN_ADC3,
		SW_TST_ADC		=> SW_TST_ADC3,
		
		HS_DATA			=> HS_DATA_ADC3,
		HS_LATCH			=> HS_LATCH_ADC3

	);

	


ADC_ASIC_TEST_inst4	: entity work.ADC_ASIC_TEST_SKT4
PORT MAP(
		clk_200MHZ    	=> ADC_CLK,
		clk_100MHZ    	=> clk_100MHZ,
		clk_40MHZ     	=> clk_40MHZ,		
		clk_10MHZ      => clk_10MHZ,		
		reset       	=>	ALG_RESET,	
		STOP_ADC			=> STOP_ADC	,
		CHN_SELECT		=>	CHN_SELECT,
		PWR_CNTL			=>	PWR_OUT_4,
		
		LED_CNTL			=> LED_CNTL(7 downto 6),
		LED				=> LED(7 downto 6),
		SET_DAC			=> SET_DAc,
		TP_MODE_SELECT	=> TP_MODE_SELECT,
		TP_PERIOD		=> TP_PERIOD,	
		TP_SHIFT			=> TP_SHIFT,
		DAC_VALUE		=> DAC_VALUE,

		WIB_MODE			=> WIB_MODE,
		ADC_clk_SEL		=> ADC_clk_SEL(3),
		LATCH_LOC		=> LATCH_LOC_ADC4,
		ADC_TST_PATT_EN=> ADC_TST_PATT_EN,
		ADC_TST_PATT	=> ADC_TST_PATT,
		ADC_header		=>  ADC_HEADER(31 downto 24),
		
		SPI_STATUS		=> SPI_STATUS(7 DOWNTO 6),
		
		FE_ASIC_RESET	=>	FE_ASIC_RESET,
		ADC_ASIC_RESET	=> ADC_ASIC_RESET,
		SOFT_ADC_RESET => SOFT_ADC_RESET ,
		WRITE_FE_SPI	=> WRITE_FE_SPI,
		WRITE_ADC_SPI	=> WRITE_ADC_SPI,	
		FE_SPI_SDI		=> SPI_5,
		ADC_SPI_SDI		=> SPI_4,



		CLK_DIS			=> CLK_DIS(3),
		pll_STEP0		=> pll_STEP0_ADC4,
		pll_STEP1		=> pll_STEP1_ADC4,
		pll_STEP2		=> pll_STEP2_ADC4,
		INV_RST	 		=> INV_RST_ADC4,
		OFST_RST			=> OFST_RST_ADC4,	
		WDTH_RST			=> WDTH_RST_ADC4,
		INV_READ 		=> INV_READ_ADC4,
		OFST_READ	 	=> OFST_READ_ADC4,
		WDTH_READ		=> WDTH_READ_ADC4,
		INV_IDXM			=> INV_IDXM_ADC4,	
		OFST_IDXM		=> OFST_IDXM_ADC4,	
		WDTH_IDXM		=> WDTH_IDXM_ADC4,
		INV_IDXL			=> INV_IDXL_ADC4,	
		OFST_IDXL		=> OFST_IDXL_ADC4,
		WDTH_IDXL		=> WDTH_IDXL_ADC4,
		INV_IDL			=> INV_IDL_ADC4,	
		OFST_IDL_f1		=> OFST_IDL_f1_ADC4,
		WDTH_IDL_f1		=> WDTH_IDL_f1_ADC4,
		OFST_IDL_f2		=> OFST_IDL_f2_ADC4,
		WDTH_IDL_f2		=> WDTH_IDL_f2_ADC4,
		

		ADC_eclk_READ	=> ADC4_eclk_READ,
		ADC_eclk_IDL	=> ADC4_eclk_IDL,
		ADC_eclk_IDXM	=> ADC4_eclk_IDXM,
		ADC_eclk_RST	=> ADC4_eclk_RST,
		ADC_eclk_IDXL	=> ADC4_eclk_IDXL,

		ADC_FD			=> ADC4_FD,
		ADC_FF			=> ADC4_FF,
		ADC_CONV			=> ADC4_CONV,	
		ADC_BUSY			=> ADC4_BUSY,	
		ADC_CLK			=> ADC4_CLK,
		
		
		
		SPI_SDO_ADC		=> SPI_SDO_ADC4,
		SPI_SDI_ADC		=> SPI_SDI_ADC4,
		SPI_CS_ADC		=> SPI_CS_ADC4,
		SPI_CK_ADC		=> SPI_CK_ADC4,

		SPI_CK_FE		=> SPI_CK_FE4,
		SPI_CS_FE		=> SPI_CS_FE4,
		SPI_SDI_FE		=> SPI_SDI_FE4,
		SPI_SDO_FE		=> SPI_SDO_FE4,
		RST_FE			=> RST_FE4,
						
		
		
		DAC_SYNC			=> DAC4_SYNC,
		DAC_SCLK			=> DAC4_SCLK,
		DAC_DIN			=> DAC4_DIN,

		MUX_A0_ADC		=> MUX_A0_ADC4,
		MUX_A1_ADC		=> MUX_A1_ADC4,
		PWR_EN_ADC		=> PWR_EN_ADC4,
		SW_TST_ADC		=> SW_TST_ADC4,
		
		HS_DATA			=> HS_DATA_ADC4,
		HS_LATCH			=> HS_LATCH_ADC4

	);

	

	
			ADC_SYNC(0)		<=  '0' when (ADC_HEADER(2  downto 0)  = b"010") else '1';
			ADC_SYNC(1)		<=  '0' when (ADC_HEADER(7  downto 4)  = b"010") else '1';
			ADC_SYNC(2)		<=  '0' when (ADC_HEADER(10 downto 8)  = b"010") else '1';
			ADC_SYNC(3)		<=  '0' when (ADC_HEADER(14 downto 12) = b"010") else '1';
			ADC_SYNC(4)		<=  '0' when (ADC_HEADER(18 downto 16) = b"010") else '1';
			ADC_SYNC(5)		<=  '0' when (ADC_HEADER(22 downto 20) = b"010") else '1';
			ADC_SYNC(6)		<=  '0' when (ADC_HEADER(26 downto 24) = b"010") else '1';
			ADC_SYNC(7)		<=  '0' when (ADC_HEADER(30 downto 28) = b"010") else '1';

	

	
udp_io_inst1 : entity work.udp_io
PORT MAP(	SPF_OUT 				=> SFP_RX(0),
				SFP_IN 				=> SFP_TX(0),
				reset 				=> UDP_RESET,
				start 				=> start,
				BRD_IP				=> x"C0A87901",
				BRD_MAC				=> x"AABBCCDDEE10",
				clk_125MHz 			=> CLK_125M_spare,
				gxb_cal_blk_clk	=> CLK_125MHz,
				config_clk		 	=> clk_50MHz,
				CLK_IO				=> clk_100Mhz,
				FRAME_SIZE			=> UDP_FRAME_SIZE,
				tx_fifo_clk 		=> clk_100MHZ,
				tx_fifo_wr 			=> UDP_LATCH,
				tx_fifo_in 			=> UDP_DATA,
				tx_fifo_used		=> open,
				header_user_info 	=> (others => '0'),
				rdout 				=> rdout,
				system_status 		=> TST_SW4 & TST_SW3 & TST_SW2 & TST_SW1 & x"0000100",
				TIME_OUT_wait 		=> x"00001000",
				wr_strb 				=> wr_strb,
				rd_strb 				=> rd_strb,
				WR_address 			=> WR_address,
				RD_address 			=> RD_address,
				data 					=> data,
				LED					=> open);


				
				
b2v_inst2 : entity work.io_registers
PORT MAP(	Version		=> x"0103",
				rst 			=> REG_RESET,
				clk 			=> clk_100MHz,
				WR 			=> wr_strb,
				WR_address 	=> WR_address,
				RD_address 	=> RD_address,
				data 			=> data,
				data_out => rdout,
				SPI_1 	=> SPI_1,
				SPI_2 	=> SPI_2,
				SPI_3 	=> SPI_3,
				SPI_4 	=> SPI_4,
				SPI_5		=> SPI_5,
				reg0_i 	=> reg0_p,
				reg1_i	=> reg1_p,		 
				reg2_i 	=> ADC_SYNC & SPI_STATUS & reg2_p(15 DOWNTO 0),		 
				reg3_i 	=> reg3_p,	
				reg4_i 	=> reg4_p,
				reg5_i 	=> reg5_p,
				reg6_i 	=> reg6_p,
				reg7_i 	=> reg7_p,
				reg8_i 	=> reg8_p,
				reg9_i 	=> ADC_HEADER,
				reg10_i 	=> reg10_p,
				reg11_i 	=> reg11_p,
				reg12_i 	=> reg12_p,
				reg13_i 	=> reg13_p,
				reg14_i 	=> reg14_p,
				reg15_i	=> reg15_p,
				reg16_i 	=> reg16_p,
				reg17_i 	=> reg17_p,
				reg18_i 	=> reg18_p,
				reg19_i 	=> reg19_p,
				reg20_i 	=> reg20_p,
				reg21_i 	=> reg21_p,
				reg22_i 	=> reg22_p,
				reg23_i 	=> reg23_p,
				reg24_i 	=> reg24_p,
				reg25_i 	=> reg25_p,
				reg26_i 	=> reg26_p,
				reg27_i 	=> reg27_p,
				reg28_i 	=> reg28_p,
				reg29_i 	=> reg29_p,
				reg30_i 	=> reg30_p,
				reg31_i 	=> reg31_p,
				reg32_i 	=> reg32_p,
				reg33_i 	=> reg33_p,
				reg34_i 	=> reg34_p,
				reg35_i 	=> reg35_p,
				reg36_i 	=> reg36_p,
				reg37_i 	=> reg37_p,
				reg38_i 	=> reg38_p,
				reg39_i 	=> reg39_p,	
				reg40_i 	=> x"00001000",
				reg41_i 	=> x"00001000",
				reg42_i 	=> x"00001000",
				reg43_i 	=> x"00001000",
				reg44_i 	=> x"00001000",
				reg45_i 	=> x"00001000",
				reg46_i 	=> x"00001000",
				reg47_i 	=> x"00001000",
				reg48_i 	=> x"00001000",
				reg49_i 	=> x"00001000",
				reg50_i 	=> x"00001000",
				reg51_i 	=> x"00001000",
				reg52_i 	=> x"00001000",
				reg53_i 	=> x"00001000",
				reg54_i 	=> x"00001000",
				reg55_i 	=> x"00001000",
				reg56_i 	=> reg56_p,
				reg57_i 	=> reg57_p,
				reg58_i 	=> reg58_p,
				reg59_i 	=> I2C_DOUT1,
				reg60_i 	=> I2C_DOUT2,
				reg61_i 	=> reg61_p,
				reg62_i 	=> reg62_p,
				reg63_i 	=> reg63_p,
				reg0_o => reg0_p,
				reg1_o => reg1_p,				
				reg2_o => reg2_p,		
				reg3_o => reg3_p,		
				reg4_o => reg4_p,
				reg5_o => reg5_p,
				reg6_o => reg6_p,
				reg7_o => reg7_p,
				reg8_o => reg8_p,
				reg9_o => reg9_p,		
				reg10_o => reg10_p,
				reg11_o => reg11_p,
				reg12_o => reg12_p,
				reg13_o => reg13_p,
				reg14_o => reg14_p,
				reg15_o => reg15_p,
				reg16_o => reg16_p,
				reg17_o => reg17_p,
				reg18_o => reg18_p,
				reg19_o => reg19_p,
				reg20_o => reg20_p,
				reg21_o => reg21_p,
				reg22_o => reg22_p,
				reg23_o => reg23_p,
				reg24_o => reg24_p,
				reg25_o => reg25_p,
				reg26_o => reg26_p,
				reg27_o => reg27_p,
				reg28_o => reg28_p,
				reg29_o => reg29_p,
				reg30_o => reg30_p,
				reg31_o => reg31_p,
				reg32_o => reg32_p,
				reg33_o => reg33_p,
				reg34_o => reg34_p,
				reg35_o => reg35_p,
				reg36_o => reg36_p,
				reg37_o => reg37_p,
				reg38_o => reg38_p,
				reg39_o => reg39_p,
				reg40_o => reg40_p,
				reg41_o => reg41_p,
				reg42_o => reg42_p,
				reg43_o => reg43_p,
				reg44_o => reg44_p,
				reg45_o => reg45_p,
				reg46_o => reg46_p,
				reg47_o => reg47_p,
				reg48_o => reg48_p,
				reg49_o => reg49_p,
				reg50_o => reg50_p,
				reg51_o => reg51_p,
				reg52_o => reg52_p,
				reg53_o => reg53_p,
				reg54_o => reg54_p,
				reg55_o => reg55_p,				
				reg56_o => reg56_p,
				reg57_o => reg57_p,
				reg58_o => reg58_p,
				reg59_o => open,
				reg60_o => open,
				reg61_o => reg61_p,
				reg62_o => reg62_p,
				reg63_o => reg63_p);
	

	
	I2c_master1_inst  : entity work.I2c_master
	PORT MAP
	(
		rst   	   	=> ALG_RESET,  		
		sys_clk	   	=> clk_40Mhz,
		SCL_O         	=> INA_SCL,
		SDA         	=> INA_SDA,					
		I2C_WR_STRB 	=> I2C_WR_STRB1,
		I2C_RD_STRB 	=> I2C_RD_STRB1,
		I2C_DEV_ADDR	=> I2C_DEV_ADDR(6 downto 0),
		I2C_NUM_BYTES	=> I2C_NUM_BYTES,	
		I2C_ADDRESS		=> I2C_ADDRESS,  -- used only with WR_STRB
		I2C_DOUT			=> I2C_DOUT1,
		I2C_DIN			=> I2C_DIN,
		I2C_BUSY       => open,
		I2C_DEV_AVL		=> open
	);
				
	I2c_master2_inst  : entity work.I2c_master
	PORT MAP
	(
		rst   	   	=> ALG_RESET,  		
		sys_clk	   	=> clk_40Mhz,
		SCL_O         	=> INB_SCL,
		SDA         	=> INB_SDA,					
		I2C_WR_STRB 	=> I2C_WR_STRB2,
		I2C_RD_STRB 	=> I2C_RD_STRB2,
		I2C_DEV_ADDR	=> I2C_DEV_ADDR(6 downto 0),
		I2C_NUM_BYTES	=> I2C_NUM_BYTES,	
		I2C_ADDRESS		=> I2C_ADDRESS,  -- used only with WR_STRB
		I2C_DOUT			=> I2C_DOUT2,
		I2C_DIN			=> I2C_DIN,
		I2C_BUSY       => open,
		I2C_DEV_AVL		=> open		

	);

		
end ADC_ASIC_CTST_FPGA_arch;
