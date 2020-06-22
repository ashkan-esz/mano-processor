Library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------
Entity SC is 
  port(clk, rst: in std_logic;
       digits: out std_logic_vector(3 downto 0));
End SC;
-------------------------------------------------
Architecture SC of SC is
Begin
  process(clk, rst)
    variable temp: Integer range 0 to 15;
  begin 
    if(rst='1') then
      temp := 0;
    elsif(clk'event and clk='1') then
	if (temp = 15) then
		temp := 0;
	else temp := temp +1;
	end if;
    end if;
--------------------------------------------------
    case temp is
      when 0 => digits <= "0000";
      when 1 => digits <= "0001";
      when 2 => digits <= "0010";
      when 3 => digits <= "0011";
      when 4 => digits <= "0100";
      when 5 => digits <= "0101";
      when 6 => digits <= "0110";
      when 7 => digits <= "0111";
      when 8 => digits <= "1000";
      when 9 => digits <= "1001";
      when 10 => digits <= "1010";
      when 11 => digits <= "1011";
      when 12 => digits <= "1100";
      when 13 => digits <= "1101";
      when 14 => digits <= "1110";
      when 15 => digits <= "1111";
    end case;
  end process;

End SC;
