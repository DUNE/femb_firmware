--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: SBND_RDOUT_V1.VHD          
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created:  10/01/2014
--////  Modified: 06/29/2016
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
		clk_200Mhz    	: IN STD_LOGIC;				-- ADC clock
		clk_sys	    	: IN STD_LOGIC;				-- system clock 

		
		SYNC_CMD_CLK	: IN STD_LOGIC;
		ADC_SYNC_MODE	: IN STD_LOGIC_VECTOR(1 downto 0);
		EXT_ADC_CONV	: IN STD_LOGIC;
		CONV_CLOCK		: OUT STD_LOGIC;	
		CONV_CLK_CHK	: OUT STD_LOGIC;			
		
		ADC_CONV			: OUT STD_LOGIC_VECTOR(7 downto 0);	-- LVDS		USE TO BE ADC_RCK_L	
		ADC_RD_DISABLE	: IN STD_LOGIC;
		ASIC_CONV_DISABLE : IN STD_LOGIC;
		ADC_FD_0			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_1			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_2			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_3			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS		
		ADC_FD_4			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_5			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_6			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
		ADC_FD_7			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS			
		
		ADC_FF			: IN  STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	  -- NOT USED
		ADC_BUSY			: IN  STD_LOGIC_VECTOR(7 downto 0);  -- LVDS	
		ADC_CLK			: OUT STD_LOGIC_VECTOR(7 downto 0);  -- LVDS					
		
		
		CLK_select		: IN STD_LOGIC_VECTOR(15 downto 0); 		
		
		CHP_select		: IN STD_LOGIC_VECTOR(7 downto 0); 	
		CHN_select		: IN STD_LOGIC_VECTOR(7 downto 0); 
		
		TST_PATT_EN		: IN STD_LOGIC_VECTOR(7 downto 0); 
		TST_PATT			: IN STD_LOGIC_VECTOR(11 downto 0);
		
		LATCH_LOC_0		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_1		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_2		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_3		: IN STD_LOGIC_VECTOR(7 downto 0); 
		LATCH_LOC_4		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_5		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_6		: IN STD_LOGIC_VECTOR(7 downto 0);
		LATCH_LOC_7		: IN STD_LOGIC_VECTOR(7 downto 0);	

		FEMB_TST_MODE	: IN STD_LOGIC;
		WFM_GEN_ADDR	: OUT STD_LOGIC_VECTOR(7 downto 0);
		WFM_GEN_DATA	: IN STD_LOGIC_VECTOR(23 downto 0);

		ADC_Busy_stat	: OUT STD_LOGIC_VECTOR(7 downto 0);		
		OUT_of_SYNC	 	: OUT STD_LOGIC_VECTOR(15 downto 0);				
		
		ADC_Data_LATCH : OUT STD_LOGIC_VECTOR(7 downto 0);
		ADC_Data		   : OUT ADC_array(0 to 7);		
		ADC_header		: OUT SL_ARRAY_7_TO_0(0 to 7);	
		
		WIB_MODE			: IN STD_LOGIC;
		UDP_TST_LATCH	: OUT STD_LOGIC;		
		UDP_TST_DATA	: OUT STD_LOGIC_VECTOR(15 downto 0)
		
	);
	
	END SBND_RDOUT_V1;

ARCHITECTURE behavior OF SBND_RDOUT_V1 IS

 

	SIGNAL 	CLK_select_s	: STD_LOGIC_VECTOR(15 downto 0); 		
	SIGNAL 	CHP_select_s	: STD_LOGIC_VECTOR(7 downto 0); 	
	
	SIGNAL	ADC_SYNC_I		: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_CLK_0	: STD_LOGIC;
	SIGNAL	ADC_CLK_90	: STD_LOGIC;
	SIGNAL	ADC_CLK_180	: STD_LOGIC;
	SIGNAL	ADC_CLK_270	: STD_LOGIC;
	
	SIGNAL	ADC_IN			: SL_ARRAY_1_TO_0(0 to 7);
	SIGNAL	LATCH_LOC		: SL_ARRAY_7_TO_0(0 to 7);
	SIGNAL	ADC_header_I	: SL_ARRAY_7_TO_0(0 to 7);
	SIGNAL	UDP_DATA			: SL_ARRAY_15_TO_0(0 to 7);
	SIGNAL	UDP_LATCH		: STD_LOGIC_VECTOR(7 downto 0);
   SIGNAL 	BIT_CNT	 		: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_CONV_I		: STD_LOGIC;
	SIGNAL	WFM_ADDR			: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL	ADC_CONV_DLY	: STD_LOGIC;
	
	SIGNAL	A_HEADER			:SL_ARRAY_2_TO_0(0 to 15);
	
	SIGNAL	EXT_CONV_DLY1	: STD_LOGIC;
	SIGNAL	EXT_CONV_DLY2	: STD_LOGIC;
	SIGNAL	CONV_CLK_EN		: STD_LOGIC;
	SIGNAL	EN_EXT_CONV1	: STD_LOGIC;
	SIGNAL	EN_EXT_CONV2	: STD_LOGIC;
	SIGNAL	EN_EXT_CONV3	: STD_LOGIC;
	SIGNAL	EN_EXT_CONV4	: STD_LOGIC;
	SIGNAL	CONV_CNT			: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL	EXT_CONV_START : STD_LOGIC;

	
