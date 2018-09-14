LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY SOMADOR IS
PORT (A, B, C : IN STD_LOGIC;
		S, T: OUT STD_LOGIC);
END SOMADOR;

ARCHITECTURE behavior of SOMADOR IS

SIGNAL M0: STD_LOGIC;

COMPONENT mux IS
PORT (x, y : in STD_LOGIC;
		s: in STD_LOGIC;
		m: out STD_LOGIC);
END COMPONENT;

Begin
M0 <= A XOR B;
S <= M0 XOR C;

X: mux PORT MAP (B, C, M0, T);

END behavior;
