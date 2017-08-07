--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: SBND_RDOUT_V1.VHD          
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 10/01/2014
--////  Description:  LBNE_ASIC_RDOUT
--////					
--////
--/////////////////////////////////////////////////////////////////////
--////
--//// Copyright (C) 2016 Brookhaven National Laboratory
--////
--/////////////////////////////////////////////////////////////////////

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE work.SbndPkg.all;

--  Entity Declaration

ENTITY SBND_RDOUT_V1 IS

	PORT
	(
		sys_rst     	: IN STD_LOGIC;				-- reset		
		TS_RESET			: IN STD_LOGIC;				-- reset		
		clk_200Mhz    	: IN STD_LOGIC;				-- clock
		clk_sys	    	: IN STD_LOGIC;				-- system clock 
		clk_TS	    	: IN STD_LOGIC;				-- timestamp clock 

		
		NOVA_TIME_SYNC			: IN STD_LOGIC;				-- NOVA_SYNC_ADC		
		LBNE_ADC_RST			: IN STD_LOGIC;				-- LBNE_SYNC_ADC				
		
		ADC_MODE			: IN STD_LOGIC;				
		CLK_select		: IN STD_LOGIC_VECTOR(7 downto 0); 		
		CHP_select		: IN STD_LOGIC_VECTOR(7 downto 0); 	
		CHN_select		: IN STD_LOGIC_VECTOR(7 downto 0); 
		TST_PATT_EN		: IN STD_LOGIC_VECTOR(7 downto 0); 
		TST_PATT			: IN STD_LOGIC_VECTOR(11 downto 0);
		Header_P_event	: IN STD_LOGIC_VECTOR(7 downto 0); 	-- Number of events packed per header  
		
		LATCH_LOC_0		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_1		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_2		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_3		: IN STD_LOGIC_VECTOR(7 downto 0); 
		LATCH_LOC_4		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_5		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_6		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_7		: IN STD_LOGIC_VECTOR(7 downto 0);
		
		ADC_SYNC			: OUT STD_LOGIC_VECTOR(7 downto 0);	-- LVDS		USE TO BE ADC_RCK_L
		
		TP_SYNC			: OUT STD_LOGIC;		
		ADC_FD_0			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_1			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_2			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_3			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS		
		ADC_FD_4			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_5			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_6			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_7			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS				
		
		ADC_F_CLK		: IN  STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	 USE TO BE ADC_FD_x
		ADC_FF			: IN  STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
		ADC_FE			: IN  STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
		ADC_CLK			: OUT STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
	
	
	
		EN_TST_MODE 	: IN STD_LOGIC;
		OUT_of_SYNC	 	: OUT STD_LOGIC_VECTOR(15 downto 0);		
		DATA_VALID		: OUT STD_LOGIC;		
		LANE1_DATA		: OUT STD_LOGIC_VECTOR(15 downto 0);
		LANE2_DATA		: OUT STD_LOGIC_VECTOR(15 downto 0);
		LANE3_DATA		: OUT STD_LOGIC_VECTOR(15 downto 0);		
		LANE4_DATA		: OUT STD_LOGIC_VECTOR(15 downto 0);	

		UDP_TST_LATCH	: OUT STD_LOGIC;		
		UDP_TST_DATA	: OUT STD_LOGIC_VECTOR(15 downto 0)
		
	);
	
	END SBND_RDOUT_V1;

ARCHITECTURE behavior OF SBND_RDOUT_V1 IS

 

COMPONENT SBND_ASIC_RDOUT_V1

	PORT
	(
		clk_200Mhz    	: IN STD_LOGIC;				-- clock
		clk_sys	    	: IN STD_LOGIC;				-- system clock 
		sys_rst     	: IN STD_LOGIC;				-- reset	
		ADC_MODE			: IN STD_LOGIC;					
		CHN_select		: IN STD_LOGIC_VECTOR(7 downto 0); 
		LATCH_LOC		: IN STD_LOGIC_VECTOR(7 downto 0); 		
		ADC_FD			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FE			: IN STD_LOGIC;	-- LVDS
		ADC_TST_PATT_EN: IN STD_LOGIC; 
		ADC_TST_PATT	: IN STD_LOGIC_VECTOR(11 downto 0); 
		ADC_SYNC		 	: OUT STD_LOGIC;							-- LATCH FIFO DATA IN TO SHIFT REGISTER	
		ADC_header_out	: OUT STD_LOGIC_VECTOR(7 downto 0);
		HS_DATA_LATCH 	: OUT STD_LOGIC;
		DATA_OUT	 		: OUT STD_LOGIC_VECTOR(15 downto 0);
		ADCData        : OUT ADC_array(0 to 15)	
	);

