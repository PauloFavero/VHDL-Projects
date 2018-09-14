



--*********************************************************************************
--		PILE GENERIQUE (un param�tre permet de d�terminer la taille de la pile)
--*********************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--/////////////////////
--    A COMPLETER
--/////////////////////

-- accessing the whole array:
--MEM8X4 := ("0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111");
-- accessing a "word"
--MEM8X4(5) := "0110";
-- accessing a single bit
--MEM8X4(6) (0) := '0';



entity pile is

generic( N : integer := 44); -- 8 valeur par d�faut pour le tes
port(
	clk,rotate	: in std_logic;
	ld,raz		: in std_logic;
	top	  	: in std_logic_vector (7 downto 0);
	ref_rec  	: out std_logic_vector (7 downto 0));

end pile;


architecture arch_pile of pile is

type pile_data is array(N-1 downto 0) of std_logic_vector(7 downto 0);

-- an array "array of array" type
signal MEMNX8 : pile_data;

 begin
	process(clk,raz)
variable MEMNX8_copy : pile_data;
        begin
        if raz='1' then 
		for I in (N-1) downto 0   loop
			MEMNX8(I) <= "00000000";
		end loop;
        elsif rising_edge(clk) then
		if rotate='1' then
			for J in 0 to (N-1)  loop
				if J = N-1 then
					MEMNX8_copy(N-1):= MEMNX8(0);
				else 
					MEMNX8_copy(N-2-J) := MEMNX8(N-1-J);
				end if;	
  			end loop;
			MEMNX8 <= MEMNX8_copy;
		elsif ld = '1' then
			for K in 0 to (N-1)  loop
				if K = N-1 then
					MEMNX8_copy(N-1):= top;
				else 
					MEMNX8_copy(N-2-K) := MEMNX8(N-1-K);
				end if;	
  			end loop;
			MEMNX8 <= MEMNX8_copy;
		end if;
	end if;
ref_rec <= MEMNX8(N-1);
end process;
end arch_pile;

--*********************************************************************************
--		MULTIPLIEUR GENERIQUE
--*********************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


--/////////////////////
--    A COMPLETER
--///////////////////// 

entity multiplieur is
generic( N : integer := 8); -- 8 valeur par d�faut pour le test
port(
	E1, E2:	in std_logic_vector (N-1 downto 0);
	S:	out std_logic_vector ((2*N)-1 downto 0));
end multiplieur;

architecture arch_multiplieur of multiplieur is

 begin
	S <= std_logic_vector(signed(E1) * signed(E2));

end arch_multiplieur;

--*********************************************************************************
--		ADDITIONNEUR GENERIQUE
--*********************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--/////////////////////
--    A COMPLETER
--/////////////////////

entity additionneur is
generic( N : integer := 20); -- 20 valeur par d�faut pour le test
port(
	E_1, E_2:	in std_logic_vector (N-1 downto 0);
	S:		out std_logic_vector (N-1 downto 0));
end additionneur;

architecture arch_additionneur of additionneur is

begin
	S <= std_logic_vector(signed(E_1) + signed(E_2));
end arch_additionneur;

--*********************************************************************************
--		REGISTRE GENERIQUE : taille de l'entr�e et taille de la sortie param�trables
--*********************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--/////////////////////
--    A COMPLETER
--/////////////////////

entity registre is
generic(N_E : integer:=16;
	N_S : integer:=21);

port(   clk, ld, Registre_raz  :   in std_logic;
    din        :   in std_logic_vector((N_E-1) downto 0);
    dout       :   out std_logic_vector((N_S-1) downto 0));
end registre;
 
architecture arch_registre of registre is
begin
    process(clk)
        begin
        if Registre_raz = '1' then dout <= (others => '0');
        elsif rising_edge(clk) then
            if ld = '1' then
		 dout(N_E-1 downto 0) <= din;
		dout(N_S-1 downto N_E) <= (others => din(N_E -1));
            end if;
        end if;
    end process;
end arch_registre;


--*********************************************************************************
--		SEQUENCEUR du CORRELATEUR
--*********************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Seq_correlateur is
port(   clk,reset,ref,clke     	  :   	in  std_logic;
	raz_pile_rec,raz_pile_ref :   	out  std_logic;
	ld_pile_rec,ld_pile_ref   :  	out  std_logic;
	calc  			  :  	out  std_logic;
	raz_reg_pdt,raz_reg_sum   :  	out  std_logic;
	ld_reg_pdt,ld_reg_sum 	  :   	out  std_logic;
	raz_cnt,en_cnt:			out std_logic;
    	cnt           :   in std_logic_vector(7 downto 0);
	ld_reg_out,raz_reg_out:  	out  std_logic);
