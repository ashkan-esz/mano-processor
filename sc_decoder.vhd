Library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------
Entity SC_Decoder is
	port(clk , SC_rst : in std_logic;
		T : out std_logic_vector(15 downto 0));
end SC_Decoder;
-------------------------------------------------
Architecture SC_Decoder of SC_Decoder is
-------------------------------------------------
component SC 
  port(clk, rst: in std_logic;
       digits: out std_logic_vector(3 downto 0));
End component;
--------------------------------------------------
component Decoder 
  port(input: in std_logic_vector(3 downto 0);
       T: out std_logic_vector(15 downto 0));
End component;
--------------------------------------------------

 Signal number : std_logic_vector(3 downto 0);

begin
 	u2: SC port map(clk,SC_rst,number);
	u3: Decoder port map(number,T);
end SC_Decoder;
