--*********************************************************
--* FILE  : LA_CLK_GEN.VHD
--* Author: Jack Fried
--*
--* Last Modified: 03/07/2011
--*  
--* Description: LA_CLK GEN TEST
--*		 		               
--*
--*
--*
--*
--*
--*
--*********************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;


--  Entity Declaration

ENTITY LA_CLK_GEN IS

	PORT
	(
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
END LA_CLK_GEN;

ARCHITECTURE behavior OF LA_CLK_GEN IS

 signal ADC_RST  			: STD_LOGIC;
 signal RD_EN  	 		: STD_LOGIC; 
 signal MSB_SIG  			: STD_LOGIC; 
 signal LSB_SIG  			: STD_LOGIC;
 signal LSB_FCELL			: STD_LOGIC;
 signal HS_DATA_LATCH	: STD_LOGIC;
 signal COUNTER	 		: STD_LOGIC_VECTOR(15 downto 0);

begin


		LA_ADC_RST 	 <=	ADC_RST;
		LA_RD_EN 	 <=	RD_EN;
		LA_MSB_SIG 	 <= 	MSB_SIG;
		LA_LSB_SIG 	 <=	LSB_SIG;
		LA_LSB_FCELL <= 	LSB_FCELL;		

		
  process(clk,sys_rst) 
  begin

	 if (sys_rst = '1') then

		ADC_RST 	  		<= '1';		
		RD_EN 	 	 	<= '1';	
		MSB_SIG 	  		<= '1';	
		LSB_SIG 	  		<= '0';	
		LSB_FCELL		<= '1';			
		COUNTER			<= x"0000";

     elsif (clk'event AND clk = '1') then
	  
		COUNTER			<= COUNTER + 1;
		ADC_RST 	  		<= '0' xnor (not INV_ADC_RST);		
		RD_EN 	 	 	<= '0' xnor (not INV_RDEN);	
		MSB_SIG 	  		<= '0' xnor (not INV_MSB_S);	
		LSB_SIG 	  		<= '0' xnor (not INV_LSB_S);
		LSB_FCELL		<= '0' xnor (not INV_LSB_f);		


	  
		if((COUNTER >= OFST_ADC_RST) AND (COUNTER <= (OFST_ADC_RST + WDTH_ADC_RST - 1))) then
			ADC_RST 	  	<= '1' xnor (not INV_ADC_RST);	
		end if;
		if((COUNTER >= OFST_RDEN) AND (COUNTER <= (OFST_RDEN + WDTH_RDEN - 1))) then
			RD_EN 	  	<= '1' xnor (not INV_RDEN);	
		end if;  
		if((COUNTER >= OFST_MSB_S) AND (COUNTER <= (OFST_MSB_S + WDTH_MSB_S -1))) then
			MSB_SIG 	  	<= '1' xnor (not INV_MSB_S);
		end if;    
	  	if((COUNTER >= OFST_LSB_S) AND (COUNTER <= (OFST_LSB_S + WDTH_LSB_S - 1))) then
			LSB_SIG 	  	<= '1' xnor (not INV_LSB_S);
		end if; 
		if((COUNTER >= OFST_LSB_f1) AND (COUNTER <= (OFST_LSB_f1 + WDTH_LSB_f1 -1))) then
			LSB_FCELL 	  	<= '1' xnor (not INV_LSB_f)	;
		end if; 	
		if((COUNTER >= OFST_LSB_f2) AND (COUNTER <= (OFST_LSB_f2 + WDTH_LSB_f2 - 1))) then
			LSB_FCELL 	  	<= '1' xnor (not INV_LSB_f)	;
		end if; 	
				
		if(COUNTER = (PERIOD-1)) then
			COUNTER <= x"0000";
		end if;
	  
	 end if;
end process;
END behavior;

