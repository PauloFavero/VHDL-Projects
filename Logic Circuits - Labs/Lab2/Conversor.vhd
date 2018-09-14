LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY Conversor IS
PORT (  entradas : IN STD_LOGIC_VECTOR(0 to 3);
 display : OUT STD_LOGIC_VECTOR(0 to 6);
 output : OUT STD_LOGIC);

END Conversor;



ARCHITECTURE Behavior OF Conversor IS



COMPONENT Multiplex_2_1
PORT ( x, y : in STD_LOGIC;
		s2: in STD_LOGIC;
		m2: out STD_LOGIC);
END COMPONENT;


COMPONENT Comparador is
port (R1, S1, T1 : IN  STD_LOGIC;
		W1 : OUT STD_LOGIC);
		END COMPONENT;


COMPONENT CircuitoB is
port (Z : IN  STD_LOGIC;
		saidaB : OUT STD_LOGIC);
END COMPONENT;
		

COMPONENT circuitoA is

port (AA1, AA2, AA3 : IN  STD_LOGIC;
		KK1,KK2,KK3 : OUT STD_LOGIC);
		END COMPONENT;


COMPONENT visor is
PORT (AAA7: in STD_LOGIC_VECTOR(0 to 3);
		BBB7: out STD_LOGIC_VECTOR(0 to 6));
END COMPONENT;
 
 
 
 
SIGNAL M0, M1, M2, M3, M4, M5, M6, M7 : STD_LOGIC;
SIGNAL N0, N1 : STD_LOGIC_VECTOR(0 to 6);
SIGNAL O: STD_LOGIC_VECTOR(0 to 3);

BEGIN

O(0) <= M4;
O(1) <= M5;
O(2) <= M6;
O(3) <= M7;

P0: Comparador PORT MAP (entradas(3), entradas(2), entradas(1), M0);
P1: CircuitoA PORT MAP (entradas(2), entradas(1), entradas(0), M1, M2, M3);
P2: Multiplex_2_1 PORT MAP (entradas(3), '0', M0, M4);
P3: Multiplex_2_1 PORT MAP (entradas(2), M1, M0, M5);
P4: Multiplex_2_1 PORT MAP (entradas(1), M2, M0, M6);
P5: Multiplex_2_1 PORT MAP (entradas(0), M3,M0, M7);
P6: CircuitoB PORT MAP (M0, output);
P7: visor PORT MAP (O, display);

END Behavior;
