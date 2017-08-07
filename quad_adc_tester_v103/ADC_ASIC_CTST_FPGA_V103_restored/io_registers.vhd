--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: IO_registers.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 5/19/2015
--////  Description:  TOP LEVEL DUNE FE ASIC CHIP TESTER
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

ENTITY IO_registers IS

	PORT
	(
		Version		: IN STD_LOGIC_VECTOR(15 downto 0);	
		rst         : IN STD_LOGIC;				-- state machine reset
		clk         : IN STD_LOGIC;
		data        : IN STD_LOGIC_VECTOR(31 downto 0);	
		WR_address  : IN STD_LOGIC_VECTOR(15 downto 0); 
		RD_address  : IN STD_LOGIC_VECTOR(15 downto 0); 
		WR    	 	: IN STD_LOGIC;	
		data_out		: OUT  STD_LOGIC_VECTOR(31 downto 0);				
		SPI_1			: OUT  STD_LOGIC_VECTOR(143 downto 0);				
		SPI_2			: OUT  STD_LOGIC_VECTOR(143 downto 0);				
		SPI_3			: OUT  STD_LOGIC_VECTOR(143 downto 0);				
		SPI_4			: OUT  STD_LOGIC_VECTOR(143 downto 0);		
		SPI_5			: OUT  STD_LOGIC_VECTOR(143 downto 0);		
		reg0_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg1_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg2_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg3_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg4_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg5_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg6_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg7_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg8_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg9_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg10_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg11_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg12_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg13_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg14_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg15_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg16_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg17_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg18_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg19_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg20_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg21_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg22_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg23_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg24_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg25_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg26_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg27_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg28_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg29_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg30_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg31_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg32_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg33_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg34_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg35_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg36_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg37_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg38_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg39_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg40_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg41_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg42_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg43_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg44_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg45_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg46_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg47_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg48_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg49_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg50_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg51_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg52_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg53_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg54_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg55_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg56_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg57_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg58_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg59_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg60_i		: IN  STD_LOGIC_VECTOR(31 downto 0);		
		reg61_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg62_i		: IN  STD_LOGIC_VECTOR(31 downto 0);	
		reg63_i		: IN  STD_LOGIC_VECTOR(31 downto 0);			
		
		
	
		
		reg0_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg1_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg2_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg3_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg4_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg5_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg6_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg7_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg8_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg9_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg10_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg11_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg12_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg13_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg14_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg15_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg16_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg17_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg18_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg19_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg20_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg21_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg22_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg23_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg24_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg25_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg26_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg27_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg28_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg29_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg30_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg31_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg32_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg33_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg34_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg35_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg36_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg37_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg38_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg39_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);			
		reg40_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);
		reg41_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg42_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg43_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg44_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg45_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg46_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg47_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg48_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg49_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg50_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg51_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg52_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg53_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg54_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg55_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);			
		reg56_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg57_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg58_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg59_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg60_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);		
		reg61_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg62_o		: OUT  STD_LOGIC_VECTOR(31 downto 0);	
		reg63_o		: OUT  STD_LOGIC_VECTOR(31 downto 0)			
	
	
	);
	
END IO_registers;


ARCHITECTURE behavior OF IO_registers IS


signal		reg64_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg65_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg66_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg67_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg68_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg69_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg70_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg71_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg72_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg73_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg74_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg75_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg76_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg77_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg78_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg79_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg80_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg81_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg82_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg83_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg84_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg85_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg86_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg87_O		: STD_LOGIC_VECTOR(31 downto 0);	
signal		reg88_O		: STD_LOGIC_VECTOR(31 downto 0);	


