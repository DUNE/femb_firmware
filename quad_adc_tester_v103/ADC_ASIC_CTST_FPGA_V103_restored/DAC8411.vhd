--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: DAC8411.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 8/4/2015
--////  Description:  
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

ENTITY DAC8411 IS

	PORT
	(
	 	 clk         		     	: in  std_logic;                     -- Input CLK from MAC Reciever
		 reset			        	: in  std_logic;                     -- Synchronous reset signal
		 start						: in  std_logic;
		 DATA							: in  std_logic_vector(15 downto 0);
		 SCLK							: out std_logic;
		 DIN							: out std_logic;
		 SYNC							: out std_logic

	);
END DAC8411;


ARCHITECTURE behavior OF DAC8411 IS

  type state_type is (
		S_IDLE,
		S_SET_DAC_DATA,
		S_done	
		);
  signal state: state_type;

  signal CLK_CNT	     : STD_LOGIC_VECTOR(7 downto 0);
  signal DAC_data	      : STD_LOGIC_VECTOR(23 downto 0);

begin

SCLK	<= clk;

  process(clk,reset) 
  begin

     if (reset = '1') then

		DIN			<= '0';
		SYNC			<= '1';
		DAC_data		<= (others => '0'); -- b"00" & DATA & b"000000";		
		state 		<= S_IDLE;

		
     elsif (clk'event AND clk = '1') then
     CASE state IS
     when S_IDLE =>	
				CLK_CNT  	<= X"00";
				SYNC			<= '1';
				DIN			<= '0';
				if (start = '1')  then
				  DAC_data	<= b"00" & DATA & b"000000";	
				  state 		<= S_SET_DAC_DATA;		  
				else
				  state 		<= S_IDLE;
					end if;	
	 when	S_SET_DAC_DATA =>
				SYNC			<= '0';
				DIN			<= DAC_data(23-CONV_INTEGER(CLK_CNT));
				CLK_CNT		<= CLK_CNT + 1;
				if(CLK_CNT <= 20) then
					state 		<= S_SET_DAC_DATA;
				else
					SYNC			<= '1';				
					state 		<= S_done;				
				end if;					
		when S_done =>
				SYNC			<= '1';	
				DIN			<= '0';	
				if (start = '1')  then
					state <= S_done;	
				else
					state <= S_idle;	
				end if;	 
	 when others =>	
			state <= S_idle;		
      end case;  
	
		
     end if;
end process;

	
END behavior;
