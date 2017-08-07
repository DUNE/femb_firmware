--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: ADC_ASIC_TEST.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 06/05/2017
--////  Description:  ADC ASIC CHIP TESTER
--////					
--////
--/////////////////////////////////////////////////////////////////////
--////
--//// Copyright (C) 2017 Brookhaven National Laboratory
--////
--/////////////////////////////////////////////////////////////////////


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;
use work.StdRtlPkg.all;


--  Entity Declaration

ENTITY ADC_ASIC_TEST IS

	PORT
	(	clk_200MHZ    	: IN STD_LOGIC;	-- 80MHz  
		clk_100MHZ    	: IN STD_LOGIC;	-- 80MHz  
		clk_40MHZ     	: IN STD_LOGIC;	-- 80MHz  		
		clk_10MHZ     	: IN STD_LOGIC;	-- 10MHz  		
		reset       	: IN STD_LOGIC;			
		STOP_ADC			: IN STD_LOGIC;			
		CHN_SELECT		: IN STD_LOGIC_VECTOR(7 DOWNTO 0);	
		PWR_CNTL			: IN  STD_LOGIC;
		LED_CNTL			: IN  STD_LOGIC_VECTOR(1 DOWNTO 0);	
		LED				: OUT  STD_LOGIC_VECTOR(1 DOWNTO 0);	

		SET_DAC			: in  std_logic;
		TP_MODE_SELECT	: in  std_logic_vector(3 downto 0);
		TP_PERIOD		: in  std_logic_vector(15 downto 0);	--true  period is  TP_PERIOD_P + TP_PERIOD_N
		TP_SHIFT			: in  std_logic_vector(15 downto 0);	--true  period is  TP_PERIOD_P + TP_PERIOD_N	 
		DAC_VALUE		: in  std_logic_vector(15 downto 0);		

		WIB_MODE			: IN STD_LOGIC;
		LATCH_LOC		: IN STD_LOGIC_VECTOR(7 downto 0); 		
		ADC_clk_SEL		: IN STD_LOGIC;
		ADC_TST_PATT_EN: IN STD_LOGIC; 
		ADC_TST_PATT	: IN STD_LOGIC_VECTOR(11 downto 0); 
		ADC_header		: OUT STD_LOGIC_VECTOR(7 downto 0);
		SPI_STATUS		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);		
		
		FE_ASIC_RESET	: IN STD_LOGIC;		
		ADC_ASIC_RESET	: IN STD_LOGIC;	
		SOFT_ADC_RESET : IN STD_LOGIC;	
		WRITE_FE_SPI	: IN STD_LOGIC;		
		WRITE_ADC_SPI	: IN STD_LOGIC;	
		FE_SPI_SDI		: IN  STD_LOGIC_VECTOR(143 downto 0);	
		ADC_SPI_SDI		: IN  STD_LOGIC_VECTOR(143 downto 0);		


		CLK_DIS			: IN STD_LOGIC;		
		pll_STEP0		: IN STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
		pll_STEP1		: IN STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET
		pll_STEP2		: IN STD_LOGIC_VECTOR(31 downto 0);  -- OFFSET		
		INV_RST	 		: IN STD_LOGIC;							-- invert
		OFST_RST			: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_RST			: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		INV_READ 		: IN STD_LOGIC;							-- invert		
		OFST_READ	 	: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_READ		: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		INV_IDXM			: IN STD_LOGIC;							-- invert		
		OFST_IDXM		: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_IDXM		: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		INV_IDXL			: IN STD_LOGIC;							-- invert		
		OFST_IDXL		: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_IDXL		: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		INV_IDL			: IN STD_LOGIC;							-- invert		
		OFST_IDL_f1		: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_IDL_f1		: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		OFST_IDL_f2		: IN STD_LOGIC_VECTOR(15 downto 0);  -- OFFSET
		WDTH_IDL_f2		: IN STD_LOGIC_VECTOR(15 downto 0);  -- WIDTH
		

		ADC_eclk_READ	: OUT  STD_LOGIC;
		ADC_eclk_IDL	: OUT  STD_LOGIC;
		ADC_eclk_IDXM	: OUT  STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL
		ADC_eclk_RST	: OUT  STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL
		ADC_eclk_IDXL	: OUT  STD_LOGIC; -- INVERTED ON SCH  need to fix in HDL

		ADC_FD			: IN STD_LOGIC_VECTOR(1 downto 0);	
		ADC_FF			: IN  STD_LOGIC;
		ADC_CONV			: OUT STD_LOGIC;
		ADC_BUSY			: IN  STD_LOGIC;
		ADC_CLK			: OUT STD_LOGIC;
		
		
		
		SPI_SDO_ADC		: IN   STD_LOGIC;
		SPI_SDI_ADC		: OUT  STD_LOGIC;
		SPI_CS_ADC		: OUT  STD_LOGIC;
		SPI_CK_ADC		: OUT  STD_LOGIC;

		SPI_CK_FE		: OUT  STD_LOGIC;
		SPI_CS_FE		: OUT  STD_LOGIC;
		SPI_SDI_FE		: OUT  STD_LOGIC;
		SPI_SDO_FE		: IN   STD_LOGIC;
		RST_FE			: OUT  STD_LOGIC;
						
		
		
		DAC_SYNC			: OUT STD_LOGIC;
		DAC_SCLK			: OUT STD_LOGIC;
		DAC_DIN			: OUT STD_LOGIC;

		MUX_A0_ADC		: OUT STD_LOGIC;
		MUX_A1_ADC		: OUT STD_LOGIC;
		PWR_EN_ADC		: OUT STD_LOGIC;
		SW_TST_ADC		: OUT STD_LOGIC;		
		
		HS_DATA			: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		HS_LATCH			: OUT STD_LOGIC

	);
