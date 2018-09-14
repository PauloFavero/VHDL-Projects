

library IEEE;
use IEEE.std_logic_1164.all;

entity registre is
port(   clk,reset  :   in std_logic;
    E        :   in std_logic_vector(8 downto 0);
    S       :   out std_logic_vector(8 downto 0));
end registre;
 
architecture arch_registre of registre is
begin
    process(clk)
        begin
        if rising_edge(clk) then
            if reset='1' then S <= (others => '0');
            else  S <= E;
            end if;
        end if;
    end process;
end arch_registre;


library IEEE;
USE IEEE.std_logic_1164.all;
USE ieee.std_logic_signed.all ;

entity add_9bit is
    Port ( a : in  STD_LOGIC_VECTOR(8 downto 0);
           b : in  STD_LOGIC_VECTOR(8 downto 0);
           result : out  STD_LOGIC_VECTOR(8 downto 0);
	   overflow : out STD_LOGIC); 
end add_9bit;

architecture arch_add_9bit of add_9bit is

SIGNAL Sum : STD_LOGIC_VECTOR(9 DOWNTO 0) ;
	BEGIN
	Sum <= ('0' & A) + B;
	result <= Sum(8 DOWNTO 0) ;
	overflow <= Sum(9);-- XOR A(8) XOR B(8) XOR Sum(8);
end arch_add_9bit;


library IEEE;
USE IEEE.std_logic_1164.all;
use work.all;

entity OCN is 
	port(clk,reset  :   in std_logic;
	   delta_phi : in  STD_LOGIC_VECTOR(8 downto 0);
           phase : out  STD_LOGIC_VECTOR(8 downto 0);
	   top_syncro : out STD_LOGIC); 

end OCN;

architecture arch_OCN of OCN is                    
	signal out_reg	: std_logic_vector(8 downto 0);	 	   
	signal out_add	: std_logic_vector(8 downto 0);		   	
	
begin

phase <= out_reg;

ADD : entity add_9bit port map(a => out_reg,
			       b => delta_phi,
				result => out_add,
				overflow => top_syncro);

Reg : entity registre port map(clk => clk,
			       reset => reset,
				E => out_add,
				S => out_reg);

end arch_OCN;