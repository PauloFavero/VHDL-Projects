
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;  

entity detect_front is
port( clk, reset, E  :   in std_logic;
	Ft_mt : 	out std_logic);
end detect_front;

architecture arch_detect_front of detect_front is
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
end arch_detect_front;

---------- // ---------- // ---------- // ME_Comp_Phase // ---------- // ---------- // ---------- // ----------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 

entity ME_Comp_Phase is
port( clk, reset, E, S :   in std_logic;
	AV, AR : 	out std_logic);
end ME_Comp_Phase;

architecture arch_ME_Comp_Phase of ME_Comp_Phase is
type etat_me is (EN_PHASE , AVANCE, RETARD);
signal etat_cr, etat_sv : etat_me;

begin
      process(clk,reset)
	begin
		if reset = '1' then etat_cr <= EN_PHASE;
			elsif rising_edge(clk) then etat_cr <= etat_sv;
			end if;
	
	end process;

process(E,etat_cr,S)
            begin
            	
              AV <='0'; AR <='0'; etat_sv <= etat_cr;
              case etat_cr is
                      when EN_PHASE => if S = '1' and E = '0' then etat_sv <= RETARD;
					elsif   S = '0' and E = '1' then etat_sv <= AVANCE;
					elsif	(S = '0' and E = '0') or (S = '1' and E = '1') then etat_sv <= EN_PHASE;
					end if;
					AV <='0'; AR <='0';
                      when AVANCE => if S = '1' then etat_sv <= EN_PHASE;
					elsif	S = '0' then etat_sv <= AVANCE;
					end if;
					AV <='1'; AR <='0';
                      when RETARD => if E = '0' then etat_sv <= EN_PHASE;
					elsif	E = '0' then etat_sv <= RETARD;
					end if;
					AV <='0'; AR <='1';
              end case;
            end process;
end arch_ME_Comp_Phase;

---------- // ---------- // ---------- // comparateur_de_phases // ---------- // ---------- // ---------- // ----------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity comparateur_de_phases is
  port (clk : in std_logic;
  	reset : in std_logic;
  	Top_0 : in std_logic;
  	Top_synchro : in std_logic;
	AV	: out std_logic;
	AR	: out std_logic
);
end comparateur_de_phases;

architecture arch_comparateur_de_phases of comparateur_de_phases is
	signal Ft_Top_0    : std_logic;
	signal Ft_Top_synchro      : std_logic;
	begin

detect_Top_0	:	entity detect_front port map(clk => clk,
					  		reset => reset,
					 		E => 	Top_0,
					 		Ft_mt => Ft_Top_0);

detect_Top_synchro	:	entity detect_front port map(clk => clk,
					  			reset => reset,
					 			E => 	Top_synchro,
					 			Ft_mt => Ft_Top_synchro);
Comp_Phase	:	entity ME_Comp_Phase port map(clk => clk,
					  		reset => reset,
							E => Ft_Top_0,
							S => Ft_Top_synchro,
							AV => AV,
							AR => AR);

 
end arch_comparateur_de_phases;