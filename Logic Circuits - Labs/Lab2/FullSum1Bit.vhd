LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FullSum1Bit IS PORT (x, y, cin: in std_logic;
sum, cout: out std_logic);
END FullSum1Bit;

ARCHITECTURE Sum OF FullSum1Bit IS
BEGIN
sum <= cin XOR (x XOR y);
cout <= (x AND y) OR (cin AND (x XOR y));
END Sum;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY Exp_2b IS
PORT (x, y: in std_logic_vector(3 downto 0);
s: in std_logic;
result: out std_logic_vector(3 downto 0);
cy: out std_logic);
END Exp_2b;

ARCHITECTURE FourBitSum OF Exp_2b IS

COMPONENT FullSum1Bit IS
PORT (x, y, cin: in std_logic;
sum, cout: out std_logic);
END COMPONENT;

SIGNAL c0, c1, c2: std_logic;
SIGNAL z: std_logic_vector(3 downto 0);

BEGIN

z(0) <= y(0) XOR s;
z(1) <= y(1) XOR s;
z(2) <= y(2) XOR s;
z(3) <= y(3) XOR s;


s0: FullSum1Bit PORT MAP (x(0), z(0), s, result(0), c0);
s1: FullSum1Bit PORT MAP (x(1), z(1), c0, result(1), c1);
s2: FullSum1Bit PORT MAP (x(2), z(2), c1, result(2), c2);
s3: FullSum1Bit PORT MAP (x(3), z(3), c2, result(3), cy);
END FourBitSum;





























