Library ieee;
use ieee.std_logic_1164.all;
-----------------------------------------
Entity Fa16 is
	port (input1 , input2 : in std_logic_vector(15 downto 0);
		output : out std_logic_vector(15 downto 0);
		C_out : out std_logic);
end Fa16;
----------------------------------------
Architecture Fa16 of Fa16 is
----------------------------------------
component FA 
 	port(x,y,z: in std_logic;
	Sum,Carry : out std_logic);
End component;
----------------------------------------
Signal c : std_logic_vector(16 downto 0);
begin
	c(0) <= '0';
	gen1 : for i in 0 to 15 generate
		u1 : FA port map(input1(i),input2(i),c(i),output(i),c(i+1));
	end generate;
	C_out <= c(16);
end Fa16;