begin

	SPI_1  <= reg68_O(15 downto 0) & reg67_O & reg66_O & reg65_O & reg64_O;
	SPI_2  <= reg73_O(15 downto 0) & reg72_O & reg71_O & reg70_O & reg69_O;
	SPI_3  <= reg78_O(15 downto 0) & reg77_O & reg76_O & reg75_O & reg74_O;
	SPI_4  <= reg83_O(15 downto 0) & reg82_O & reg81_O & reg80_O & reg79_O;  
	SPI_5  <= reg88_O(15 downto 0) & reg87_O & reg86_O & reg85_O & reg84_O;  
	

  data_out		<=	 reg0_i 	when (RD_address(7 downto 0) = x"00")	else
						 reg1_i 	when (RD_address(7 downto 0) = x"01")	else
						 reg2_i 	when (RD_address(7 downto 0) = x"02")	else
						 reg3_i 	when (RD_address(7 downto 0) = x"03")	else
						 reg4_i 	when (RD_address(7 downto 0) = x"04")	else
						 reg5_i 	when (RD_address(7 downto 0) = x"05")	else
						 reg6_i 	when (RD_address(7 downto 0) = x"06")	else
						 reg7_i 	when (RD_address(7 downto 0) = x"07")	else
						 reg8_i 	when (RD_address(7 downto 0) = x"08")	else
						 reg9_i 	when (RD_address(7 downto 0) = x"09")	else
						 reg10_i	when (RD_address(7 downto 0) = x"0a")	else
						 reg11_i	when (RD_address(7 downto 0) = x"0b")	else
						 reg12_i	when (RD_address(7 downto 0) = x"0c")	else
						 reg13_i	when (RD_address(7 downto 0) = x"0d")	else
						 reg14_i	when (RD_address(7 downto 0) = x"0e")	else
						 reg15_i	when (RD_address(7 downto 0) = x"0f")	else
						 reg16_i	when (RD_address(7 downto 0) = x"10")	else
						 reg17_i	when (RD_address(7 downto 0) = x"11")	else
						 reg18_i	when (RD_address(7 downto 0) = x"12")	else
						 reg19_i	when (RD_address(7 downto 0) = x"13")	else
						 reg20_i	when (RD_address(7 downto 0) = x"14")	else
						 reg21_i	when (RD_address(7 downto 0) = x"15")	else
						 reg22_i	when (RD_address(7 downto 0) = x"16")	else
						 reg23_i	when (RD_address(7 downto 0) = x"17")	else
						 reg24_i	when (RD_address(7 downto 0) = x"18")	else
						 reg25_i	when (RD_address(7 downto 0) = x"19")	else
						 reg26_i	when (RD_address(7 downto 0) = x"1a")	else
						 reg27_i	when (RD_address(7 downto 0) = x"1b")	else
						 reg28_i	when (RD_address(7 downto 0) = x"1c")	else
						 reg29_i	when (RD_address(7 downto 0) = x"1d")	else
						 reg30_i	when (RD_address(7 downto 0) = x"1e")	else
						 reg31_i	when (RD_address(7 downto 0) = x"1f")	else
						 reg32_i	when (RD_address(7 downto 0) = x"20")	else
						 reg33_i	when (RD_address(7 downto 0) = x"21")	else
						 reg34_i	when (RD_address(7 downto 0) = x"22")	else
						 reg35_i	when (RD_address(7 downto 0) = x"23")	else
						 reg36_i	when (RD_address(7 downto 0) = x"24")	else
						 reg37_i	when (RD_address(7 downto 0) = x"25")	else
						 reg38_i	when (RD_address(7 downto 0) = x"26")	else
						 reg39_i	when (RD_address(7 downto 0) = x"27")	else
						 reg40_i	when (RD_address(7 downto 0) = x"28")	else	 
						 reg41_i	when (RD_address(7 downto 0) = x"29")	else						 
						 reg42_i	when (RD_address(7 downto 0) = x"2a")	else						 
						 reg43_i	when (RD_address(7 downto 0) = x"2b")	else						 
						 reg44_i	when (RD_address(7 downto 0) = x"2c")	else						 
						 reg45_i	when (RD_address(7 downto 0) = x"2d")	else
						 reg46_i	when (RD_address(7 downto 0) = x"2e")	else						 
						 reg47_i	when (RD_address(7 downto 0) = x"2f")	else						 
						 reg48_i	when (RD_address(7 downto 0) = x"30")	else						 
						 reg49_i	when (RD_address(7 downto 0) = x"31")	else						 
						 reg50_i	when (RD_address(7 downto 0) = x"32")	else
						 reg51_i	when (RD_address(7 downto 0) = x"33")	else						 
						 reg52_i	when (RD_address(7 downto 0) = x"34")	else						 
						 reg53_i	when (RD_address(7 downto 0) = x"35")	else						 
						 reg54_i	when (RD_address(7 downto 0) = x"36")	else						 
						 reg55_i	when (RD_address(7 downto 0) = x"37")	else
						 reg56_i	when (RD_address(7 downto 0) = x"38")	else						 
						 reg57_i	when (RD_address(7 downto 0) = x"39")	else						 
						 reg58_i	when (RD_address(7 downto 0) = x"3A")	else						 
						 reg59_i	when (RD_address(7 downto 0) = x"3B")	else						 
						 reg60_i	when (RD_address(7 downto 0) = x"3C")	else
						 reg61_i	when (RD_address(7 downto 0) = x"3D")	else						 
						 reg62_i	when (RD_address(7 downto 0) = x"3E")	else						 
						 reg63_i	when (RD_address(7 downto 0) = x"3F")	else				
						 reg64_O	when (RD_address(7 downto 0) = x"40")	else
						 reg65_O	when (RD_address(7 downto 0) = x"41")	else
						 reg66_O	when (RD_address(7 downto 0) = x"42")	else
						 reg67_O	when (RD_address(7 downto 0) = x"43")	else
						 reg68_O	when (RD_address(7 downto 0) = x"44")	else
						 reg69_O	when (RD_address(7 downto 0) = x"45")	else
						 reg70_O	when (RD_address(7 downto 0) = x"46")	else	 
						 reg71_O	when (RD_address(7 downto 0) = x"47")	else						 
						 reg72_O	when (RD_address(7 downto 0) = x"48")	else						 
						 reg73_O	when (RD_address(7 downto 0) = x"49")	else						 
						 reg74_O	when (RD_address(7 downto 0) = x"4A")	else						 
						 reg75_O	when (RD_address(7 downto 0) = x"4B")	else
						 reg76_O	when (RD_address(7 downto 0) = x"4C")	else						 
						 reg77_O	when (RD_address(7 downto 0) = x"4D")	else						 
						 reg78_O	when (RD_address(7 downto 0) = x"4E")	else						 
						 reg79_O	when (RD_address(7 downto 0) = x"4F")	else						 
						 reg80_O	when (RD_address(7 downto 0) = x"50")	else
						 reg81_O	when (RD_address(7 downto 0) = x"51")	else						 
						 reg82_O	when (RD_address(7 downto 0) = x"52")	else						 
						 reg83_O	when (RD_address(7 downto 0) = x"53")	else	
						 reg84_O	when (RD_address(7 downto 0) = x"54")	else							 
						 reg85_O	when (RD_address(7 downto 0) = x"55")	else
						 reg86_O	when (RD_address(7 downto 0) = x"56")	else						 
						 reg87_O	when (RD_address(7 downto 0) = x"57")	else						 
						 reg88_O	when (RD_address(7 downto 0) = x"58")	else
						 x"0000" & Version	when (RD_address(7 downto 0) = x"FF")	else
						 X"00000000";

					 
	 
					 
					 
  process(clk,WR,rst) 
  begin
		if (rst = '1') then
			reg0_o		<= X"00000000";		
			reg1_o		<= X"00000000";	
			reg2_o		<= X"00000000";		
			reg3_o		<= X"00000000";	
			reg4_o		<= X"00000000";	
			reg5_o		<= X"00000000";	
			reg6_o		<= X"00000000";	
			reg7_o		<= X"00000000";	
			reg8_o		<= X"00000000";		
			reg9_o		<= X"00000000";	
			reg10_o		<= X"00000000";
			reg11_o		<= X"00000000";	
			reg12_o		<= X"00000000";		
			reg13_o		<= X"00000000";
			reg14_o		<= X"00000000";	
			reg15_o		<= X"00000000";
			reg16_o		<= X"00000000";		
			reg17_o		<= X"00000000";	
			reg18_o		<= X"00000000";
			reg19_o		<= X"00000000";
			reg20_o		<= X"00000000";	
			reg21_o		<= X"00000000";	
			reg22_o		<= X"00000000";	
			reg23_o		<= X"00000000";	
			reg24_o		<= X"00000000";		
			reg25_o		<= X"00000000";
			reg26_o		<= X"00000000";
			reg27_o		<= X"00000000";
			reg28_o		<= X"00000000";		
			reg29_o		<= X"00000000";
			reg30_o		<= X"00000000";
			reg31_o		<= X"00000000";
			reg32_o		<= X"00000000";	
			reg33_o		<= X"00000000";	
			reg34_o		<= X"00000000";		
			reg35_o		<= X"00000000";
			reg36_o		<= X"00000000";
			reg37_o		<= X"00000000";
			reg38_o		<= X"00000000";		
			reg39_o		<= X"00000000";
			reg40_o		<= X"00000000";		
			reg41_o		<= X"00000000";	
			reg42_o		<= X"00000000";	
			reg43_o		<= X"00000000";	
			reg44_o		<= X"00000000";		
			reg45_o		<= X"00000000";
			reg46_o		<= X"00000000";
			reg47_o		<= X"00000000";
			reg48_o		<= X"00000000";		
			reg49_o		<= X"00000000";
			reg50_o		<= X"00000000";
			reg51_o		<= X"00000000";
			reg52_o		<= X"00000000";	
			reg53_o		<= X"00000000";	
			reg54_o		<= X"00000000";		
			reg55_o		<= X"00000000";
			reg56_o		<= X"00000000";
			reg57_o		<= X"00000000";
			reg58_o		<= X"00000000";		
			reg59_o		<= X"00000000";
			reg60_o		<= X"00000000";
			reg61_o		<= X"00000000";
			reg62_o		<= X"00000000";	
			reg63_o		<= X"000001fb";	
			reg64_o		<= X"00000000";	
			reg65_o		<= X"00000000";	
			reg66_o		<= X"00000000";	
			reg67_o		<= X"00000000";	
			reg68_o		<= X"00000000";		
			reg69_o		<= X"00000000";	
			reg70_o		<= X"00000000";
			reg71_o		<= X"00000000";	
			reg72_o		<= X"00000000";		
			reg73_o		<= X"00000000";
			reg74_o		<= X"00000000";	
			reg75_o		<= X"00000000";
			reg76_o		<= X"00000000";		
			reg77_o		<= X"00000000";	
			reg78_o		<= X"00000000";
			reg79_o		<= X"00000000";
			reg80_o		<= X"00000000";	
			reg81_o		<= X"00000000";	
			reg82_o		<= X"00000000";	
			reg83_o		<= X"00000000";	
			reg84_o		<= X"00000000";		
			reg85_o		<= X"00000000";
			reg86_o		<= X"00000000";
			reg87_o		<= X"00000000";
			reg88_o		<= X"00000000";		



	
		elsif (clk'event  AND  clk = '1') then
		if (WR = '1') then
     		CASE WR_address(7 downto 0) IS
     			when x"00" => 	reg0_o   <= data;
	     		when x"01" => 	reg1_o   <= data;	
    	 		when x"02" => 	reg2_o   <= data;
     			when x"03" => 	reg3_o   <= data;
    	 		when x"04" => 	reg4_o   <= data;
     			when x"05" => 	reg5_o   <= data;
     			when x"06" => 	reg6_o   <= data;
     			when x"07" => 	reg7_o   <= data;
     			when x"08" => 	reg8_o   <= data;
     			when x"09" => 	reg9_o   <= data;	
     			when x"0A" => 	reg10_o  <= data;
     			when x"0B" => 	reg11_o  <= data;
     			when x"0C" => 	reg12_o  <= data;
     			when x"0D" => 	reg13_o  <= data;
     			when x"0E" => 	reg14_o  <= data;
     			when x"0F" => 	reg15_o  <= data;
     			when x"10" => 	reg16_o  <= data;
     			when x"11" => 	reg17_o  <= data;
     			when x"12" => 	reg18_o  <= data;
     			when x"13" => 	reg19_o  <= data;
     			when x"14" => 	reg20_o  <= data;
     			when x"15" => 	reg21_o  <= data;
     			when x"16" => 	reg22_o  <= data;
     			when x"17" => 	reg23_o  <= data;
     			when x"18" => 	reg24_o  <= data;
     			when x"19" => 	reg25_o  <= data;
     			when x"1A" => 	reg26_o  <= data;
     			when x"1B" => 	reg27_o  <= data;
     			when x"1C" => 	reg28_o  <= data;
     			when x"1D" => 	reg29_o  <= data;
     			when x"1E" => 	reg30_o  <= data;
     			when x"1F" => 	reg31_o  <= data;
	    		when x"20" => 	reg32_o  <= data;
     			when x"21" => 	reg33_o  <= data;
     			when x"22" => 	reg34_o  <= data;
     			when x"23" => 	reg35_o  <= data;
     			when x"24" => 	reg36_o  <= data;
     			when x"25" => 	reg37_o  <= data;
     			when x"26" => 	reg38_o  <= data;
     			when x"27" => 	reg39_o  <= data;	
     			when x"28" => 	reg40_o  <= data;	
     			when x"29" => 	reg41_o  <= data;
     			when x"2A" => 	reg42_o  <= data;
     			when x"2B" => 	reg43_o  <= data;
     			when x"2C" => 	reg44_o  <= data;
     			when x"2D" => 	reg45_o  <= data;
     			when x"2E" => 	reg46_o  <= data;
     			when x"2F" => 	reg47_o  <= data;
     			when x"30" => 	reg48_o  <= data;
     			when x"31" => 	reg49_o  <= data;
     			when x"32" => 	reg50_o  <= data;
     			when x"33" => 	reg51_o  <= data;
	    		when x"34" => 	reg52_o  <= data;
     			when x"35" => 	reg53_o  <= data;
     			when x"36" => 	reg54_o  <= data;
     			when x"37" => 	reg55_o  <= data;				
   			when x"38" => 	reg56_o  <= data;
     			when x"39" => 	reg57_o  <= data;
     			when x"3A" => 	reg58_o  <= data;
     			when x"3B" => 	reg59_o  <= data;
     			when x"3C" => 	reg60_o  <= data;
     			when x"3D" => 	reg61_o  <= data;
	    		when x"3E" => 	reg62_o  <= data;
     			when x"3F" => 	reg63_o  <= data;
    			when x"40" => 	reg64_o  <= data;
     			when x"41" => 	reg65_o  <= data;
     			when x"42" => 	reg66_o  <= data;
     			when x"43" => 	reg67_o  <= data;
     			when x"44" => 	reg68_o  <= data;
     			when x"45" => 	reg69_o  <= data;
     			when x"46" => 	reg70_o  <= data;
     			when x"47" => 	reg71_o  <= data;
     			when x"48" => 	reg72_o  <= data;
     			when x"49" => 	reg73_o  <= data;
     			when x"4A" => 	reg74_o  <= data;
     			when x"4B" => 	reg75_o  <= data;
     			when x"4C" => 	reg76_o  <= data;
     			when x"4D" => 	reg77_o  <= data;
     			when x"4E" => 	reg78_o  <= data;
     			when x"4F" => 	reg79_o  <= data;
     			when x"50" => 	reg80_o  <= data;
     			when x"51" => 	reg81_o  <= data;
	    		when x"52" => 	reg82_o  <= data;
     			when x"53" => 	reg83_o  <= data;
     			when x"54" => 	reg84_o  <= data;
     			when x"55" => 	reg85_o  <= data;
     			when x"56" => 	reg86_o  <= data;
     			when x"57" => 	reg87_o  <= data;
     			when x"58" => 	reg88_o  <= data;
				
     			WHEN OTHERS =>  
     		end case;  
		 end if;
	end if;
end process;
	

END behavior;