begin


ADC_PLL_inst1 : entity work.ADC_PLL
	PORT MAP
	(
		areset	=> sys_rst ,
		inclk0	=> clk_200Mhz,
		c0			=> ADC_CLK_0,
		c1			=> ADC_CLK_90,
		c2			=> ADC_CLK_180,
		c3			=> ADC_CLK_270,
		locked	=> open
	);


			 ADC_IN(0)	<= ADC_FD_0;
			 ADC_IN(1)	<= ADC_FD_1;
			 ADC_IN(2)	<= ADC_FD_2;
			 ADC_IN(3)	<= ADC_FD_3;
			 ADC_IN(4)	<= ADC_FD_4;
			 ADC_IN(5)	<= ADC_FD_5;
			 ADC_IN(6)	<= ADC_FD_6;
			 ADC_IN(7)	<= ADC_FD_7;
					
			 LATCH_LOC(0)	<= LATCH_LOC_0;
			 LATCH_LOC(1)	<= LATCH_LOC_1;
			 LATCH_LOC(2)	<= LATCH_LOC_2;
			 LATCH_LOC(3)	<= LATCH_LOC_3;
			 LATCH_LOC(4)	<= LATCH_LOC_4;
			 LATCH_LOC(5)	<= LATCH_LOC_5;
			 LATCH_LOC(6)	<= LATCH_LOC_6;
			 LATCH_LOC(7)	<= LATCH_LOC_7;
			 
			 ADC_header		<= ADC_header_I;
			 
			  process(clk_sys) 	
			  begin
				if (clk_sys'event AND clk_sys = '1') then		
						CLK_select_s	<= CLK_select;
						CHP_select_s	<= CHP_select;
				end if;
			end process;	

			
ADC_MUX: for i in 0 to 7  generate 
			
e_mux_inst: entity work.e_mux
	PORT MAP
	(
		data0		=> ADC_CLK_0,
		data1		=> ADC_CLK_90,
		data2		=> ADC_CLK_180,
		data3		=> ADC_CLK_270,
		sel		=> CLK_select(8 +i) & CLK_select(i),
		result	=> ADC_CLK(i)
	);
	
end generate;			
			
	
			UDP_TST_DATA <=   UDP_DATA(0) when (CHP_select_s = x"0") else
									UDP_DATA(1) when (CHP_select_s = x"1") else
									UDP_DATA(2) when (CHP_select_s = x"2") else
									UDP_DATA(3) when (CHP_select_s = x"3") else																
									UDP_DATA(4) when (CHP_select_s = x"4") else
									UDP_DATA(5) when (CHP_select_s = x"5") else
									UDP_DATA(6) when (CHP_select_s = x"6") else
									UDP_DATA(7) when (CHP_select_s = x"7") else
									x"0000";

								
			UDP_TST_LATCH <=  UDP_LATCH(0) when (CHP_select_s = x"0") else
									UDP_LATCH(1) when (CHP_select_s = x"1") else
									UDP_LATCH(2) when (CHP_select_s = x"2") else
									UDP_LATCH(3) when (CHP_select_s = x"3") else
									UDP_LATCH(4) when (CHP_select_s = x"4") else
									UDP_LATCH(5) when (CHP_select_s = x"5") else
									UDP_LATCH(6) when (CHP_select_s = x"6") else
									UDP_LATCH(7) when (CHP_select_s = x"7") else
									'0';
		

		
		
		ADC_HEADER_GEN: for i in 0 to 7  generate 		

				A_HEADER(i*2)	 <= ADC_header_I(i)(2 downto 0);
				A_HEADER(i*2+1) <= ADC_header_I(i)(6 downto 4);								
				OUT_of_SYNC(i*2)    <= '0' when  (A_HEADER(i*2) = b"010")    else '1';
			   OUT_of_SYNC(i*2+1)  <= '0' when  (A_HEADER(i*2+1) = b"010")  else '1';	
					
		end generate;			


		
CHK: for i in 0 to 7  generate 

SBND_ASIC_RDOUT_V2 : entity work.SBND_ASIC_RDOUT_V2
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst or ADC_RD_DISABLE,
			FEMB_TST_MODE	=> FEMB_TST_MODE,
			WIB_MODE			=> WIB_MODE,
			WFM_GEN_DATA	=> WFM_GEN_DATA,
			ADC_FD			=> ADC_IN(i),
			ADC_BUSY			=> ADC_BUSY(i),
			ADC_Busy_stat	=> ADC_Busy_stat(i),
			CHN_select		=> CHN_select,	
			LATCH_LOC		=> LATCH_LOC(i),							
			ADC_TST_PATT_EN=> TST_PATT_EN(i),
			ADC_TST_PATT	=> TST_PATT,
			ADC_header_out =>	ADC_header_I(i),			
			ADC_CONV			=> ADC_CONV_I ,	
			UDP_DATA_LATCH => UDP_LATCH(i),
			UDP_DATA_OUT 	=> UDP_DATA(i),
			ADC_Data_LATCH => ADC_Data_LATCH(i),
			ADC_Data			=>	ADC_Data(i)
	);
	 
