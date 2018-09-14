LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux IS

PORT (x, y : in STD_logic;
		s: in STD_logic;
		m: out STD_logic);
END mux;

		ARCHITECTURE comportamento of mux IS
		BEGIN

		m <= (NOT(s) AND x) OR (s AND y);
		
		END comportamento;