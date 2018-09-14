LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY FullSum IS
PORT (SW_1: IN STD_LOGIC;
      SW_A: IN STD_LOGIC_VECTOR(3 downto 0);
      SW_B: IN STD_LOGIC_VECTOR(3 downto 0);
      LED_G : OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END FullSum;

ARCHITECTURE behavior of FullSum IS

SIGNAL M1: STD_LOGIC_VECTOR(3 DOWNTO 0);

COMPONENT mux IS
PORT (x, y : in STD_LOGIC;
		s: in STD_LOGIC;
		m: out STD_LOGIC);
END COMPONENT;

COMPONENT SOMADOR IS
PORT (A, B, C : IN STD_LOGIC;
		S, T: OUT STD_LOGIC);
END COMPONENT;

SIGNAL Mx: STD_LOGIC_VECTOR(2 downto 0);


begin
A: SOMADOR PORT MAP (SW_A(0), SW_B(0), SW_1, LED_G(0), Mx(2));
B: SOMADOR PORT MAP (SW_A(1), SW_B(1), Mx(2), LED_G(1), Mx(1));
C: SOMADOR PORT MAP (SW_A(2), SW_B(2), Mx(1), LED_G(2), Mx(0));
D: SOMADOR PORT MAP (SW_A(3), SW_B(3), Mx(0), LED_G(3), LED_G(4));


END behavior;