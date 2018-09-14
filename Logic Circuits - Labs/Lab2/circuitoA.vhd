LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity circuitoA is

port (AA1, AA2, AA3 : IN  STD_LOGIC;
		KK1,KK2,KK3 : OUT STD_LOGIC);
		END circuitoA;
		
		ARCHITECTURE behavior_CircuitoA of CircuitoA IS
		begin
		
		KK1<=(AA1 and AA2);
		KK2<= not AA2;
		KK3<= AA3;
		
		end behavior_CircuitoA;