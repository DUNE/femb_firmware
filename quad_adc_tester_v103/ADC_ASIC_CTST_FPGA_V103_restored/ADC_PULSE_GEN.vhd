--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: FE_PULSE_GEN.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 8/4/2015
--////  Description:  DAC8411 (16-bit)
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

ENTITY ADC_PULSE_GEN IS

	PORT
	(
		 clk_100MHz    	     	: in  std_logic;   
	 	 clk_10MHz    		     	: in  std_logic;                    
		 reset			        	: in  std_logic;       
		 PULSE_SYNC					: in  std_logic;     
		 SET_DAC						: in  std_logic;
		 TP_MODE_SELECT			: in  std_logic_vector(3 downto 0);
		 TP_PERIOD					: in  std_logic_vector(15 downto 0);	-- count 4MHz clocks
		 TP_SHIFT					: in  std_logic_vector(15 downto 0);	-- 12.5ns steps
		 DAC_VALUE					: in  std_logic_vector(15 downto 0);
		 DAC_SCLK					: out std_logic;
		 DAC_DIN						: out std_logic;
		 DAC_SYNC					: out std_logic;
		 MUX_A						: out std_logic_vector(1 downto 0);		 
		 SW_TST_ADC					: out std_logic;	
		 INT_DAC_CNTL				: out std_logic

	);
END ADC_PULSE_GEN;


ARCHITECTURE behavior OF ADC_PULSE_GEN  IS

  type state_type is (
		S_IDLE,
		S_start_TP_P,
		S_start_TP_N
		);
  signal state: state_type;

    type state_type2 is (
		S_IDLE,
		S_Trigger
		);
  signal state_ss: state_type2;

  
  signal CLK_CNT	   : STD_LOGIC_VECTOR(15 downto 0);
  signal SYNC_CNT	   : STD_LOGIC_VECTOR(15 downto 0);
  signal	TP_GEN		: STD_LOGIC;
  signal	PULSE_SYNC_1: STD_LOGIC;
  signal	PULSE_SYNC_2: STD_LOGIC;
  signal	TP_SHIFT_LOC: STD_LOGIC_VECTOR(15 downto 0);
  
begin
	
	

	
DAC8411_inst	: entity work.DAC8411 
PORT MAP	( 	clk         	=>	clk_10MHz,
				reset				=> reset,  
				start				=>	SET_DAC,
				DATA				=>	DAC_VALUE,
				SCLK				=>	DAC_SCLK,
				DIN				=>	DAC_DIN,		
				SYNC				=> DAC_SYNC
	);
	
	

  process(TP_MODE_SELECT) 
  begin
	INT_DAC_CNTL	<= '0';
	SW_TST_ADC		<= '1';
    CASE TP_MODE_SELECT IS
		when x"0" =>	
			MUX_A		<=  b"00";  -- DAC ONLY NO PULSE
		when x"1" =>	
			MUX_A		<=  b"01";	 -- EXT TP ENABLED
		when x"2" =>	
			MUX_A		<=  b"10";	 --  GND SELECTED
		when x"3" =>	
			MUX_A		<=  b"11";	 --  1.8V at TP
		when x"4" =>	
			MUX_A		<=  TP_GEN & '0';  -- system test pulse
		when x"5" =>	
			MUX_A		<=  b"10";	 --  1.8V at FE input
			SW_TST_ADC		<= '0';
		when x"6" =>	
			MUX_A				<=  b"10";	 --  GND SELECTED
			INT_DAC_CNTL	<= not TP_GEN;
		when others =>
			MUX_A		<=  b"10";	 --  GND SELECTED
		end case;  
end process;

  process(clk_100MHz ,reset) 
  begin
     if (reset = '1') then
		TP_GEN		<= '0';
		CLK_CNT  	<= X"0000";
		SYNC_CNT 	<= X"0000";
		state 		<= S_IDLE;
     elsif (clk_100MHz'event AND clk_100MHz = '1') then
			  PULSE_SYNC_1	<= PULSE_SYNC;
			  PULSE_SYNC_2	<= PULSE_SYNC_1;
			  CASE state IS
			  when S_IDLE =>
						CLK_CNT  	<= X"0000";
						TP_GEN		<= '0';
						TP_SHIFT_LOC <= TP_SHIFT;
						if (TP_MODE_SELECT = x"4")  or (TP_MODE_SELECT = x"6") then
							if(PULSE_SYNC_1 = '1' and PULSE_SYNC_2 = '0') then
								SYNC_CNT <= SYNC_CNT + 1;
								if(SYNC_CNT >=  TP_PERIOD) then
									state 	<= S_start_TP_P;
									SYNC_CNT 	<= X"0000";
								end if;
							end if;
						end if;	
						
			 when	S_start_TP_P =>
					CLK_CNT  	<= CLK_CNT +1;
					if(CLK_CNT >= TP_SHIFT_LOC) then
						CLK_CNT  	<= X"0000";
						TP_GEN		<= '1';
						state 		<= S_start_TP_N;
					end if;
			 when	S_start_TP_N =>
					CLK_CNT  	<= CLK_CNT +1;
					if(CLK_CNT >= 1800) then
						CLK_CNT  	<= X"0000";
						state 		<= S_IDLE;
					end if;
			 when others =>	
					state <= S_idle;		
			 end case; 
     end if;
end process;

	
	

	
	
	
	
	
END behavior;
