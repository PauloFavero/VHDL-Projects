

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity conteur is
port(   clk,reset  :   in std_logic;
    Inc,Dec        :   in std_logic;
    sortie       :   out std_logic_vector(8 downto 0));
end conteur;


architecture arch_conteur of conteur is
signal reg_value : std_logic_vector(8 downto 0);
begin 
   process(clk)
 	begin
     	 if reset='1' then 
	sortie <= (others => '0');
	reg_value <= (others => '0');
	elsif rising_edge(clk)  then
		
		if Inc ='1' then 
		reg_value <= std_logic_vector( unsigned(reg_value) + 1);
		sortie <= reg_value;
		elsif Dec = '1' then 
		reg_value <=  std_logic_vector( unsigned(reg_value) - 1);
		sortie <= reg_value;
        	end if; 
	end if;
end process;
end arch_conteur;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity correcteur is
port( clk,reset  :   in std_logic;
    E       	 :   in std_logic_vector(8 downto 0);
    S       	 :   out std_logic_vector(8 downto 0));
end correcteur;

architecture arch_correcteur of correcteur is
signal E1 : std_logic_vector(8 downto 0);
signal tmp : std_logic_vector(17 downto 0);
begin
    process(clk,reset)
        begin
        if reset='1' then E1 <= (others => '0'); tmp<= (others => '0');
        elsif rising_edge(clk) then
            tmp <= std_logic_vector(18*unsigned(E) - 17*unsigned(E1)); 
            E1 <= E;
        end if;
    end process;
    S <= tmp(10 downto 2);
end arch_correcteur;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

entity filtre_boucle is
port(   clk,reset  :   in std_logic;
    Inc,Dec        :   in std_logic;
    delta_phi       :   out std_logic_vector(8 downto 0));
end filtre_boucle;

architecture arc_filtre_boucle of filtre_boucle is 
	signal sortie_compt : std_logic_vector(8 downto 0);	 	
begin

conteur1 : entity conteur port map(clk => clk,
			       reset => reset,
				Inc => Inc,
				Dec => Dec,
				sortie => sortie_compt);

 
corre : entity correcteur port map(clk => clk,
			       reset => reset,
				E => sortie_compt,
				S => delta_phi);

end arc_filtre_boucle;
