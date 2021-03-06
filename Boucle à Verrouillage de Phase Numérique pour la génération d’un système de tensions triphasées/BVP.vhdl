
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

entity BVP_Numerique is generic(taille_bit : integer:=9);
	         port(
           reset, clk : in std_logic;
           Top_0: in std_logic;
           -- Phase : inout std_logic_vector(taille_bit-1 downto 0)
);
end BVP_Numerique;

architecture arch_BVP_Numerique of BVP_Numerique is
  signal Top_Synchro : std_logic;
  signal AV : std_logic;
  signal AR : std_logic;
  signal Delta_phi : std_logic_vector(taille_bit-1 downto 0);
  signal sin1 : std_logic_vector(7 downto 0);
  signal sin2 : std_logic_vector(7 downto 0);
  signal sin3 : std_logic_vector(7 downto 0);
  signal Phase : std_logic_vector(taille_bit-1 downto 0);
  begin

Comparateur_de_Phase_map : entity comparateur_de_phases port map(clk => clk,
					  			reset => reset,
								Top_0 => Top_0,
								Top_synchro => Top_synchro,
								AV => AV,
								AR => AR);


filtre: entity filtre_boucle	 port map(clk => clk,
					 reset => reset,
					INC => AV,
					DEC => AR,
					delta_phi =>Delta_phi);



ocn_map: entity OCN		port map(clk => clk,
					  reset => reset,
					delta_phi => delta_phi,
					phase=> phase,
					top_syncro => Top_synchro);

ROM1_map: entity ROM1		port map(adresse => phase,
					  donnee => sin1);

ROM2_map: entity ROM2		port map(adresse => phase,
					  donnee => sin2);

ROM3_map: entity ROM3		port map(adresse => phase,
					  donnee => sin3);

end arch_BVP_Numerique;