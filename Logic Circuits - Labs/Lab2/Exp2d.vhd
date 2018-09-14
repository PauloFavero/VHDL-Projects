LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Exp2d IS
PORT (SW : IN STD_LOGIC_VECTOR(17 downto 0);
      LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
      LEDG : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
      HEX0 : OUT STD_LOGIC_VECTOR(0 TO 6);
      HEX1 : OUT STD_LOGIC_VECTOR(0 TO 6);
      HEX4 : OUT STD_LOGIC_VECTOR(0 TO 6);
      HEX6 : OUT STD_LOGIC_VECTOR(0 TO 6));
END Exp2d;



ARCHITECTURE behavior of Exp2d IS



COMPONENT mux IS
PORT (x, y : in STD_LOGIC;
		s: in STD_LOGIC;
		m: out STD_LOGIC);
END COMPONENT;


COMPONENT circuitoA is
port (AA1, AA2, AA3 : IN  STD_LOGIC;
		KK1,KK2,KK3 : OUT STD_LOGIC);
END COMPONENT;


component CircuitoB is
port (Z : IN  STD_LOGIC;
	saidaB : OUT STD_LOGIC_VECTOR(0 to 6));
	END COMPONENT;


COMPONENT Comparador IS
PORT ( Cin : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
 Saida_out: OUT STD_LOGIC );
END COMPONENT;

COMPONENT comparador2 IS
PORT ( comp_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
comp_out: OUT STD_LOGIC );
END COMPONENT;

COMPONENT teste IS
PORT ( Entr_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
Said_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
END COMPONENT;


COMPONENT check6 IS
 PORT ( Check6_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
 Check6_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
END COMPONENT;


COMPONENT Conversor IS
PORT (  entradas : IN STD_LOGIC_VECTOR(3 downto 0);
 display : OUT STD_LOGIC_VECTOR(6 downto 0);
 output : OUT STD_LOGIC);
END COMPONENT;

COMPONENT FullSum IS
PORT (SW_1: IN STD_LOGIC;
      SW_A: IN STD_LOGIC_VECTOR(3 downto 0);
      SW_B: IN STD_LOGIC_VECTOR(3 downto 0);
      LED_G : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END COMPONENT;

COMPONENT mux4 IS
 PORT (aa1: IN STD_LOGIC;
 bb1, bb2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
 oo1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END COMPONENT;

COMPONENT FullSum1Bit IS PORT (x, y, cin: in std_logic;
sum, cout: out std_logic);
END COMPONENT;

COMPONENT Multiplex_2_1 IS
PORT (x, y : in STD_LOGIC;
	s2: in STD_LOGIC;
	m2: out STD_LOGIC);
END COMPONENT;


COMPONENT segment IS
PORT (A7 : IN STD_LOGIC_VECTOR(0 to 3); 
B7 : OUT STD_LOGIC_VECTOR(0 TO 6));
END COMPONENT;


COMPONENT SOMADOR IS
PORT (A, B, C : IN STD_LOGIC;
      S, T: OUT STD_LOGIC);
END COMPONENT;


COMPONENT visor IS
PORT (AAA7: in STD_LOGIC_VECTOR(0 to 3);
      BBB7: out STD_LOGIC_VECTOR(0 to 6));
END COMPONENT;


 SIGNAL a, b : STD_LOGIC_VECTOR(3 DOWNTO 0);
 SIGNAL M1, M2, M3 : STD_LOGIC;
 SIGNAL aux1, aux2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
 SIGNAL SUM: STD_LOGIC_VECTOR(4 DOWNTO 0);
 SIGNAL comp_out: STD_LOGIC;
 SIGNAL sum_4bits : STD_LOGIC_VECTOR(3 DOWNTO 0);
 SIGNAL sub_result, sum_result: STD_LOGIC_VECTOR(3 DOWNTO 0);
 SIGNAL auxiliar: STD_LOGIC;
 SIGNAL vetor_auxiliar: STD_LOGIC_VECTOR(3 DOWNTO 0);
 SIGNAL out_finalmente: STD_LOGIC_VECTOR(3 DOWNTO 0);
 





BEGIN
LEDR <= SW;

R1: visor PORT MAP (SW(7 downto 4), HEX6);
R2: visor PORT MAP (SW(3 downto 0), HEX4);
R3: comparador PORT MAP (SW(7 downto 4), M1);
R4: comparador PORT MAP (SW(3 downto 0), M2);
R5: mux4 PORT MAP (M3, SW(7 downto 4), "0000", aux1);
R6: mux4 PORT MAP (M3, SW(3 downto 0), "0000", aux2);
R7: FullSum PORT MAP (SW(8), aux1, aux2, SUM);
R8: comparador2 PORT MAP (SUM, comp_out);
R9: circuitoB PORT MAP (comp_out, HEX1);
R10: teste PORT MAP (sum_4bits, sub_result);
R11: check6 PORT MAP (sum_4bits, sum_result);
R12: comparador2 PORT MAP (sum_4bits(3),sum_4bits(2),sum_4bits(1),sum_4bits(0), auxiliar);
R13: mux4 PORT MAP (auxiliar, sum_result, sub_result, vetor_auxiliar);
R14: mux4 PORT MAp (comp_out, sum_4bits, vetor_auxiliar, out_finalmente);
R15: visor PORT MAP (out_finalmente, HEX0);





M3 <= M1 or M2;
LEDG(8) <= M3;
sum_4bits(3 downto 0)<= SUM(3 downto 0);








END behavior;