END ADC_ASIC_TEST;


ARCHITECTURE behavior OF ADC_ASIC_TEST IS




	signal 	ADC_SPI_RB		: STD_LOGIC_VECTOR(143 downto 0);  	
	signal 	FE_SPI_RB		: STD_LOGIC_VECTOR(143 downto 0);  		
	signal	MUX_A				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal	SPI_WORKING 	: STD_LOGIC;
	
	signal	SPI_SDO_ADC_r	: STD_LOGIC;
	signal	SPI_SDI_ADC_r	: STD_LOGIC;
	signal	SPI_CS_ADC_r	: STD_LOGIC;
	signal	SPI_CK_ADC_r	: STD_LOGIC;

	signal	SPI_CK_FE_r		: STD_LOGIC;
	signal	SPI_CS_FE_r		: STD_LOGIC;
	signal	SPI_SDI_FE_r	: STD_LOGIC;
	signal	SPI_SDO_FE_r	: STD_LOGIC;
	signal	RST_FE_r			: STD_LOGIC;
						
				
	signal	DAC_SYNC_r		: STD_LOGIC;
	signal	DAC_SCLK_r		: STD_LOGIC;
	signal	DAC_DIN_r		: STD_LOGIC;

	signal	MUX_A0_ADC_r	: STD_LOGIC;
	signal	MUX_A1_ADC_r	: STD_LOGIC;
	signal	PWR_EN_ADC_r	: STD_LOGIC;
	signal	SW_TST_ADC_r	: STD_LOGIC;	
	
	signal	ADC_CONV_i		: STD_LOGIC;	
   signal 	BIT_CNT	 		: STD_LOGIC_VECTOR(7 downto 0);	
	signal	INT_DAC_CNTL	: STD_LOGIC;	
	
	
