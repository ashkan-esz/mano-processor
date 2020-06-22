Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------
Entity Reg12 is
  port(load,clk, rst, inc: in std_logic;
	input: in std_logic_vector(11 downto 0);
        output: out std_logic_vector(11 downto 0));
end Reg12;
----------------------------------------
Architecture Reg12 of Reg12 is
Signal temp : std_logic_vector(11 downto 0);
	
Begin
  output <= temp;
  process(clk, rst,load)
  begin 
    if(rst = '1') then
        temp <= "000000000000";
    elsif(inc = '1' and clk='0') then
 	temp <= std_logic_vector( unsigned(temp) + 1 );
    elsif(clk'event and clk = '1') then
	if(load = '1') then
          temp <= input;
	end if;
    end if;
  end process;
end Reg12;