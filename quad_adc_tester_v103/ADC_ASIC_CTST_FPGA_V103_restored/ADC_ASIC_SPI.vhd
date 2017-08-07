--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: ADC_ASIC_SPI.VHD          
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 08/12/2015
--////  Description:  ADC_ASIC_CNTRL
--////					
--////
--/////////////////////////////////////////////////////////////////////
--////
--//// Copyright (C) 2015 Brookhaven National Laboratory
--////
--/////////////////////////////////////////////////////////////////////

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;


--  Entity Declaration

ENTITY ADC_ASIC_SPI IS
 generic ( SPI_SPD_CNTL      : integer range 0 to 255  := 64);
	PORT
	(

		reset     		: IN STD_LOGIC;				-- reset		
		clk	    		: IN STD_LOGIC;				-- system clock 	
		ADC_SPI_SDI		: IN  STD_LOGIC_VECTOR(143 downto 0);		
		ADC_SPI_RB		: OUT  STD_LOGIC_VECTOR(143 downto 0);			
		ADC_ASIC_RESET	: IN STD_LOGIC;	
		SOFT_ADC_RESET : IN STD_LOGIC;			
		WRITE_ADC_SPI	: IN STD_LOGIC;
		ASIC_ADC_CS		: OUT STD_LOGIC;	
		ASIC_ADC_CK		: OUT STD_LOGIC;	
		ASIC_ADC_SDI	: OUT STD_LOGIC;	
		ASIC_ADC_SDO	: IN  STD_LOGIC;
		SPI_WORKING		: OUT STD_LOGIC	
		
	);
	
	END ADC_ASIC_SPI;

ARCHITECTURE behavior OF ADC_ASIC_SPI IS

 
  type state_type is (S_IDLE,
							S_ADC_ASIC_RESET,	
							S_SOFT_ADC_RESET,
							S_WRITE_ADC_SPI_START,	
							S_WRITE_ADC_SPI_next_bit,	
							S_WRITE_ADC_SPI_CLK_HIGH,					
							S_WRITE_ADC_SPI_CLK_LOW,					
							S_WRITE_ADC_SPI_DONE	);
   signal state: state_type;
	signal counter		: STD_LOGIC_VECTOR(15 downto 0);  
	signal index		: INTEGER RANGE 0 TO 148; 
	signal SPI_RB		: STD_LOGIC_VECTOR(143 downto 0);  	
	signal ADC_CS		: STD_LOGIC;	
	signal ADC_CLK		: STD_LOGIC;	
	signal ADC_SDI		: STD_LOGIC;	

begin



		ASIC_ADC_CS			<=	ADC_CS;
		ASIC_ADC_CK			<= ADC_CLK;
		ASIC_ADC_SDI		<= ADC_SDI;

		
  process(clk,reset) 
  begin
	 if (reset = '1') then
		ADC_CS			<= '0';
		ADC_CLK		<= '0';	
		ADC_SDI		<= '0';
		index			<= 0;
		counter		<= (others => '0');
		state 		<= S_idle;
		SPI_WORKING		<= '0';
     elsif (clk'event AND clk = '1') then
			CASE state IS
			when S_IDLE =>	
				ADC_CS			<= '0';
				ADC_CLK		<= '0';	
				ADC_SDI		<= '0';
				counter		<= X"0000";
				index			<= 0;
				SPI_WORKING	<= '0';
				if (ADC_ASIC_RESET = '1')  then
					state 		<= S_ADC_ASIC_RESET;	
				elsif (SOFT_ADC_RESET = '1')  then				
					state 		<= S_SOFT_ADC_RESET;								
				elsif (WRITE_ADC_SPI = '1')  then
					SPI_WORKING	<= '1';
					state 		<= S_WRITE_ADC_SPI_START;		
				end if;	
			when S_ADC_ASIC_RESET	 =>
				counter		<= counter + 1;
				if   (counter = 1)  then
					ADC_CLK		<= '1';
				elsif(counter = 2)  then
					ADC_CS		<=	'1';
				elsif(counter = 5)  then
					ADC_CS		<=	'0';
				elsif(counter = 10)  then
					ADC_CS		<=	'0';
					ADC_CLK		<= '0';
				elsif(counter >= 15)  then	
					state 		<=  S_WRITE_ADC_SPI_DONE;	
				end if;	
			when S_SOFT_ADC_RESET =>	
				counter		<= counter + 1;
				if   (counter = 1)  then
					ADC_CLK		<= '0';
				elsif(counter = 2)  then
					ADC_CS		<=	'1';
				elsif(counter = 5)  then
					ADC_CS		<=	'0';
				elsif(counter = 10)  then
					ADC_CS		<=	'0';
					ADC_CLK		<= '0';
				elsif(counter >= 15)  then	
					state <= S_WRITE_ADC_SPI_DONE;	
				end if;
			when S_WRITE_ADC_SPI_START	 =>
				ADC_SDI		<= '0';
				ADC_CS		<=	'0';
				ADC_CLK		<= '0';	
				index			<=  0;			
				state 		<= S_WRITE_ADC_SPI_next_bit;
			when	S_WRITE_ADC_SPI_next_bit	=>	
				index			<= index + 1;
				ADC_CS			<=	'1';
				ADC_CLK		<= '0';	
				ADC_SDI		<= ADC_SPI_SDI(index);
				counter		<= X"0000";							
				state 		<=	S_WRITE_ADC_SPI_CLK_HIGH;
				if( index = 144) then
						ADC_SDI			<= '0';
						state 			<=	S_WRITE_ADC_SPI_DONE;
				end if;
			when	S_WRITE_ADC_SPI_CLK_HIGH	=>				
				counter		<= counter + 1;
				ADC_CLK		<= '1';	
				if(counter >= SPI_SPD_CNTL)  then
					counter					<= X"0000";			
					SPI_RB(index-1)		<= ASIC_ADC_SDO;  
					state 					<= S_WRITE_ADC_SPI_CLK_LOW;	
				end if;					
			when	S_WRITE_ADC_SPI_CLK_LOW	=>				
				counter		<= counter + 1;
				ADC_CLK		<= '0';		
				if(counter > SPI_SPD_CNTL)  then	
					counter		<= X"0000";					
					state 		<= S_WRITE_ADC_SPI_next_bit;	
				end if;	
			when	S_WRITE_ADC_SPI_DONE	=>	
				ADC_SPI_RB		<= SPI_RB;
				ADC_SDI			<= '0';
				ADC_CS			<=	'0';
				ADC_CLK			<= '0';	
				if (ADC_ASIC_RESET = '0') and (WRITE_ADC_SPI = '0') and (SOFT_ADC_RESET = '0') then
					state 		<= S_idle;							
				end if;									
			 when others =>		
					state <= S_idle;		
			 end case; 
	 end if;
end process;

END behavior;

	
	