begin






		ADC_CLK		<= clk_200MHZ WHEN (ADC_clk_SEL= '0') ELSE NOT clk_200MHZ;
		
		LED			<=	LED_CNTL;
		
		SPI_STATUS(0)	<= '1' when (ADC_SPI_RB = ADC_SPI_SDI) else	
								'0';
		SPI_STATUS(1)	<= '1' when (FE_SPI_RB = FE_SPI_SDI) else	
								'0';
				

		PWR_EN_ADC		<= PWR_CNTL;
		SW_TST_ADC		<= SW_TST_ADC_r	when  (PWR_CNTL = '1') else '0';		
		SPI_SDI_ADC		<= SPI_SDI_ADC_r	when  (PWR_CNTL = '1') else '0';		
		SPI_CS_ADC		<= SPI_CS_ADC_r	when  (PWR_CNTL = '1') else '0';		
		SPI_CK_ADC		<= SPI_CK_ADC_r	when  (PWR_CNTL = '1') else '0';		

		SPI_CK_FE		<= INT_DAC_CNTL 	when  (PWR_CNTL = '1')  and (SPI_WORKING = '0') else
								SPI_CK_FE_r	 	when  (PWR_CNTL = '1') else '0';	
		SPI_CS_FE		<= SPI_CS_FE_r	 	when  (PWR_CNTL = '1') else '0';		
		SPI_SDI_FE		<= SPI_SDI_FE_r 	when  (PWR_CNTL = '1') else '0';		
		RST_FE			<= RST_FE_r	 		when  (PWR_CNTL = '1') else '0';		
		DAC_SYNC			<= DAC_SYNC_r		when  (PWR_CNTL = '1') else '0';		
		DAC_SCLK			<= DAC_SCLK_r		when  (PWR_CNTL = '1') else '0';		
		DAC_DIN			<= DAC_DIN_r		when  (PWR_CNTL = '1') else '0';		
		MUX_A0_ADC		<= MUX_A(0)	 		when  (PWR_CNTL = '1') else '0';		
		MUX_A1_ADC		<= MUX_A(1)	 		when  (PWR_CNTL = '1') else '0';		
	
	


ADC_PULSE_GEN_inst : entity work.ADC_PULSE_GEN
	PORT MAP
	(
	 	 clk_100MHZ    	    	=> clk_100MHZ,
	 	 clk_10MHz    		     	=> clk_10MHz,
		 PULSE_SYNC					=> ADC_CONV_i,
		 reset			         => reset,               
		 SET_DAC						=> SET_DAC,
		 TP_MODE_SELECT			=> TP_MODE_SELECT,
		 TP_PERIOD					=> TP_PERIOD,	
		 TP_SHIFT					=> TP_SHIFT,		
		 DAC_VALUE					=> DAC_VALUE,
		 DAC_SCLK					=> DAC_SCLK_r,
		 DAC_DIN						=> DAC_DIN_r,
		 DAC_SYNC					=> DAC_SYNC_r,
		 MUX_A						=> MUX_A,		 
		SW_TST_ADC					=> SW_TST_ADc_r,
		 INT_DAC_CNTL				=> INT_DAC_CNTL
	);


	
	
ADC_ASIC_SPI_INST : entity work.ADC_ASIC_SPI
	PORT MAP
	(
		reset     		=> reset,
		clk	    		=>	clk_40MHz,
		ADC_SPI_SDI		=> ADC_SPI_SDI,		
		ADC_SPI_RB		=> ADC_SPI_RB,		
		ADC_ASIC_RESET	=> ADC_ASIC_RESET,
		SOFT_ADC_RESET => SOFT_ADC_RESET,
		WRITE_ADC_SPI	=> WRITE_ADC_SPI,
		ASIC_ADC_CS		=> SPI_CS_ADC_r,
		ASIC_ADC_CK		=> SPI_CK_ADC_r,
		ASIC_ADC_SDI	=> SPI_SDI_ADC_r,
		ASIC_ADC_SDO	=> SPI_SDO_ADC,
		SPI_WORKING		=> open
	);		
	
	
