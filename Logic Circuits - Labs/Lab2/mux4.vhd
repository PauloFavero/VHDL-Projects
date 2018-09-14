LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY mux4bits IS
 PORT (aa1: IN STD_LOGIC;
 bb1, bb2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0); 
 oo1 : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END mux4bits;

ARCHITECTURE Behavior OF mux4bits IS
 BEGIN
 oo1(3) <= (NOT aa1 AND bb1(3)) OR (oo1(3) AND bb2(3));
 oo1(2) <= (NOT aa1 AND bb1(2)) OR (oo1(2) AND bb2(2));
 oo1(1) <= (NOT aa1 AND bb1(1)) OR (oo1(1)AND bb2(1));
 oo1(0) <= (NOT aa1 AND bb1(0)) OR (oo1(0) AND bb2(0)); 
 END Behavior;