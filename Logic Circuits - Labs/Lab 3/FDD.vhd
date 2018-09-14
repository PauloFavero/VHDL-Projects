library ieee;
USE ieee.std_logic_1164.all;

ENTITY ffD IS
 PORT ( D : IN std_logic_vector(3 DOWNTO 0);
 clk, rst : IN std_logic;
 Q : OUT std_logic_vector(3 DOWNTO 0));
END ffD;
ARCHITECTURE ffD_comp OF ffD IS
BEGIN
 PROCESS (clk, rst)
 VARIABLE Qvar : std_logic_vector(3 DOWNTO 0);
 BEGIN
 IF rst = '1' THEN
 Qvar := "0000";
 ELSIF ( clk'event and clk = '1' ) THEN
 Qvar := D;
 END IF ;
 Q <= Qvar;
 END PROCESS ;
END ffD_comp ;
