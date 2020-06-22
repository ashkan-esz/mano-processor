Library ieee;
use ieee.std_logic_1164.all;
------------------------------------------
Entity Alu is
	port(	D : in std_Logic_vector(7 downto 0);
		T : in std_logic_vector(15 downto 0);
		AC_output,DR_output : in std_logic_vector(15 downto 0);
		AC_input : out std_logic_vector(15 downto 0);
		E,C_out : out std_logic);
end Alu;
-------------------------------------------
Architecture Alu of Alu is
component Fa16
	port (input1 , input2 : in std_logic_vector(15 downto 0);
		output : out std_logic_vector(15 downto 0);
		C_out : out std_logic);
end component;
-------------------------------------------
 Signal result_Fa16 : std_logic_vector(15 downto 0);
 Signal result_C_out : std_logic;
begin
	U1 : Fa16 port map(AC_output,DR_output,result_Fa16,result_C_out);

	
	AC_input <= result_Fa16 when (D(1)='1' and T(5)='1') else
		    DR_output   when (D(2)='1' and T(5)='1') else
		    (AC_output and DR_output) when(D(0)='1' and T(5)='1');

	C_out <=  result_C_out when (D(1)='1' and T(5)='1');
end Alu;