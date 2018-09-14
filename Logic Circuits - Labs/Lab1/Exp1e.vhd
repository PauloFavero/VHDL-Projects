LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Exp1e IS
PORT (  SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
 HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
 HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
 HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
 HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
 HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END Exp1e;

ARCHITECTURE Behavior OF Exp1e IS

COMPONENT mux_3bit_5to1
PORT ( S, U, V, W, X, Y : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
M : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
END COMPONENT;


COMPONENT char_7seg
PORT ( C : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
Display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END COMPONENT;


SIGNAL M0, M1, M2, M3, M4 : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

A: mux_3bit_5to1 PORT MAP (SW(17 DOWNTO 15), SW(14 DOWNTO 12), SW(11 DOWNTO 9), SW(8 DOWNTO 6), SW(5 DOWNTO 3), SW(2 DOWNTO 0), M0);
AA: char_7seg PORT MAP (M0, HEX0);

B: mux_3bit_5to1 PORT MAP (SW(17 DOWNTO 15), SW(11 DOWNTO 9), SW(8 DOWNTO 6), SW(5 DOWNTO 3), SW(2 DOWNTO 0), SW(14 DOWNTO 12), M1);
BB: char_7seg PORT MAP (M1, HEX1);

C: mux_3bit_5to1 PORT MAP (SW(17 DOWNTO 15), SW(8 DOWNTO 6), SW(5 DOWNTO 3), SW(2 DOWNTO 0), SW(14 DOWNTO 12), SW(11 DOWNTO 9), M2);
CC: char_7seg PORT MAP (M2, HEX2);

D: mux_3bit_5to1 PORT MAP (SW(17 DOWNTO 15), SW(5 DOWNTO 3), SW(2 DOWNTO 0), SW(14 DOWNTO 12), SW(11 DOWNTO 9), SW(8 DOWNTO 6), M3);
DD: char_7seg PORT MAP (M3, HEX3);

E: mux_3bit_5to1 PORT MAP (SW(17 DOWNTO 15), SW(2 DOWNTO 0), SW(14 DOWNTO 12), SW(11 DOWNTO 9), SW(8 DOWNTO 6), SW(5 DOWNTO 3), M4);
EE: char_7seg PORT MAP (M4, HEX4);

END Behavior;





LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux_3bit_5to1 is

port (S, U, V, W, X, Y : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
		M : OUT STD_LOGIC_VECTOR(2 DOWNTO 0));
		END mux_3bit_5to1;
		
		ARCHITECTURE behavior of mux_3bit_5to1 IS
		COMPONENT Multiplex_3_BIT_2_1
		
		PORT
		(a,b: in STD_LOGIC_VECTOR(2 downto 0);
		s1: in STD_LOGIC;
		m_out: out STD_LOGIC_VECTOR(2 downto 0)
		);
		
		END COMPONENT;
		
		signal m0, m1, m2: STD_LOGIC_VECTOR(2 downto 0);
	
	begin	
		MUX0: Multiplex_3_BIT_2_1 port map (U, V, S(2), m0);
		MUX1: Multiplex_3_BIT_2_1 port map (W, X, S(2), m1);
		MUX2: Multiplex_3_BIT_2_1 port map (m0, m1, S(1), m2);
		MUX3: Multiplex_3_BIT_2_1 port map (m2, Y, S(0), M);
		end behavior;
		
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Multiplex_3_BIT_2_1 IS
PORT	(a,b: in STD_LOGIC_VECTOR(2 downto 0);
		s1: in STD_LOGIC;
		m_out: out STD_LOGIC_VECTOR(2 downto 0)
		);
END Multiplex_3_BIT_2_1;

ARCHITECTURE mux_3_bit_2_1 OF Multiplex_3_BIT_2_1 IS
COMPONENT Multiplex_2_1
PORT (x,y : IN  STD_LOGIC;
		s2: IN STD_LOGIC;
		m2: OUT STD_LOGIC);
		END COMPONENT;
		
BEGIN
M0: Multiplex_2_1 port map (a(0), b(0), s1, m_out(0));
M1: Multiplex_2_1 port map (a(1), b(1), s1, m_out(1));
M2: Multiplex_2_1 port map (a(2), b(2), s1, m_out(2));
END mux_3_bit_2_1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Multiplex_2_1 IS

PORT (x, y : in bit;
		s2: in bit;
		m2: out bit);
END Multiplex_2_1;

		ARCHITECTURE mux_2_to_1 of Multiplex_2_1 IS
		BEGIN

		m2 <= (NOT(s2) AND x) OR (s2 AND y);
		
		END mux_2_to_1;

		
			
		
		
		
		LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY char_7seg IS
 PORT (C : IN STD_LOGIC_VECTOR(2 DOWNTO 0); 
 Display : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END char_7seg;


ARCHITECTURE Behavior OF char_7seg IS


 BEGIN
Display(6 downto 0) <= "0001001" WHEN C="000" ELSE
		"0000110" WHEN C="001" ELSE
		"1000111" WHEN C="010" ELSE
		"1000000" WHEN C="011" ELSE
		"1111111";
	
 END Behavior;