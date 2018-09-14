--TP1 mu0 - entité mémoire - a faire evoluer suivant les fonctionnalités du processeur à tester

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram0 is
	port(clk		: in std_logic;
		 MEMrq		: in std_logic;
		 RnW		: in std_logic;
		 addr_bus	: in std_logic_vector(11 downto 0);
		 data_bus	: inout std_logic_vector(15 downto 0));
end ram0;

-------------------------------------------------------------------------- 
-- Instruction  | Code Operation  | Action Realisée
-------------------------------------------------------------------------- 
-- LDA addr     |   0000          | ACC <- mem[addr] 
-- STO addr     |   0001          | mem[addr] <- ACC  
-- ADD addr     |   0010          | ACC <- ACC + mem[addr]
-- SUB addr     |   0011          | ACC <- ACC - mem[addr]
-- JMP addr     |   0100          | PC  <- addr 
-- JGE addr     |   0101          | si ACC >= 0 --> PC <- addr
-- JNE addr     |   0110          | si ACC # 0  --> PC <- addr
-- STP          |   0111          | arrêter le processeur
-- AND addr     |   1000          | ACC <- ACC and mem[addr]
-- OR  addr     |   1001          | ACC <- ACC or mem[addr]
-- XOR addr     |   1010          | ACC <- ACC xor mem[addr]
-- LDR addr     |   1011          | reg_R <- mem[addr]
-- LDI addr     |   1100          | ACC <- mem[reg_R] ; reg_R <- reg_R + 1 
-- STI addr     |   1101          | mem[reg_R] <- ACC ; reg_R <- reg_R + 1
-- JSR addr     |   1110          | SPC <- PC ; PC <- mem[addr] 
-- RET          |   1111          | PC <- SPC


architecture syn of ram0 is

	type memory_type is array (integer range 0 to 15) of std_logic_vector(15 downto 0);

signal memory : memory_type := 
(                     -- ADRESSE -- DONNEE
  "0000000000001101", --    0    -- LDA 0xD
  "0010000000001101", --    1    -- ADD 0xD
  "0001000000001111", --    2    -- STO 0xF
  "0000000000001111", --    3    -- LDA 0xF
  "0011000000001110", --    4    -- SUB 0xE
  "1011000000001110", --    5    -- LDR 0xE
  "1100000000000000", --    6    -- LDI 
  "1100000000000000", --    7    -- LDI
  "0000000000000000",  --   8    -- 
  "0111000000000000", --    9    -- STP
  "0000000000000001",  --   10   -- 1 (tab)
  "0000000000000010",  --   11   -- 2
  "0000000000000011",  --   12   -- 3
  "0000000000000111", --    13    -- donnée=7
  "0000000000001010", --    14    -- adresse de tab
  "0000000000000000"   --   15   -- resultat
);


begin

	data_bus <= memory(to_integer(unsigned(addr_bus)))  when (MEMrq = '1' and RnW = '1') else (others => 'Z');

	process (clk)
	begin
		if rising_edge(clk) then 
		      if (MEMrq = '1') and (RnW = '0') then
			     memory(to_integer(unsigned(addr_bus))) <= data_bus;
		      end if;
		end if;      
	end process;
end syn;