END COMPONENT;

   constant pat_1 : STD_LOGIC_VECTOR(2 downto 0) := b"010";

 
	type 		state_type2 	is (S_IDLE,  S_DATA);
	signal 	state_D			: state_type2;
   SIGNAL 	Header_cnt		:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	DVALID			:	STD_LOGIC;
	SIGNAL	TST_DATA_LATCH	:	STD_LOGIC;
	SIGNAL 	TIME_STAMP		:  STD_LOGIC_VECTOR(31 downto 0);  
	SIGNAL	TST_DATA			:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_LATCHd		:  STD_LOGIC;
	SIGNAL	TST_LATCH		:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	TST_DATA0		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_DATA1		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_DATA2		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_DATA3		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_DATA4		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_DATA5		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_DATA6		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL	TST_DATA7		:  STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL 	CLK_select_s	: 	STD_LOGIC_VECTOR(7 downto 0); 		
	SIGNAL 	CHP_select_s	: 	STD_LOGIC_VECTOR(7 downto 0); 	
	
	SIGNAL	ADC_header_0	:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_header_1	:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_header_2	:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_header_3	:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_header_4	:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_header_5	:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_header_6	:  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_header_7	:  STD_LOGIC_VECTOR(7 downto 0);

	SIGNAL	ADCData_L0	   :  ADC_array(0 to 15);		
	SIGNAL	ADCData_L1	   :  ADC_array(0 to 15);	
	SIGNAL	ADCData_L2	   :  ADC_array(0 to 15);	
	SIGNAL	ADCData_L3	   :  ADC_array(0 to 15);	
	SIGNAL	ADCData_L4	   :  ADC_array(0 to 15);		
	SIGNAL	ADCData_L5	   :  ADC_array(0 to 15);	
	SIGNAL	ADCData_L6	   :  ADC_array(0 to 15);	
	SIGNAL	ADCData_L7	   :  ADC_array(0 to 15);	
	SIGNAL	ADC_SYNC_0		:	STD_LOGIC;
	SIGNAL	ADC_SYNC_CLK	:	STD_LOGIC;
	
--	SIGNAL	DATA_PACK_A1A	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A2A	:  STD_LOGIC_VECTOR(95 downto 0);		
--	SIGNAL	DATA_PACK_A3A	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A4A	:  STD_LOGIC_VECTOR(95 downto 0);		
--	SIGNAL	DATA_PACK_A5A	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A6A	:  STD_LOGIC_VECTOR(95 downto 0);		
--	SIGNAL	DATA_PACK_A7A	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A8A	:  STD_LOGIC_VECTOR(95 downto 0);			
--	SIGNAL	DATA_PACK_A1B	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A2B	:  STD_LOGIC_VECTOR(95 downto 0);		
--	SIGNAL	DATA_PACK_A3B	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A4B	:  STD_LOGIC_VECTOR(95 downto 0);		
--	SIGNAL	DATA_PACK_A5B	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A6B	:  STD_LOGIC_VECTOR(95 downto 0);		
--	SIGNAL	DATA_PACK_A7B	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	DATA_PACK_A8B	:  STD_LOGIC_VECTOR(95 downto 0);	
--	SIGNAL	data_sel			:  STD_LOGIC_VECTOR(7 downto 0);	
--	SIGNAL	HEADER_A			:  STD_LOGIC_VECTOR(15 downto 0);	
--	SIGNAL	HEADER_B			:  STD_LOGIC_VECTOR(15 downto 0);	
--	SIGNAL	HEADER_C			:  STD_LOGIC_VECTOR(15 downto 0);	
--	SIGNAL	HEADER_D			:  STD_LOGIC_VECTOR(15 downto 0);	

--	SIGNAL	SYNC_TO_SYSTEM	:	STD_LOGIC;	
--	SIGNAL	NOVA_TIME_SYNC_dly :	STD_LOGIC;
	
