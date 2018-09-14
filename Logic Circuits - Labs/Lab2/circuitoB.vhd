LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity CircuitoB is

port (Z : IN  STD_LOGIC;
		saidaB : OUT STD_LOGIC_VECTOR(0 to 6));
		END CircuitoB;
		
		ARCHITECTURE behavior_CircuitoB of CircuitoB IS
		begin
		
	
saidaB <= "1001111" WHEN Z='1' ELSE
	"0000001";
	
		end behavior_CircuitoB;		
		