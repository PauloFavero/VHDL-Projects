 LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  
  ENTITY Exp3a IS
  PORT (clk : in std_logic;
    cleber : in std_logic;
  yout: inout std_logic_vector (3 DOWNTO 0)); 
  END Exp3a;
  
  ARCHITECTURE Exp3a_comportamento OF Exp3a IS
  
  COMPONENT FFD
    PORT ( d : IN std_logic_vector (3 DOWNTO 0);
      clk, rst : IN std_logic ;
      q : OUT std_logic_vector (3 DOWNTO 0));
  END COMPONENT;
    
  COMPONENT Somador4Bits
    PORT (x, y : IN std_logic_vector(3 DOWNTO 0);
      cin: in std_logic;
      s: out std_logic_vector (3 DOWNTO 0);
      cout: out std_logic); 
  END COMPONENT;
      
    SIGNAL q1   :  std_logic_vector (3 DOWNTO 0);
    SIGNAL q2   :  std_logic_vector (3 DOWNTO 0);
    SIGNAL co   :  std_logic;
    SIGNAL din  :  std_logic_vector (3 DOWNTO 0);
    SIGNAL saida:  std_logic_vector (3 DOWNTO 0);
    SIGNAL rst  :  std_logic;
  BEGIN
    
    Din <= "0001";
    
    s0: FFD PORT MAP (din, clk, rst, q1);
    s1: FFD PORT MAP (saida, clk, rst, q2);
    s2: Somador4Bits PORT MAP (q1, q2, '0', saida , co);
    s3: FFD PORT MAP (saida, clk, '0', Yout);
      
    rst <= (yout(0) AND yout(3)) OR cleber;
    
  
  END Exp3a_comportamento;
