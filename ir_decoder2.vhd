Library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------
Entity IR_Decoder2 is
	port(
	clk : in std_logic;
	IR_output : in std_logic_vector(15 downto 0);
	I : out std_logic;
	D : out std_logic_vector(7 downto 0);
	IR_11_0 :out std_logic_vector(11 downto 0) );
end IR_Decoder2;
--------------------------------------------------
Architecture IR_Decoder2 of IR_Decoder2 is
--------------------------------------------------
component Decoder2 
  port(input: in std_logic_vector(2 downto 0);
       D: out std_logic_vector(7 downto 0));
End component;
--------------------------------------------------
begin

	I <= IR_output(15);
	dec: Decoder2 port map (IR_output(14 downto 12),D);
	IR_11_0 <= IR_output(11 downto 0);

end IR_Decoder2;
