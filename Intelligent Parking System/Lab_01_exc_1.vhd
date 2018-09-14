library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
--************BEGIN COMPTEUR***************
entity compteur is
port(clk,reset,up,down   :   in  std_logic;
    count           :   out std_logic_vector(3 downto 0));
end compteur;

architecture arch_compteur of compteur is
signal count_int : unsigned (3 downto 0);
begin
    process(clk,reset)
        begin
        if reset='1' then count_int <= (others => '0');
        elsif rising_edge(clk) then     
            if up='1' then          
                if count_int="1111" then count_int <= (others => '0'); -- fin de comptage
                else count_int <= count_int + 1; -- "+"(unsigned,int)
                end if;
         
	elsif down='1' then          
                	if count_int="0000" then count_int <= (others => '0'); -- fin de comptage
                	else count_int <= count_int - 1; -- "-"(unsigned,int)
                	end if;
            	end if;
        end if;
    end process;
 
    count <= std_logic_vector(count_int); -- count copie de count_int
 
end arch_compteur;
--************END COMPTEUR***************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
--************BEGIN REGISTER***************
entity registre is
port(   clk,reset,load  :   in std_logic;
    d_in        :   in std_logic_vector(3 downto 0);
    d_out       :   out std_logic_vector(3 downto 0));
end registre;

architecture arch_registre of registre is
begin
    process(clk,reset)
        begin
        if reset='1' then d_out <= (others => '0');
        elsif rising_edge(clk) then
            if load='1' then d_out <= d_in;
            end if;
        end if;
    end process;
end arch_registre;
--************END REGISTRER***************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
--************BEGIN Comparateur***************
entity comparateur is
  port(
    a,b : in std_logic_vector(3 downto 0);
    sup_egal : out std_logic);
end comparateur;


architecture arch_comparateur of comparateur is
begin

	sup_egal <= '1' when a=b else '0'; 
    
end arch_comparateur;
 --************END Comparateur***************


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
--************BEGIlibrary IEEE;


entity soustracteur is
port( A,B		:	in std_logic_vector(3 downto 0);
	result 	: 	out std_logic_vector(3 downto 0));
end soustracteur;

architecture arch_soustracteur of soustracteur is
begin
	result <= std_logic_vector(signed(B)-signed(A));
				
end arch_soustracteur;

 --************END SOUSTRACTEUR***************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
--************BEGIN detect_front_M***************
entity detect_front_M is
port( clk, reset, E  :   in std_logic;
	ft_mt : 	out std_logic);
end detect_front_M;

architecture arch_detect_front_M of detect_front_M is
type etat_me is (E_0 , E_1, E_2);
signal etat_cr, etat_sv : etat_me;

begin
      process(clk,reset)
	begin
		if reset = '1' then etat_cr <= E_0;
			elsif rising_edge(clk) then etat_cr <= etat_sv;
			end if;
	
	end process;

process(E,etat_cr)        -- process combinatoire
            begin
            	
              ft_mt <= '0'; etat_sv <= etat_cr; -- sorties par defaut
              case etat_cr is
                      when E_0 => 
                                   if E='1' then etat_sv <= E_1; end if;  
					ft_mt <='0'; 
                      when E_1 => etat_sv <= E_2; 
				ft_mt <= '1';
                      when E_2 => 
					ft_mt <= '0';
				if  E='0' then etat_sv <= E_0; end if;

              end case;        
            end process;
end arch_detect_front_M;

 --************END detect_front_M***************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
use work.all;

entity gestion_parking is
port (reset,ld_reg,capt_entree,capt_sortie,clk : in std_logic;
	nb_max: in std_logic_vector(3 downto 0);
	complet : out std_logic;
	nb_places_dispos : out std_logic_vector(3 downto 0));
end gestion_parking;

architecture arch_gestion_parking of gestion_parking is

signal comptage,val_max :  std_logic_vector(3 downto 0);
signal down,up : std_logic;

begin 

detect_1 : entity detect_front_M port map(clk => clk,
					  reset => reset,
					  E => 	capt_entree,
					  ft_mt => up);		
detect_2 : entity detect_front_M port map(clk => clk,
					  reset => reset,
					  E => 	capt_sortie,
					  ft_mt => down);	
compteur_map : entity compteur port map(	clk => clk,
					  reset => reset,
					  up => up,
					  down => down,
					count => comptage);
comparateur_map : entity comparateur port map(
					  A => comptage,
					  B => val_max,
					sup_egal => complet);
soustracteur_map : entity soustracteur port map(
					  A => comptage,
					  B => val_max,
					result => nb_places_dispos);
registre_map : entity registre port map(clk => clk,
					  reset => reset,
					  load => ld_reg,
					d_in => nb_max,
					  d_out => val_max);

end arch_gestion_parking;