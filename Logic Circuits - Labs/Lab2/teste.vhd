LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY teste IS
PORT ( Entr_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
Said_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0) );
END teste;



ARCHITECTURE Behavior OF teste IS
 BEGIN
 Said_out(0) <= Entr_in(0);
 Said_out(1) <= NOT(Entr_in(1));
 Said_out(2) <= Entr_in(2) AND Entr_in(1);
 Said_out(3) <= '0';
 END Behavior;