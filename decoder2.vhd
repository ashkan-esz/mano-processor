Library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------
Entity Decoder2 is 
  port(input: in std_logic_vector(2 downto 0);
       D: out std_logic_vector(7 downto 0));
End Decoder2;
------------------------------------------------------------
Architecture Decoder2 of Decoder2 is
  Begin
    D(0) <= not input(2) and not input(1) and not input(0);    
    D(1) <= not input(2) and not input(1) and input(0);
    D(2) <= not input(2) and input(1)     and not input(0);
    D(3) <= not input(2) and input(1)     and input(0);
    D(4) <= input(2)     and not input(1) and not input(0);
    D(5) <= input(2)     and not input(1) and input(0);
    D(6) <= input(2)     and input(1)     and not input(0);
    D(7) <= input(2)     and input(1)     and input(0);

end Decoder2;