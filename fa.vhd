library ieee;
use ieee.std_logic_1164.all;
-------------------------------------
Entity FA is
 	port(x,y,z: in std_logic;
	Sum,Carry : out std_logic);
End FA;
-------------------------------------
Architecture FA of FA is
begin
	Sum <= x xor y xor z;
	Carry <= (x and y) or (x and z) or (y and z);
End FA;