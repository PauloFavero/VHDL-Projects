LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Somador4Bits IS
PORT (x, y : IN std_logic_vector(3 DOWNTO 0);
cin: in std_logic; 
s: out std_logic_vector(3 DOWNTO 0);
cout: out std_logic); 
END Somador4Bits;

ARCHITECTURE Somador4Bits_comportamento OF Somador4Bits IS
COMPONENT Somador1Bit
PORT (
x , y, cin : in std_logic; 
s , cout : out std_logic);
 
END COMPONENT;

SIGNAL c: std_logic_vector(2 DOWNTO 0);

BEGIN
  
s0: Somador1Bit PORT MAP (x(0), y(0), cin, s(0), c(0));
s1: Somador1Bit PORT MAP (x(1), y(1), c(0), s(1), c(1));
s2: Somador1Bit PORT MAP (x(2), y(2), c(1), s(2), c(2));
s3: Somador1Bit PORT MAP (x(3), y(3), c(2), s(3), cout);
  
END Somador4Bits_comportamento;
