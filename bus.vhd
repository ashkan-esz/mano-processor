Library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------
Entity Buss is
  port(AR_output,PC_output : in std_logic_vector(11 downto 0);
       DR_output,AC_output,IR_output,
	TR_output,memory_data_out : in std_logic_vector(15 downto 0);

       selector: in std_logic_vector(2 downto 0);
	AR_input,PC_input: out  std_logic_vector(11 downto 0);
	DR_input,IR_input,
	TR_input,memory_data_in : out std_logic_vector(15 downto 0));
       
end Buss;
-------------------------------------------
Architecture Buss of Buss is 
Signal data : std_logic_vector(15 downto 0);
Begin
  data <=   "0000" & AR_output when selector = "001" else 
            "0000" & PC_output when selector = "010" else
                     DR_output when selector = "011" else
                     AC_output when selector = "100" else
            	     IR_output when selector = "101" else
                     TR_output when selector = "110" else
                     memory_data_out when selector = "111";

	AR_input <= data(11 downto 0);
	PC_input <= data(11 downto 0);
	DR_input <= data;
	IR_input <= data;
	TR_input <= data;
	memory_data_in <= data;

end Buss;
