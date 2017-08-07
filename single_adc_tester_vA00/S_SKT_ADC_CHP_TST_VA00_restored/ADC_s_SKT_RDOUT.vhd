--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: ADC_s_SKT_RDOUT.VHD          
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created:  10/01/2014
--////  Modified: 08/03/2017
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

ENTITY ADC_s_SKT_RDOUT IS

	PORT
	(
		sys_rst     	: IN STD_LOGIC;				-- reset		
		clk_200Mhz    	: IN STD_LOGIC;				-- ADC clock
		clk_sys	    	: IN STD_LOGIC;				-- system clock 
	
		ADC_SYNC_MODE	: IN STD_LOGIC;				-- 0  use internal 2MHZ  clock  1 use external ADC_CON			
		
		ADC_CONV			: OUT STD_LOGIC_VECTOR(0 downto 0);	-- LVDS		USE TO BE ADC_RCK_L	
		TP_SYNC			: OUT STD_LOGIC;			
		ADC_RD_DISABLE	: IN STD_LOGIC;
		
		ADC_FD_0			: IN STD_LOGIC_VECTOR(1 downto 0);	-- LVDS
	
		
		ADC_FF			: IN  STD_LOGIC_VECTOR(0 downto 0);  -- LVDS	  -- NOT USED
		ADC_BUSY			: IN  STD_LOGIC_VECTOR(0 downto 0);  -- LVDS	
		ADC_CLK			: OUT STD_LOGIC_VECTOR(0 downto 0);  -- LVDS					
		
		
		CLK_select		: IN STD_LOGIC_VECTOR(7 downto 0); 		
		
		CHP_select		: IN STD_LOGIC_VECTOR(7 downto 0); 	
		CHN_select		: IN STD_LOGIC_VECTOR(7 downto 0); 
		
		TST_PATT_EN		: IN STD_LOGIC_VECTOR(7 downto 0); 
		TST_PATT			: IN STD_LOGIC_VECTOR(11 downto 0);
		
		LATCH_LOC_0		: IN STD_LOGIC_VECTOR(7 downto 0);

		
		FEMB_TST_MODE	: IN STD_LOGIC;
		WFM_GEN_ADDR	: OUT STD_LOGIC_VECTOR(7 downto 0);
		WFM_GEN_DATA	: IN STD_LOGIC_VECTOR(23 downto 0);

		
		OUT_of_SYNC	 	: OUT STD_LOGIC_VECTOR(15 downto 0);				
		
		ADC_Data_LATCH : OUT STD_LOGIC_VECTOR(0 downto 0);
		ADC_Data		   : OUT ADC_array(0 to 0);		
		ADC_header		: OUT SL_ARRAY_7_TO_0(0 to 0);	
		
		WIB_MODE			: IN STD_LOGIC;
		UDP_TST_LATCH	: OUT STD_LOGIC;		
		UDP_TST_DATA	: OUT STD_LOGIC_VECTOR(15 downto 0)
		
	);
	
	END ADC_s_SKT_RDOUT;

ARCHITECTURE behavior OF ADC_s_SKT_RDOUT IS

 

	SIGNAL 	CLK_select_s	: STD_LOGIC_VECTOR(7 downto 0); 		
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
			 LATCH_LOC(0)	<= LATCH_LOC_0;
		--	 ADC_header		<= ADC_header_I;
			 
			  process(clk_sys) 	
			  begin
				if (clk_sys'event AND clk_sys = '1') then		
						CLK_select_s	<= CLK_select;
						CHP_select_s	<= CHP_select;
				end if;
			end process;	

			

			
e_mux_inst: entity work.e_mux
	PORT MAP
	(
		data0		=> ADC_CLK_0,
		data1		=> ADC_CLK_90,
		data2		=> ADC_CLK_180,
		data3		=> ADC_CLK_270,
		sel		=> CLK_select(1 downto 0),
		result	=> ADC_CLK(0)
	);
	
		
			
	
		UDP_TST_DATA <=   UDP_DATA(0);					
		UDP_TST_LATCH <=  UDP_LATCH(0) when (CHP_select_s = x"0") else
									'0';
		
		
		
		ADC_HEADER_GEN: for i in 0 to 0  generate 		

				A_HEADER(i*2)	 <= ADC_header_I(i)(2 downto 0);
				A_HEADER(i*2+1) <= ADC_header_I(i)(6 downto 4);								
				OUT_of_SYNC(i*2)    <= '0' when  (A_HEADER(i*2) = b"010")    else '1';
			   OUT_of_SYNC(i*2+1)  <= '0' when  (A_HEADER(i*2+1) = b"010")  else '1';	
					
		end generate;			


		
CHK: for i in 0 to 0  generate 

SBND_ASIC_RDOUT_V2 : entity work.SBND_ASIC_RDOUT_V2
	PORT MAP
	(
			clk_200Mhz		=> clk_200Mhz,
			clk_sys			=> clk_sys,	
			sys_rst 			=> sys_rst,
			FEMB_TST_MODE	=> FEMB_TST_MODE,
			WIB_MODE			=> WIB_MODE,
			WFM_GEN_DATA	=> WFM_GEN_DATA,
			ADC_FD			=> ADC_IN(i),
			ADC_BUSY			=> ADC_BUSY(i),
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



  process(clk_200Mhz,sys_rst) 
  begin
	 if (sys_rst = '1' or ADC_RD_DISABLE = '1') then
		ADC_CONV_I	<= '0';
		BIT_CNT		<= x"00";
     elsif (clk_200Mhz'event AND clk_200Mhz = '1') then
 
 		if( ADC_SYNC_MODE = '0' ) then 
			BIT_CNT		<= BIT_CNT + 1;		
			if (BIT_CNT >= x"30") then
				ADC_CONV_I		<= '0';
			else
				ADC_CONV_I		<= '1';
			end if;
			if (BIT_CNT >= x"63")  then  
					BIT_CNT		<= x"00";
			end if;
		end if;	
	 end if;
end process;





			ADC_CONV(0)	<=    ADC_CONV_I;							
			TP_SYNC		<=		ADC_CONV_I;	
	 
	

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

	
	