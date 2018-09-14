LIBRARY ieee;
USE ieee.std_logic_1164.all;

--funciona para 4 bits

ENTITY Comparador IS
PORT ( Cin : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
 Saida_out: OUT STD_LOGIC );
END Comparador;

ARCHITECTURE Behavior OF Comparador IS
BEGIN
Saida_out <= Cin(3) AND (Cin(2) OR Cin(1));
END Behavior;