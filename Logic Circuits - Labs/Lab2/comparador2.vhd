LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- funciona para 5 bits

ENTITY comparador2 IS
PORT ( comp_in : IN STD_LOGIC_VECTOR(4 DOWNTO 0); 
comp_out: OUT STD_LOGIC );
END comparador2;

ARCHITECTURE Behavior OF comparador2 IS
BEGIN
 
comp_out <= comp_in(4) OR (comp_in(3) AND (comp_in(2) OR comp_in(1)));
 
 END Behavior;