end generate;


		
	process(clk_200Mhz) 
	begin
		if (clk_200Mhz'event AND clk_200Mhz = '1') then
			EXT_CONV_DLY1 <= EXT_ADC_CONV;
			EXT_CONV_DLY2 <= EXT_CONV_DLY1;
		end if;
	end process;

	process(clk_200Mhz,sys_rst,ASIC_CONV_DISABLE) 
	begin
		if (sys_rst = '1' or SYNC_CMD_CLK = '1' or ASIC_CONV_DISABLE = '1') then
			CONV_CLK_EN	<= '0';			
			CONV_CNT		<= x"0";
		elsif (clk_200Mhz'event AND clk_200Mhz = '1') then
			if(EXT_CONV_DLY1 = '1' and EXT_CONV_DLY2 = '0') then 
				CONV_CLK_EN	<= '1';
			end if;
			if(EXT_CONV_DLY1 = '0' and EXT_CONV_DLY2 = '1') then 
				CONV_CNT		<= CONV_CNT + 1;
				if(CONV_CNT = x"5") then
					CONV_CNT	<= x"5";
				end if;
			end if;			
			
			
			
		end if;
	end process;
	
	

  process(clk_200Mhz,sys_rst) 
  begin
	 if (sys_rst = '1' or ADC_RD_DISABLE = '1' or ASIC_CONV_DISABLE = '1') then
		ADC_CONV_I	 <= '0';
		BIT_CNT		 <= x"00";
		EN_EXT_CONV1 <= '0';
		EN_EXT_CONV2 <= '0';		
		EN_EXT_CONV3 <= '0';
		EN_EXT_CONV4 <= '0';		
		EXT_CONV_START <= '0';
     elsif (clk_200Mhz'event AND clk_200Mhz = '1' ) then
		EN_EXT_CONV4 <=	EN_EXT_CONV3;
		if( ADC_SYNC_MODE = b"11" ) then    -- disabled
			ADC_CONV_I	<= '0';
			BIT_CNT		<= x"00";
			EXT_CONV_START <= '0';	
		elsif( ADC_SYNC_MODE = b"10" ) then   -- follow input
			if( CONV_CNT > x"1") then
					ADC_CONV_I 	<=	EXT_ADC_CONV;
			end if;			
			if( CONV_CNT = x"4") then
					EXT_CONV_START <= '1';
			end if;	
		elsif( ADC_SYNC_MODE = b"01" or CONV_CLK_EN = '1') then  -- free running or synced to cmd clk
			EXT_CONV_START <= '0';
			BIT_CNT		<= BIT_CNT + 1;		
			if (BIT_CNT >= x"30") then
				ADC_CONV_I		<= '1';
			else
				ADC_CONV_I		<= '0';
			end if;
			if (BIT_CNT >= x"63")  then  
					BIT_CNT		<= x"00";
					EN_EXT_CONV1	<= '1';
					EN_EXT_CONV2 <= EN_EXT_CONV1;
					EN_EXT_CONV3 <= EN_EXT_CONV2;
			end if;
		else
			ADC_CONV_I	<= '0';
			BIT_CNT		<= x"00";
			EN_EXT_CONV1 <= '0';
			EN_EXT_CONV3 <= '0';
			EN_EXT_CONV4 <= '0';		
		end if;	
				
	 end if;
end process;


			ADC_CONV(0)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';				
			ADC_CONV(1)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';				
			ADC_CONV(2)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';						
			ADC_CONV(3)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';					
			ADC_CONV(4)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';					
			ADC_CONV(5)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';				
			ADC_CONV(6)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';			
			ADC_CONV(7)		<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';			
			CONV_CLK_CHK	<= ADC_CONV_I when (EN_EXT_CONV4 = '1' or EXT_CONV_START = '1') else '0';		
			CONV_CLOCK		<= ADC_CONV_I;	
	 

process(clk_sys) 
  begin
	if (clk_sys'event AND clk_sys = '1') then
		ADC_CONV_DLY <= ADC_CONV_I ;
		WFM_GEN_ADDR <= WFM_ADDR;
		if(ADC_CONV_I = '0' and ADC_CONV_DLY = '1') then
			WFM_ADDR	<= WFM_ADDR + 1;
		end if;
	end if;
end process;	 
	 
	 
	 
END behavior;

	
	