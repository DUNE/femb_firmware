--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: FE_ASIC_SPI.VHD          
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 08/12/2015
--////  Description:  FE_ASIC_CNTRL
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

ENTITY FE_ASIC_SPI IS
 generic ( SPI_SPD_CNTL      : integer range 0 to 255  := 64);
	PORT
	(

		reset     		: IN STD_LOGIC;				-- reset		
		clk	    		: IN STD_LOGIC;				-- system clock 
		
		FE_SPI_SDI		: IN  STD_LOGIC_VECTOR(143 downto 0);		
		FE_SPI_RB		: OUT  STD_LOGIC_VECTOR(143 downto 0);			
		FE_ASIC_RESET	: IN STD_LOGIC;					
		WRITE_FE_SPI	: IN STD_LOGIC;

		ASIC_FE_CS		: OUT STD_LOGIC;	
		ASIC_FE_RST		: OUT STD_LOGIC;	
		ASIC_FE_CK		: OUT STD_LOGIC;	
		ASIC_FE_SDI		: OUT STD_LOGIC;	
		ASIC_FE_SDO		: IN  STD_LOGIC;
		SPI_WORKING		: OUT STD_LOGIC	
		
	);
	
	END FE_ASIC_SPI;

ARCHITECTURE behavior OF FE_ASIC_SPI IS

 
  type state_type is (S_IDLE,
							S_FE_ASIC_RESET,	
							S_WRITE_FE_SPI_START,	
							S_WRITE_FE_SPI_next_bit,	
							S_WRITE_FE_SPI_CLK_HIGH,					
							S_WRITE_FE_SPI_CLK_LOW,					
							S_WRITE_FE_SPI_DONE	);
   signal state: state_type;
	signal counter		: STD_LOGIC_VECTOR(15 downto 0);  
	signal index		: INTEGER RANGE 0 TO 148; 
	signal SPI_RB		: STD_LOGIC_VECTOR(143 downto 0);  
	signal FE_RST		: STD_LOGIC;	
	signal FE_CS		: STD_LOGIC;	
	signal FE_CLK		: STD_LOGIC;	
	signal FE_SDI		: STD_LOGIC;	

begin



		ASIC_FE_RST			<=	FE_RST;
		ASIC_FE_CS			<=	FE_CS;
		ASIC_FE_CK			<= FE_CLK;
		ASIC_FE_SDI			<= FE_SDI;

		
  process(clk,reset) 
  begin
	 if (reset = '1') then
		FE_RST		<= '1';
		FE_CS			<= '0';
		FE_CLK		<= '0';	
		FE_SDI		<= '0';
		index			<= 0;
		counter		<= (others => '0');
		state 		<= S_idle;
		SPI_WORKING		<= '0';
     elsif (clk'event AND clk = '1') then
			CASE state IS
			when S_IDLE =>	
				FE_RST		<= '1';
				FE_CS			<= '0';
				FE_CLK		<= '0';	
				FE_SDI		<= '0';
				counter		<= X"0000";
				index			<= 0;
				SPI_WORKING	<= '0';
				if (FE_ASIC_RESET = '1')  then
					state 		<= S_FE_ASIC_RESET;	
				elsif (WRITE_FE_SPI = '1')  then
					SPI_WORKING	<= '1';
					state 		<= S_WRITE_FE_SPI_START;		
				end if;	
			when S_FE_ASIC_RESET	 =>
				counter		<= counter + 1;
				FE_RST		<= '0';
				if(counter >= 25)  then	
					state 		<=  S_WRITE_FE_SPI_DONE;	
				end if;													
			when S_WRITE_FE_SPI_START	 =>
				FE_SDI		<= '0';
				FE_CS			<=	'0';
				FE_CLK		<= '0';	
				index			<=  0;			
				state 		<= S_WRITE_FE_SPI_next_bit;
			when	S_WRITE_FE_SPI_next_bit	=>	
				index			<= index + 1;
				FE_CS			<=	'1';
				FE_CLK		<= '0';	
				FE_SDI		<= FE_SPI_SDI(index);
				counter		<= X"0000";							
				state 		<=	S_WRITE_FE_SPI_CLK_HIGH;
				if( index = 144) then
						FE_SDI			<= '0';
						state 			<=	S_WRITE_FE_SPI_DONE;
				end if;
			when	S_WRITE_FE_SPI_CLK_HIGH	=>				
				counter		<= counter + 1;
				FE_CLK		<= '1';	
				if(counter >= SPI_SPD_CNTL)  then
					counter					<= X"0000";			
					SPI_RB(index-1)		<= ASIC_FE_SDO;  
					state 					<= S_WRITE_FE_SPI_CLK_LOW;	
				end if;					
			when	S_WRITE_FE_SPI_CLK_LOW	=>				
				counter		<= counter + 1;
				FE_CLK		<= '0';		
				if(counter > SPI_SPD_CNTL)  then	
					counter		<= X"0000";					
					state 		<= S_WRITE_FE_SPI_next_bit;	
				end if;	
			when	S_WRITE_FE_SPI_DONE	=>	
				FE_SPI_RB		<= SPI_RB;
				FE_SDI			<= '0';
				FE_CS				<=	'0';
				FE_CLK			<= '0';	
				if (FE_ASIC_RESET = '0') and (WRITE_FE_SPI = '0') then
					state 		<= S_idle;							
				end if;									
			 when others =>		
					state <= S_idle;		
			 end case; 
	 end if;
end process;

END behavior;

	
	