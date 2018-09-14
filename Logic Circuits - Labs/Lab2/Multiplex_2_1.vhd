LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Multiplex_2_1 IS

PORT (x, y : in STD_LOGIC;
		s2: in STD_LOGIC;
		m2: out STD_LOGIC);
END Multiplex_2_1;

		ARCHITECTURE mux_2_to_1 of Multiplex_2_1 IS
		BEGIN

		m2 <= (NOT(s2) AND x) OR (s2 AND y);
		
		END mux_2_to_1;