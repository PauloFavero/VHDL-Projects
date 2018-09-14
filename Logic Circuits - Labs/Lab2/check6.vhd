LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY check6 IS
 PORT ( Check6_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
 Check6_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
END check6;


ARCHITECTURE Behavior OF check6 IS
BEGIN
 Check6_out(3) <= Check6_in(3) or Check6_in(1);
 Check6_out(2) <= NOT (Check6_in(1));
 Check6_out(1) <= Check6_in(2) or (not(Check6_in(1)));
 Check6_out(0) <= Check6_in(0);
 END Behavior;