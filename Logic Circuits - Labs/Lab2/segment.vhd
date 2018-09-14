		
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY segment IS
 PORT (A7 : IN STD_LOGIC_VECTOR(0 to 3); 
 B7 : OUT STD_LOGIC_VECTOR(0 TO 6));
 END segment;
 
ARCHITECTURE Behavior_segment OF segment IS

COMPONENT visor
PORT (AAA7: in STD_LOGIC_VECTOR(0 to 3);
		BBB7: out STD_LOGIC_VECTOR(0 to 6));
		END COMPONENT;
 BEGIN

 M0: visor port map (A7, B7);
 END Behavior_segment;