--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: PWR_CNTRL.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 07/05/2017
--////  Description:  
--////					
--////
--/////////////////////////////////////////////////////////////////////
--////
--//// Copyright (C) 2017 Brookhaven National Laboratory
--////
--/////////////////////////////////////////////////////////////////////


library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



--  Entity Declaration

entity PWR_CNTRL is
	port
	(
		clk_40MHz     		: in  std_logic;                     -- Input CLK from MAC Reciever
		PWR_IN				: in  std_logic_VECTOR(3 downto 0);  
		PWR_OUT_1			: OUT  std_logic;                    
		PWR_OUT_2			: OUT  std_logic;                    
		PWR_OUT_3			: OUT  std_logic;                   
		PWR_OUT_4			: OUT  std_logic                    
		
		);
end PWR_CNTRL;


--  Architecture Body

architecture PWR_CNTRL_arch OF PWR_CNTRL is

		signal counter1			 : std_logic_vector(23 downto 0) ;
		signal counter2			 : std_logic_vector(23 downto 0) ;
		signal counter3			 : std_logic_vector(23 downto 0) ;
		signal counter4			 : std_logic_vector(23 downto 0) ;		 	 

BEGIN
        process(clk_40MHz)
        begin
				if (PWR_IN(0) = '0') then
					PWR_OUT_1	<= '0';
					counter1 	<= x"000000";
				elsif (clk_40MHz = '1') and (clk_40MHz'event) then
					counter1 	<= counter1 + 1;
					PWR_OUT_1	<= '0';
					if(counter1 >= x"000100") then
						PWR_OUT_1		<= '1';
						counter1 		<= x"FFFF00";
					end if ;
				end if;
			end process ;
		  
	  
        process(clk_40MHz)
        begin
				if (PWR_IN(1) = '0') then
					PWR_OUT_2	<= '0';
					counter2 	<= x"000000";
				elsif (clk_40MHz = '1') and (clk_40MHz'event) then
					counter2 	<= counter2 + 1;
					PWR_OUT_2	<= '0';
					if(counter2 >= x"310000") then
						PWR_OUT_2		<= '1';
						counter2 		<= x"FFFF00";
					end if ;
				end if;
			end process ;
		  		  

        process(clk_40MHz)
        begin
				if (PWR_IN(2) = '0') then
					PWR_OUT_3	<= '0';
					counter3 	<= x"000000";
				elsif (clk_40MHz = '1') and (clk_40MHz'event) then
					counter3 	<= counter3 + 1;
					PWR_OUT_3	<= '0';
					if(counter3 >= x"610000") then
						PWR_OUT_3		<= '1';
						counter3 		<= x"FFFF00";
					end if ;
				end if;
			end process ;
		  		  		  
        process(clk_40MHz)
        begin
				if (PWR_IN(3) = '0') then
					PWR_OUT_4	<= '0';
					counter4 	<= x"000000";
				elsif (clk_40MHz = '1') and (clk_40MHz'event) then
					counter4 	<= counter4 + 1;
					PWR_OUT_4	<= '0';
					if(counter4 >= x"910000") then
						PWR_OUT_4		<= '1';
						counter4 		<= x"FFFF00";
					end if ;
				end if;
			end process ;
		  		  		  
END PWR_CNTRL_arch;
