
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

--/////////////////////
--    A COMPLETER
--/////////////////////

entity banc_test_corr is
port(   clk,clke,reset :   in std_logic;
    correl       :   out std_logic_vector(20 downto 0));
end banc_test_corr;

architecture arch_banc_test_corr of banc_test_corr is
signal ref : std_logic;
signal data_bus : std_logic_vector (7 downto 0);
begin 

Corre : entity Correlateur_parallele		  port map(clk => clk,
					  reset => reset,
					  ref => ref,
 					  clke => clke,
					  d_in => data_bus,
				  	  correl => correl);

Stimule : entity stimulateur		  port map(reset => reset,
					  clke => clke,
					  d_out => data_bus,
 					  ref => ref);
					  
end arch_banc_test_corr;