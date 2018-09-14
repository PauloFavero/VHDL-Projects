LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FFD IS
	PORT (Clk, D, Clear: IN STD_LOGIC;
			Q: OUT STD_LOGIC);
END ENTITY;

ARCHITECTURE Behavior OF FFD IS


BEGIN
	
	PROCESS (Clk, Clear)
	
		VARIABLE varQ: STD_LOGIC := '0';
	
	BEGIN
		
		IF Clear = '0' THEN
		
			varQ := '0';
		
		ELSIF rising_edge(Clk) THEN
		
			varQ := D;
		
		END IF;
		
		
		Q <= varQ;
		
		
	END PROCESS;
	
END ARCHITECTURE Behavior;