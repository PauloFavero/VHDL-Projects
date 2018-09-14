-- TP1 mu0 - assemblage entit�s mu0 et m�moire - entit� de plus haut rang � simuler pour faire fonctionner l'ensemble

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;


entity mu0_mem is
  port (clk : in std_logic;
  reset : in std_logic;
  data_bus : inout std_logic_vector(15 downto 0);
  addr_bus : inout std_logic_vector(11 downto 0)
);
   
  end mu0_mem;

architecture arch_mu0_mem of mu0_mem is
signal MEMRQ	: std_logic;						-- memory request
signal RNW	: std_logic;						 -- read/write op
begin

--***************************************
--            A COMPLETER              --
--***************************************


--RAM: entity  ram0	 PORT MAP(clk,MEMRQ,RNW,addr_bus,data_bus);
--microU: entity mu0	 PORT MAP(reset,clk,data_bus,addr_bus,MEMRQ,RNW);
RAM: entity ram0 port map(
                          clk => clk,
                          MEMrq => MEMrq,
                          RnW => RnW,
                          addr_bus => addr_bus,
                          data_bus => data_bus);

microU: entity mu0 port map(
                          reset => reset,
                          clk => clk,
                          data_bus => data_bus,
                          addr_bus => addr_bus,
                          mem_rq => MEMrq,
                          rnw => RnW);

end arch_mu0_mem;