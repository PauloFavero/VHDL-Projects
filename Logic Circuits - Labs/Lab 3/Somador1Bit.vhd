library ieee;
use ieee.std_logic_1164.all;
entity somador1bit is
port(x, y, cin: in std_logic;
s,cout: out std_logic);
end somador1bit;
architecture somador1bit_comportamento of somador1bit is 
begin
cout<=((x XOR y) AND cin) OR (x AND y);
s<= (x XOR y) XOR cin;
end somador1bit_comportamento;