begin

			  		  
			  process(clk_sys) 	
			  begin
				if (clk_sys'event AND clk_sys = '1') then		
						CLK_select_s	<= CLK_select;
						CHP_select_s	<= CHP_select;
				end if;
			end process;	


			  process(clk_TS) 	
			  begin
				if (clk_TS'event AND clk_TS = '1') then		
					if(TS_RESET	 = '1') THEN 
						TIME_STAMP <= x"00000000";
					else
						TIME_STAMP <= TIME_STAMP + 1;
					end if;
				end if;
			end process;	
			
			
			UDP_TST_DATA	<= TST_DATA;
			UDP_TST_LATCH	<= TST_LATCHd;
			LANE1_DATA	<= TST_DATA;
			LANE2_DATA	<= TST_DATA;
			LANE3_DATA	<= TST_DATA;
			LANE4_DATA	<= TST_DATA;
			DATA_VALID	<= TST_LATCHd;
		
		
		
			ADC_SYNC_CLK	<= clk_200Mhz;
			ADC_CLK(0)		<= ADC_SYNC_CLK when (CLK_select_s(0) = '0') else not ADC_SYNC_CLK ;		
			ADC_CLK(1)		<= ADC_SYNC_CLK when (CLK_select_s(1) = '0') else not ADC_SYNC_CLK ;	
			ADC_CLK(2)		<= ADC_SYNC_CLK when (CLK_select_s(2) = '0') else not ADC_SYNC_CLK ;		
			ADC_CLK(3)		<= ADC_SYNC_CLK when (CLK_select_s(3) = '0') else not ADC_SYNC_CLK ;		
			ADC_CLK(4)		<= ADC_SYNC_CLK when (CLK_select_s(4) = '0') else not ADC_SYNC_CLK ;			
			ADC_CLK(5)		<= ADC_SYNC_CLK when (CLK_select_s(5) = '0') else not ADC_SYNC_CLK ;	
			ADC_CLK(6)		<= ADC_SYNC_CLK when (CLK_select_s(6) = '0') else not ADC_SYNC_CLK ;		
			ADC_CLK(7)		<= ADC_SYNC_CLK when (CLK_select_s(7) = '0') else not ADC_SYNC_CLK ;					
			
	
			TST_DATA 	<= TST_DATA0 when (CHP_select_s = x"0") else
									TST_DATA1 when (CHP_select_s = x"1") else
									TST_DATA2 when (CHP_select_s = x"2") else
									TST_DATA3 when (CHP_select_s = x"3") else																
									TST_DATA4 when (CHP_select_s = x"4") else
									TST_DATA5 when (CHP_select_s = x"5") else
									TST_DATA6 when (CHP_select_s = x"6") else
									TST_DATA7 when (CHP_select_s = x"7") else
									x"0000";

								
			TST_LATCHd	<= TST_LATCH(0) when (CHP_select_s = x"0") else
									TST_LATCH(1) when (CHP_select_s = x"1") else
									TST_LATCH(2) when (CHP_select_s = x"2") else
									TST_LATCH(3) when (CHP_select_s = x"3") else
									TST_LATCH(4) when (CHP_select_s = x"4") else
									TST_LATCH(5) when (CHP_select_s = x"5") else
									TST_LATCH(6) when (CHP_select_s = x"6") else
									TST_LATCH(7) when (CHP_select_s = x"7") else
									'0';
									
			
			OUT_of_SYNC(0)		<=  '0' when (ADC_header_0(2  downto 0)  = pat_1) else '1';
			OUT_of_SYNC(1)		<=  '0' when (ADC_header_0(6  downto 4)  = pat_1) else '1';
			OUT_of_SYNC(2)		<=  '0' when (ADC_header_1(2 downto 0)  = pat_1) else '1';
			OUT_of_SYNC(3)		<=  '0' when (ADC_header_1(6 downto 4) = pat_1) else '1';
			OUT_of_SYNC(4)		<=  '0' when (ADC_header_2(2  downto 0)  = pat_1) else '1';
			OUT_of_SYNC(5)		<=  '0' when (ADC_header_2(6  downto 4)  = pat_1) else '1';
			OUT_of_SYNC(6)		<=  '0' when (ADC_header_3(2 downto 0)  = pat_1) else '1';
			OUT_of_SYNC(7)		<=  '0' when (ADC_header_3(6 downto 4) = pat_1) else '1';
			OUT_of_SYNC(8)		<=  '0' when (ADC_header_4(2  downto 0)  = pat_1) else '1';
			OUT_of_SYNC(9)		<=  '0' when (ADC_header_4(6  downto 4)  = pat_1) else '1';
			OUT_of_SYNC(10)	<=  '0' when (ADC_header_5(2 downto 0)  = pat_1) else '1';
			OUT_of_SYNC(11)	<=  '0' when (ADC_header_5(6 downto 4) = pat_1) else '1';
			OUT_of_SYNC(12)	<=  '0' when (ADC_header_6(2  downto 0)  = pat_1) else '1';
			OUT_of_SYNC(13)	<=  '0' when (ADC_header_6(6  downto 4)  = pat_1) else '1';
			OUT_of_SYNC(14)	<=  '0' when (ADC_header_7(2 downto 0)  = pat_1) else '1';
			OUT_of_SYNC(15)	<=  '0' when (ADC_header_7(6 downto 4) = pat_1) else '1';


			
		
--CHK: for i in 0 to 1  generate 
--
--
-- LBNE_ADC_ASIC : entity work.LBNE_ASIC_DATA_V3
--	PORT MAP
--	(
--			clk_200Mhz		=> clk_200Mhz,
--			clk_sys			=> clk_sys,	
--			sys_rst 			=> sys_rst,
--			ADC_FD			=> ADC_FD_1,
--			ADC_FE			=> ADC_FE(i),
--			CHN_select		=> CHN_select,	
--			LATCH_LOC		=> LATCH_LOC_1(((i*4)+3) downto (i*4)),							
--			ADC_TST_PATT_EN=> TST_PATT_EN(i),
--			ADC_TST_PATT	=> TST_PATT,
--			ADC_header_out =>	ADC_header_1(((i*8)+7) downto (i*8)),			
--			ADC_SYNC		 	=> ADC_SYNC(i),	 -- ADC_SYNC_L,	
--			HS_DATA_LATCH 	=> TST_LATCH(i),
--			DATA_OUT 		=> TST_DATA(i),
--			ADCData			=>	ADCData_L1((i*16) to ((i*16)+15))
--	);
--	 
--end generate;

			TP_SYNC	<= ADC_SYNC_0;
			ADC_SYNC(0)		<=ADC_SYNC_0;				
									
 SBND_ASIC_RDOUT_V1_inst0 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_0,
			ADC_FE			=> ADC_FE(0),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_0,							
			ADC_TST_PATT_EN=> TST_PATT_EN(0),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_0,			
			ADC_SYNC		 	=> ADC_SYNC_0,	
			HS_DATA_LATCH 	=> TST_LATCH(0),
			DATA_OUT 		=> TST_DATA0,
			ADCData			=>	ADCData_L0
	);
	 
	 
 SBND_ASIC_RDOUT_V1_inst1 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_1,
			ADC_FE			=> ADC_FE(1),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_1,							
			ADC_TST_PATT_EN=> TST_PATT_EN(1),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_1,			
			ADC_SYNC		 	=> ADC_SYNC(1),	
			HS_DATA_LATCH 	=> TST_LATCH(1),
			DATA_OUT 		=> TST_DATA1,
			ADCData			=>	ADCData_L1
	);
	 	 
 SBND_ASIC_RDOUT_V1_inst2 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_2,
			ADC_FE			=> ADC_FE(2),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_2,							
			ADC_TST_PATT_EN=> TST_PATT_EN(2),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_2,			
			ADC_SYNC		 	=> ADC_SYNC(2),	
			HS_DATA_LATCH 	=> TST_LATCH(2),
			DATA_OUT 		=> TST_DATA2,
			ADCData			=>	ADCData_L2
	);
	 	 
	 
 SBND_ASIC_RDOUT_V1_inst3 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_3,
			ADC_FE			=> ADC_FE(3),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_3,							
			ADC_TST_PATT_EN=> TST_PATT_EN(3),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_3,			
			ADC_SYNC		 	=> ADC_SYNC(3),	
			HS_DATA_LATCH 	=> TST_LATCH(3),
			DATA_OUT 		=> TST_DATA3,
			ADCData			=>	ADCData_L3
	);
	 	 
 SBND_ASIC_RDOUT_V1_inst4 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_4,
			ADC_FE			=> ADC_FE(4),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_4,							
			ADC_TST_PATT_EN=> TST_PATT_EN(4),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_4,			
			ADC_SYNC		 	=> ADC_SYNC(4),	
			HS_DATA_LATCH 	=> TST_LATCH(4),
			DATA_OUT 		=> TST_DATA4,
			ADCData			=>	ADCData_L4
	);
	 	 
	 
	 	 	 	 
 SBND_ASIC_RDOUT_V1_inst5 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_5,
			ADC_FE			=> ADC_FE(5),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_5,							
			ADC_TST_PATT_EN=> TST_PATT_EN(5),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_5,			
			ADC_SYNC		 	=> ADC_SYNC(5),	
			HS_DATA_LATCH 	=> TST_LATCH(5),
			DATA_OUT 		=> TST_DATA5,
			ADCData			=>	ADCData_L5
	);
	 	 
	 
 SBND_ASIC_RDOUT_V1_inst6 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_6,
			ADC_FE			=> ADC_FE(6),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_6,							
			ADC_TST_PATT_EN=> TST_PATT_EN(6),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_6,			
			ADC_SYNC		 	=> ADC_SYNC(6),	
			HS_DATA_LATCH 	=> TST_LATCH(6),
			DATA_OUT 		=> TST_DATA6,
			ADCData			=>	ADCData_L6
	);
	 	 
 SBND_ASIC_RDOUT_V1_inst7 : SBND_ASIC_RDOUT_V1
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			ADC_MODE			=> ADC_MODE,
			ADC_FD			=> ADC_FD_7,
			ADC_FE			=> ADC_FE(7),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC_7,							
			ADC_TST_PATT_EN=> TST_PATT_EN(7),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_7,			
			ADC_SYNC		 	=> ADC_SYNC(7),	
			HS_DATA_LATCH 	=> TST_LATCH(7),
			DATA_OUT 		=> TST_DATA7,
			ADCData			=>	ADCData_L7
	);
	 	 

END behavior;

	
	