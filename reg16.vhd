Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------
Entity Reg16 is
  port( load , clk, rst, inc , comp,shr,shl,E: in std_logic;
	input: in std_logic_vector(15 downto 0);
        output: out std_logic_vector(15 downto 0));
end Reg16;
----------------------------------------
Architecture Reg16 of Reg16 is
Signal temp : std_logic_vector(15 downto 0);

Begin
  output <= temp;
  process(clk, rst,load,comp,shr,shl)
  begin 

    if(rst = '1') then
     	temp <= "0000000000000000";

    elsif(inc = '1' and clk='0') then
      	temp <= std_logic_vector( unsigned(temp) + 1 );

    elsif(comp = '1') then
	gen1 : for i in 0 to 15 loop
		temp(i) <= not(temp(i));
	End loop;
	

    elsif(shr = '1') then	
	gen2 : for i in 0 to 14 loop
		temp(i) <= temp(i+1);
	End loop;
	temp(15) <= E;

    elsif(shl = '1') then	
	gen3 : for i in 0 to 14 loop
		temp(i+1) <= temp(i);
	End loop;
	temp(0) <= E;

    elsif(clk'event and clk = '1') then
	if(load = '1') then
      	  temp <= input;
	end if;

    end if;
  end process;
end Reg16;