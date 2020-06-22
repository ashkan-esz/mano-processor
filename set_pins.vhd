Library ieee;
use ieee.std_logic_1164.all;
-------------------------------------
Entity Set_pins is
	port( clk,  I : in std_logic;
		D : in std_logic_vector(7 downto 0);
		T : in std_logic_vector(15 downto 0);
		E : in std_logic;
		DR_output : in std_logic_vector(15 downto 0);
		AC_output : in std_logic_vector(15 downto 0);
		IR_11_0 : in std_logic_vector(11 downto 0);
		PC_load,PC_inc,
		AR_load,AR_rst,AR_inc,
		DR_load,DR_rst,DR_inc,
		IR_load,
		AC_load,AC_rst,AC_inc,AC_comp,AC_shr,AC_shl,
		SC_rst,
		memory_read,memory_write: out std_logic);
end Set_pins;
-------------------------------------
Architecture Set_pins of Set_pins is
Signal PC_loaded : std_logic := '0';
begin
	---------------------------------------------------
	---------------------------------------------------
	PC_load <= '1' when (D(4)='1' and T(4)='1') or 
			    (D(5)='1' and T(5)='1') else '0';

	PC_loaded <= '1' when (D(4)='1' and T(4)='1') or (D(5)='1' and T(5)='1') else
			'0' when (T(1)='1' and clk='0');

	PC_inc <= '1' when  ( PC_loaded='0' and T(1)='1') or 
			   (D(6)='1' and T(6)='1' and DR_output="0000000000000000") or 
			   (D(7)='1' and I='0' and T(3)='1' and 
				( 
				  ( E='0' and IR_11_0(1)='1' ) or 
				  ( AC_output="0000000000000000" and IR_11_0(2)='1' ) or 
				  ( AC_output(15)='1' and IR_11_0(3)='1' ) or 
				  ( AC_output(15)='0' and IR_11_0(4)='1' ) 
				)
			) else '0';
	---------------------------------------------------
	---------------------------------------------------
	AR_load <= '1' when (T(0)='1') or 
			    (T(2)='1' )or 
			    (D(7)='0' and I='1' and T(3)='1') else '0';

	AR_rst <= '0';
	AR_inc <= '1' when (D(5)='1' and T(4)='1') else '0';
	------------------------------------------------------
	------------------------------------------------------
	DR_load<= '1' when (D(0)='1' and T(4)='1') or 
			   (D(1)='1' and T(4)='1') or 
			   (D(2)='1' and T(4)='1') or 
			   (D(6)='1' and T(4)='1') else '0';
	DR_rst <= '0';
	DR_inc <= '1' when (D(6)='1' and T(5)='1') else '0';
	------------------------------------------------------
	------------------------------------------------------
	IR_load <= '1' when T(1)='1' else '0' ;
	------------------------------------------------------
	------------------------------------------------------
	AC_load <= '1' when (D(0)='1' and T(5)='1') or 
			    (D(1)='1' and T(5)='1') or 
			    (D(2)='1' and T(5)='1') else '0';

	AC_rst <= '1' when (D(7)='1' and I='0' and T(3)='1' and
			    IR_11_0(11)='1') else '0' ;

	AC_inc <= '1' when (D(7)='1' and I='0' and T(2)='1' and
			    IR_11_0(5)='1') else '0' ;

	AC_comp <= '1' when (D(7)='1' and I='0' and T(3)='1' and
			    IR_11_0(9)='1') else '0' ;

	AC_shr <= '1' when (D(7)='1' and I='0' and T(3)='1' and
			    IR_11_0(7)='1') else '0' ;

	AC_shl <= '1' when (D(7)='1' and I='0' and T(3)='1' and
			    IR_11_0(6)='1') else '0' ;
	------------------------------------------------------
	------------------------------------------------------
	SC_rst <= '1' when (D(0)='1' and T(6)='1') or 
			   (D(1)='1' and T(6)='1') or 
			   (D(2)='1' and T(6)='1') or 
			   (D(3)='1' and T(5)='1') or 
			   (D(4)='1' and T(5)='1') or 
			   (D(5)='1' and T(6)='1') or 
			   (D(6)='1' and T(7)='1') or 
			   (D(7)='1' and I='0' and T(3)='1') else '0';
	------------------------------------------------------
	------------------------------------------------------
	memory_read <= '1' when (T(1)='1') or
				(D(7)='0' and I='1' and T(3)='1') or
				(D(0)='1' and T(4)='1') or
				(D(1)='1' and T(4)='1') or
				(D(2)='1' and T(4)='1') or
				(D(6)='1' and T(4)='1') else '0';
	
	memory_write <= '1' when (D(3)='1' and T(4)='1') or
				 (D(5)='1' and T(4)='1' and clk='1') or
				 (D(6)='1' and T(6)='1') or
				 (D(6)='1' and T(4)='1') else '0'; 
	------------------------------------------------------
	------------------------------------------------------

end Set_pins;
