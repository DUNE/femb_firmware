
--/////////////////////////////////////////////////////////////////////
--////                              
--////  File: LBNE_HSTX.VHD            
--////                                                                                                                                      
--////  Author: Jack Fried			                  
--////          jfried@bnl.gov	              
--////  Created: 11/04/2014 
--////  Description:  
--////					
--////
--/////////////////////////////////////////////////////////////////////
--////
--//// Copyright (C) 2014 Brookhaven National Laboratory
--////
--/////////////////////////////////////////////////////////////////////

library ieee;
use ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
USE work.SbndPkg.all;

entity LBNE_HSTX is
	PORT
	(

		GXB_TX_A			: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		rst				: IN STD_LOGIC;
		cal_clk_125MHz	: IN STD_LOGIC;
		gxb_clk			: IN STD_LOGIC;			
		Stream_EN		: IN STD_LOGIC;	
		PRBS_EN			: IN STD_LOGIC;	
		CNT_EN			: IN STD_LOGIC;			
		DATA_CLK			: IN STD_LOGIC;
		DATA_VALID		: IN STD_LOGIC;			
		LANE1_DATA		: IN STD_LOGIC_VECTOR(15 downto 0);
		LANE2_DATA		: IN STD_LOGIC_VECTOR(15 downto 0);
		LANE3_DATA		: IN STD_LOGIC_VECTOR(15 downto 0);		
		LANE4_DATA		: IN STD_LOGIC_VECTOR(15 downto 0)			
	);
end LBNE_HSTX;


architecture LBNE_HSTX_arch of LBNE_HSTX is


component ALTGX_TX
	PORT
	(
		tx_dataout		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0);	
		tx_datain		: IN STD_LOGIC_VECTOR (63 DOWNTO 0);	
		tx_ctrlenable	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);	
		tx_digitalreset: IN STD_LOGIC_VECTOR (3 DOWNTO 0);		
		cal_blk_clk		: IN STD_LOGIC;
		pll_inclk		: IN STD_LOGIC;
		pll_locked		: OUT STD_LOGIC;
		tx_clkout		: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
end component;


component ADC_FIFO
	PORT
	(
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdclk		: IN STD_LOGIC ;
		rdreq		: IN STD_LOGIC ;
		wrclk		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		q			: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdempty		: OUT STD_LOGIC ;
		wrfull		: OUT STD_LOGIC 
	);
end component;


SIGNAL	TX_DATA1				: STD_LOGIC_VECTOR(15 downto 0);
SIGNAL	TX_DATA2				: STD_LOGIC_VECTOR(15 downto 0);
SIGNAL	TX_DATA3				: STD_LOGIC_VECTOR(15 downto 0);
SIGNAL	TX_DATA4				: STD_LOGIC_VECTOR(15 downto 0);

SIGNAL	FIFO_DATA1			: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL	FIFO_DATA2			: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL	FIFO_DATA3			: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL	FIFO_DATA4			: STD_LOGIC_VECTOR (15 DOWNTO 0);

SIGNAL	tx_ctrlenable		: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL	tx_digitalreset	: STD_LOGIC;
SIGNAL	tx_clkout			: STD_LOGIC_VECTOR (3 DOWNTO 0);
SIGNAL	counter				: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL	prbs_data			: STD_LOGIC_VECTOR (15 DOWNTO 0);
SIGNAL	ADC_FIFO_EMPTY		: STD_LOGIC;

begin