end Seq_correlateur;

architecture arch_Seq_correlateur of Seq_correlateur is
	type me_states is (S_maz, S_ref, S_att1, S_att2, S_rec, S_pasici, S_fin, S_sum, S_att3, S_att4);
 		 signal  etat_cr, etat_sv : me_states ;
begin
process(clk, reset)
    begin  
    if reset = '1' then etat_cr <= S_maz;
     elsif rising_edge(clk) then etat_cr <= etat_sv;
    end if;

end process;

process(etat_cr,clke,ref,cnt)
    begin  
     	raz_pile_rec <= '0'; raz_pile_ref <= '0';
	ld_pile_rec <= '0'; ld_pile_ref <= '0';
	calc <= '0';
	raz_reg_pdt <= '0'; raz_reg_sum <= '0'; raz_reg_out <= '0';
	ld_reg_pdt <= '0'; ld_reg_sum <= '0'; ld_reg_out <= '0';
	raz_cnt <= '0'; en_cnt <= '0';
	etat_sv <= etat_cr;

	case etat_cr is
		when S_maz =>
			raz_pile_rec <= '1'; raz_pile_ref <= '1';
			raz_reg_pdt <= '1'; raz_reg_sum <= '1'; raz_reg_out <= '1';
			raz_cnt <= '1';
			if ref <= '1' AND clke <= '1' then etat_sv <= S_ref; end if;
		when S_ref =>
 			etat_sv <= S_att1;
			ld_pile_ref <= '1';
		when S_att1 =>
			if clke = '0' then etat_sv <= S_att2;
			end if;
		when S_att2 =>
			if ref = '1' AND clke = '1' then etat_sv <= S_ref;
			elsif ref = '0' AND clke = '1' then etat_sv <= S_rec; end if;
		when S_rec =>
			ld_pile_rec <= '1';
			raz_cnt <= '1'; raz_reg_sum <= '1'; raz_reg_pdt <= '1'; raz_reg_out <= '1';
			etat_sv <= S_pasici;
		when S_pasici =>
			En_cnt <= '1';
			ld_reg_pdt <= '1'; ld_reg_sum <= '1'; ld_reg_out <= '1';
			calc <= '1';
			if cnt = "00010100" then etat_sv <= S_fin; end if;
		when S_fin =>
			ld_reg_pdt <= '1'; ld_reg_out <= '1';
			calc <= '1';
			etat_sv <= S_sum;
		when S_sum =>
			ld_reg_sum <= '1'; ld_reg_out <= '1';
			if clke = '1' then etat_sv <= S_att3;
			elsif clke = '0' then etat_sv <= S_att4; end if;
		when S_att3 =>
			if clke = '0' then etat_sv <= S_att4; end if;
		when S_att4 =>
			if ref = '1' AND clke = '1' then etat_sv <= S_ref;
			elsif ref = '0' AND clke = '1' then etat_sv <= S_rec; end if;
	end case;
end process;

end arch_Seq_correlateur;
--*********************************************************************************
--		COMPTEUR DU SEQUENCEUR
--**********************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

--/////////////////////
--    A COMPLETER
--/////////////////////

entity compteur is
port(   clk,raz,en      :   in  std_logic;
    	cnt             :   out std_logic_vector(7 downto 0));
end compteur;
 
architecture arch_compteur of compteur is
signal count_int : unsigned (7 downto 0);
begin
process(clk)
    begin  
    if rising_edge(clk) then
        if raz='1' then count_int <= (others => '0');
        elsif en='1' then          
            if count_int="11111111" then count_int <= (others => '0'); -- fin de comptage
            else count_int <= count_int + 1; -- "+"(unsigned,int)
            end if;
        end if;
    end if;
end process;
 
cnt <= std_logic_vector(count_int); -- count copie de count_int
 
end arch_compteur;


--*********************************************************************************
--*********************************************************************************
--	                              CORRELATEUR
--*********************************************************************************
--*********************************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.stimul_pack.all;
use work.all;

--/////////////////////
--    A COMPLETER
--/////////////////////
   

entity Correlateur_parallele is
port(   clk,reset,ref,clke 	 :   in  std_logic;
    	d_in           	 :   in std_logic_vector(7 downto 0);
	correl           :   out std_logic_vector(20 downto 0));
end Correlateur_parallele;
      

