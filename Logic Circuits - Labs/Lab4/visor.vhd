LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY visor IS
 PORT (C : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
 Display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END visor;


ARCHITECTURE Behavior OF visor IS


 BEGIN
Display(6 DOWNTO 0) <= "0001001" WHEN C="0000" ELSE --H
		"0000110" WHEN C="0001" ELSE  --e
		"1000111" WHEN C="0010" ELSE  --L
		"1000000" WHEN C="0011" ELSE   --0
		"1111111";
	
 END Behavior;