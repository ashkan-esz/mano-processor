Library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------
Entity Decoder is 
  port(input: in std_logic_vector(3 downto 0);
       T: out std_logic_vector(15 downto 0));
End Decoder;
------------------------------------------------------------
Architecture Decoder of Decoder is
  Begin
   
    T(0) <= not(input(3)) and not(input(2)) and not(input(1)) and not(input(0));
    T(1) <= not(input(3)) and not(input(2)) and not(input(1)) and input(0);
    T(2) <= not(input(3)) and not(input(2)) and input(1)      and not(input(0));
    T(3) <= not(input(3)) and not(input(2)) and input(1)      and input(0);
    T(4) <= not(input(3)) and input(2)      and not(input(1)) and not(input(0));
    T(5) <= not(input(3)) and input(2)      and not(input(1)) and input(0);
    T(6) <= not(input(3)) and input(2)      and input(1)      and not(input(0));
    T(7) <= not(input(3)) and input(2)      and input(1)      and input(0);
    T(8) <=  input(3)   and not(input(2)) and not(input(1)) and not input(0);
    T(9) <=  input(3)   and not(input(2)) and not(input(1)) and input(0);
    T(10) <= input(3)   and not(input(2)) and input(1)      and not(input(0));
    T(11) <= input(3)   and not(input(2)) and input(1)      and input(0);
    T(12) <= input(3)   and input(2)      and not(input(1)) and not(input(0));
    T(13) <= input(3)   and input(2)      and not(input(1)) and input(0);
    T(14) <= input(3)   and input(2)      and input(1)      and not(input(0));
    T(15) <= input(3)   and input(2)      and input(1)      and input(0);

  End Decoder;