architecture arch_Correlateur of Correlateur_parallele is
signal calc,ld_pile_rec,ld_pile_ref : std_logic;
signal raz_pile_rec,raz_pile_ref : std_logic;
signal raz_reg_pdt,raz_reg_sum,raz_reg_out   : std_logic;
signal ld_reg_pdt,ld_reg_sum,ld_reg_out  :  std_logic;
signal raz_cnt,en_cnt 	 :  std_logic;
signal rec_1,rec_2,cnt,ref_ref_1,ref_ref_2 : std_logic_vector (7 downto 0);
signal mult_1,mult_2 : std_logic_vector (15 downto 0);
signal add_11,add_12,add_21,add_22, acc, S1,S2 ,sortie_corr : std_logic_vector (20 downto 0);
begin 
Pile_ref_1 : entity pile	generic map (N => 22) 
					  port map(clk => clk,
					  rotate => calc,
					  ld => ld_pile_ref,
 					  raz => raz_pile_ref,
				  	  top => d_in,
					  ref_rec => ref_ref_1);
Pile_ref_2 : entity pile	generic map (N => 22) 
					  port map(clk => clk,
					  rotate => calc,
					  ld => ld_pile_ref,
 					  raz => raz_pile_ref,
				  	  top => ref_ref_1,
					  ref_rec => ref_ref_2);

Pile_rec_1 : entity pile	generic map (N => 44)
					  port map(clk => clk,
					  rotate => calc,
					  ld => ld_pile_rec,
 					  raz => raz_pile_rec,
				  	  top => d_in,
					  ref_rec => rec_1);
Pile_rec_2 : entity pile	generic map (N => 44)
					  port map(clk => clk,
					  rotate => calc,
					  ld => ld_pile_rec,
 					  raz => raz_pile_rec,
				  	  top => rec_1,
					  ref_rec => rec_2);
		
multip_1 : entity multiplieur generic map (N => 8)
					  port map(E1 => ref_ref_1,
					  E2 => rec_1,
					  S => 	mult_1);	
multip_2 : entity multiplieur generic map (N => 8)
					  port map(E1 => ref_ref_2,
					  E2 => rec_2,
					  S => 	mult_2);	

reg_pdt_1 : entity registre generic map (N_E => 16,N_S => 21 )
					  port map ( clk => clk,
					  ld => ld_reg_pdt,
					  Registre_raz => raz_reg_pdt,
					  din => mult_1,
					dout => add_11);
reg_pdt_2 : entity registre generic map (N_E => 16,N_S => 21 )
					  port map ( clk => clk,
					  ld => ld_reg_pdt,
					  Registre_raz => raz_reg_pdt,
					  din => mult_2,
					dout => add_12);
somateur_1 : entity additionneur generic map (N => 21)
					  port map(
					  E_1 => add_11,
					  E_2 => add_21,
					  S => S1);

somateur_2 : entity additionneur generic map (N => 21)
					  port map(
					  E_1 => add_12,
					  E_2 => add_22,
					  S => S2);



somateur_3 : entity additionneur generic map (N => 21)
					  port map(
					  E_1 => add_12,
					  E_2 => add_22,
					  S => acc);

reg_sum_1 : entity registre generic map (N_E => 21,N_S => 21 )
					  port map ( clk => clk,
					  ld => ld_reg_sum,
					  Registre_raz => raz_reg_sum,
					  din => S1,
					dout => add_21);
reg_sum_2 : entity registre generic map (N_E => 21,N_S => 21 )
					  port map ( clk => clk,
					  ld => ld_reg_sum,
					  Registre_raz => raz_reg_sum,
					  din => S2,
					dout => add_22);
reg_out : entity registre generic map (N_E => 21,N_S => 21 )
					  port map ( clk => clk,
					  ld => ld_reg_sum,
					  Registre_raz => raz_reg_sum,
					  din => acc,
					dout => correl);

sequenceur : entity Seq_correlateur port map(
					  clk => clk,
					  reset => reset,
					  ref => ref,
					  clke => clke,
					  raz_pile_rec => raz_pile_rec,
					  raz_pile_ref => raz_pile_ref,
					  ld_pile_rec => ld_pile_rec,
					  ld_pile_ref => ld_pile_ref,
					  calc => calc,
					  raz_reg_pdt => raz_reg_pdt,
				  	  raz_reg_sum => raz_reg_sum,
					  ld_reg_pdt => ld_reg_pdt,
					  ld_reg_sum => ld_reg_sum,
				  	  raz_cnt => raz_cnt,
					  en_cnt => en_cnt,
   					  cnt => cnt,
					  ld_reg_out=> ld_reg_out,
					  raz_reg_out => raz_reg_out);

compteur_1 : entity compteur port map(clk => clk,
					  raz => raz_cnt,
					  en => en_cnt,
					  cnt => cnt);


end arch_Correlateur;