FE_ASIC_SPI_INST : entity work.FE_ASIC_SPI
	PORT MAP
	(
		reset     		=> reset,
		clk	    		=>	clk_40MHz,
		FE_SPI_SDI		=> FE_SPI_SDI,		
		FE_SPI_RB		=> FE_SPI_RB,		
		FE_ASIC_RESET	=> FE_ASIC_RESET,
		WRITE_FE_SPI	=> WRITE_FE_SPI,
		ASIC_FE_CS		=> SPI_CS_FE_r,
		ASIC_FE_RST		=> RST_FE_r,
		ASIC_FE_CK		=> SPI_CK_FE_r,
		ASIC_FE_SDI		=> SPI_SDI_FE_r,
		ASIC_FE_SDO		=> SPI_SDO_FE,
		SPI_WORKING		=> SPI_WORKING
	);	


	
ADC_ASIC_RDOUT_v3_inst : entity work.ADC_ASIC_RDOUT_v3
	PORT MAP
	(
			clk_200Mhz		=> clk_200MHZ,
			clk_sys			=> clk_100MHZ,	
			sys_rst 			=> reset,
			WIB_MODE			=> WIB_MODE,
			ADC_FD			=> ADC_FD,
			ADC_BUSY			=> ADC_BUSY,
			CHN_select		=> CHN_SELECT,	
			LATCH_LOC		=> LATCH_LOC,							
			ADC_TST_PATT_EN=> ADC_TST_PATT_EN,
			ADC_TST_PATT	=> ADC_TST_PATT,
			ADC_header_out =>	ADC_header,			
			ADC_CONV			=> ADC_CONV_i,	
			UDP_DATA_LATCH => HS_LATCH,
			UDP_DATA_OUT 	=> HS_DATA
	);
	 	
		
  process(clk_200MHZ,reset,STOP_ADC  ) 
  begin
	 if (reset = '1' or STOP_ADC  = '1' ) then
		ADC_CONV_i	<= '0';
		BIT_CNT		<= x"00";
     elsif (clk_200MHZ'event AND clk_200MHZ = '1') then
			BIT_CNT		<= BIT_CNT + 1;		
			if (BIT_CNT >= x"30") then
				ADC_CONV_i	<= '0';
			else
				ADC_CONV_i	<= '1';
			end if;
			if (BIT_CNT >= x"63")  then  
					BIT_CNT		<= x"00";
			end if;
	 end if;
end process;	

	
	ADC_CONV <= ADC_CONV_i;
	
	
	ProtoDUNE_ADC_clk_gen_INST1 : ENTITY WORK.ProtoDUNE_ADC_clk_gen
	PORT MAP
	(
		sys_rst     	=> reset,  
		clk_200MHz	 	=> clk_200MHZ,
		sys_clk 			=> clk_100MHZ,
		
		pll_STEP0		=> pll_STEP0,
		pll_STEP1		=> pll_STEP1, 
		pll_STEP2		=> pll_STEP2,
		CLK_DIS			=> CLK_DIS,
		ADC_CONV			=> ADC_CONV_i,
		INV_RST	 		=> INV_RST,
		OFST_RST			=> OFST_RST,
		WDTH_RST			=> WDTH_RST,

		INV_READ 		=> INV_READ,
		OFST_READ	 	=> OFST_READ,
		WDTH_READ	 	=> WDTH_READ,

		INV_IDXM		 	=> INV_IDXM,
		OFST_IDXM		=> OFST_IDXM,
		WDTH_IDXM	 	=> WDTH_IDXM,

		INV_IDXL		 	=> INV_IDXL,
		OFST_IDXL	 	=> OFST_IDXL,
		WDTH_IDXL	 	=> WDTH_IDXL,
	
		INV_IDL		 	=> INV_IDL,
		OFST_IDL_f1	 	=> OFST_IDL_f1,
		WDTH_IDL_f1	 	=> WDTH_IDL_f1,
		OFST_IDL_f2	 	=> OFST_IDL_f2,
		WDTH_IDL_f2	 	=> WDTH_IDL_f2,

		
		ADC_RST			=> ADC_eclk_RST,
		ADC_IDXM			=> ADC_eclk_IDXM,
		ADC_IDL			=> ADC_eclk_IDL,
		ADC_READ			=> ADC_eclk_READ,
		ADC_IDXL			=> ADC_eclk_IDXL	
	
	);
		
	
	

	
	
END behavior;