ALTGX_TX_inst	: ALTGX_TX
	PORT MAP
	(
		tx_dataout			=> GXB_TX_A,	
		cal_blk_clk			=>	cal_clk_125MHz,
		pll_inclk			=> gxb_clk,
		tx_ctrlenable		=> tx_ctrlenable & tx_ctrlenable & tx_ctrlenable & tx_ctrlenable,	 	
		tx_datain			=> TX_DATA4 & TX_DATA3 & TX_DATA2 & TX_DATA1,	
		tx_digitalreset	=>	tx_digitalreset & tx_digitalreset & tx_digitalreset & tx_digitalreset,
		tx_clkout			=>	tx_clkout,
		pll_locked			=> open

	);

	
	tx_digitalreset	<=  rst;
	tx_ctrlenable	<= b"11"		when (Stream_EN 	= '0') else
							b"00"		when (CNT_EN 	= '1') or (PRBS_EN 	= '1') else
							b"00"		when (ADC_FIFO_EMPTY = '0') else
							b"11";
														
	TX_DATA1		<=		x"BCFB"			when (Stream_EN 	= '0') else
							counter			when (CNT_EN 	= '1') else
							prbs_data		when (PRBS_EN 	= '1') else
							FIFO_DATA1	   when (ADC_FIFO_EMPTY = '0') else
							x"BCFB";

	TX_DATA2		<=		x"BCFB"			when (Stream_EN 	= '0') else
							 counter			when (CNT_EN 	= '1') else
							prbs_data		when (PRBS_EN 	= '1') else
							FIFO_DATA2	   when (ADC_FIFO_EMPTY = '0') else
							x"BCFB";
							
	TX_DATA3		<=		x"BCFB"			when (Stream_EN 	= '0') else
							 counter			when (CNT_EN 	= '1') else
							prbs_data		when (PRBS_EN 	= '1') else
							FIFO_DATA3	   when (ADC_FIFO_EMPTY = '0') else
							x"BCFB";		
							
	TX_DATA4		<=		x"BCFB"			when (Stream_EN 	= '0') else
							 counter			when (CNT_EN 	= '1') else
							prbs_data		when (PRBS_EN 	= '1') else
							FIFO_DATA4	   when (ADC_FIFO_EMPTY = '0') else
							x"BCFB";
	


ADC_FIFO_inst1 : ADC_FIFO
	PORT MAP
	(
		data		=> LANE1_DATA,
		wrclk		=>	DATA_CLK,
		wrreq		=> DATA_VALID and Stream_EN,
		rdclk		=> tx_clkout(0),
		rdreq		=> '1',
		q			=> FIFO_DATA1,
		rdempty	=> ADC_FIFO_EMPTY,
		wrfull	=> OPEN
	);		
		
			
	ADC_FIFO_inst2 : ADC_FIFO
	PORT MAP
	(
		data		=> LANE2_DATA,
		wrclk		=>	DATA_CLK,
		wrreq		=> DATA_VALID and Stream_EN,
		rdclk		=> tx_clkout(0),
		rdreq		=> '1',
		q			=> FIFO_DATA2,
		rdempty	=> OPEN,
		wrfull	=> OPEN
	);		
		
	ADC_FIFO_inst3 : ADC_FIFO
	PORT MAP
	(
		data		=> LANE3_DATA,
		wrclk		=>	DATA_CLK,
		wrreq		=> DATA_VALID and Stream_EN,
		rdclk		=> tx_clkout(0),
		rdreq		=> '1',
		q			=> FIFO_DATA3,
		rdempty	=> OPEN,
		wrfull	=> OPEN
	);		
	
	ADC_FIFO_inst4 : ADC_FIFO
	PORT MAP
	(
		data		=> LANE4_DATA,
		wrclk		=>	DATA_CLK,
		wrreq		=> DATA_VALID and Stream_EN,
		rdclk		=> tx_clkout(0),
		rdreq		=> '1',
		q			=> FIFO_DATA4,
		rdempty	=> OPEN,
		wrfull	=> OPEN
	);			

process(tx_clkout(0),rst) 
begin
	if  (rst = '1') then
		counter 		<= (others => '0');
		prbs_data	<= (others => '0');
	elsif tx_clkout(0)'event and tx_clkout(0) = '1' then
			counter		<= counter + 1;
			prbs_data	<= PRBS_GEN(prbs_data);
	end if;
end process;
	
end LBNE_HSTX_arch;
