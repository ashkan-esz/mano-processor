Library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------
Entity App is
	port(clk : in std_logic;
		TT : out std_logic_vector(15 downto 0);
		DD : out std_logic_vector(7 downto 0);
		AR_out : out std_logic_vector(11 downto 0);
		PC_out : out std_logic_vector(11 downto 0);
		memory_in : out std_logic_vector(15 downto 0);
		memory_out : out std_logic_vector(15 downto 0);
		DR_out : out std_logic_vector(15 downto 0);
		AC_out : out std_logic_vector(15 downto 0);
		IR_out : out std_logic_vector(15 downto 0);
		TR_out : out std_logic_vector(15 downto 0);
		EE : out std_logic;
		II : out std_logic;
		CC_out : out std_logic;
		SS : out std_logic);
end App;
--------------------------------------------------
Architecture App of App is
--------------------------------------------------
component Ram
   Generic(bits : Integer := 16;
	words : Integer := 50);
   port(clk,read,write : in std_logic;
	addr : in std_logic_vector(11 downto 0);
	data_in : in std_logic_vector(15 downto 0);
	data_out : out std_logic_vector(15 downto 0 ));
end component;
--------------------------------------------------
component SC_Decoder
	port(clk , SC_rst : in std_logic;
		T : out std_logic_vector(15 downto 0));
end component;
--------------------------------------------------
component IR_Decoder2
	port(
	clk : in std_logic;
	IR_output : in std_logic_vector(15 downto 0);
	I : out std_logic;
	D : out std_logic_vector(7 downto 0);
	IR_11_0 :out std_logic_vector(11 downto 0) );
end component;
--------------------------------------------------
component Buss 
  port(AR_output,PC_output : in std_logic_vector(11 downto 0);
       DR_output,AC_output,IR_output,
	TR_output,memory_data_out : in std_logic_vector(15 downto 0);

       selector: in std_logic_vector(2 downto 0);
	AR_input,PC_input: out  std_logic_vector(11 downto 0);
	DR_input,IR_input,
	TR_input,memory_data_in : out std_logic_vector(15 downto 0));
       
end component;
--------------------------------------------------
component Reg16 
  port( load , clk, rst, inc , comp,shr,shl,E: in std_logic;
	input: in std_logic_vector(15 downto 0);
        output: out std_logic_vector(15 downto 0));
end component;
--------------------------------------------------
component Reg12
  port(load,clk, rst, inc: in std_logic;
	input: in std_logic_vector(11 downto 0);
        output: out std_logic_vector(11 downto 0));
end component;
---------------------------------------------------
component Set_pins
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
end component;
---------------------------------------------------
component Alu
	port(	D : in std_Logic_vector(7 downto 0);
		T : in std_logic_vector(15 downto 0);
		AC_output,DR_output : in std_logic_vector(15 downto 0);
		AC_input : out std_logic_vector(15 downto 0);
		E,C_out : out std_logic);
end component;
---------------------------------------------------
 Signal memory_data_in : std_logic_vector(15 downto 0);
 Signal memory_data_out : std_logic_vector(15 downto 0);
 Signal memory_read : std_logic;
 Signal memory_write : std_logic;
--------------------------------------------------
 Signal PC_input : std_logic_vector (11 downto 0) ;
 Signal PC_output : std_logic_vector (11 downto 0) ;
 Signal PC_load : std_logic;
 Signal PC_inc : std_logic;
 Signal PC_rst : std_logic := '1';
---------------------------------------------------
 Signal AR_input : std_logic_vector (11 downto 0) ;
 Signal AR_output : std_logic_vector (11 downto 0) ;
 Signal AR_load : std_logic;
 Signal AR_inc : std_logic;
 Signal AR_rst : std_logic;
---------------------------------------------------
 Signal DR_input : std_logic_vector (15 downto 0) ;
 Signal DR_output : std_logic_vector (15 downto 0) ;
 Signal DR_load : std_logic;
 Signal DR_inc : std_logic;
 Signal DR_rst : std_logic;
---------------------------------------------------
 Signal AC_input : std_logic_vector (15 downto 0) :="0000000000000000" ;
 Signal AC_output : std_logic_vector (15 downto 0) ;
 Signal AC_load : std_logic;
 Signal AC_rst : std_logic;
 Signal AC_inc : std_logic;
 Signal AC_comp : std_logic;
 Signal AC_shr : std_logic;
 Signal AC_shl : std_logic;
---------------------------------------------------
 Signal IR_input : std_logic_vector (15 downto 0) ;
 Signal IR_output : std_logic_vector (15 downto 0) ;
 Signal IR_load : std_logic;
---------------------------------------------------
 Signal TR_input : std_logic_vector (15 downto 0) ;
 Signal TR_output : std_logic_vector (15 downto 0) ;
 Signal TR_load : std_logic;
 Signal TR_inc : std_logic;
 Signal TR_rst : std_logic;
---------------------------------------------------
 Signal T : std_logic_vector(15 downto 0);
 Signal I : std_logic;
 Signal D : std_logic_vector(7 downto 0);
 Signal IR_11_0 : std_logic_vector(11 downto 0);
 Signal E : std_logic;
 Signal C_out : std_logic :='0';
 Signal S : std_logic :='0';
 Signal buss_selector : std_logic_vector(2 downto 0);
 Signal SC_rst : std_logic;

begin
	u1 : SC_Decoder  port map(clk,SC_rst,T);
	u2 : IR_Decoder2 port map(clk,IR_output,I,D,IR_11_0);
	u3 : Ram   port map(clk,memory_read,memory_write,
			    AR_output,
			    memory_data_in,memory_data_out);
	
	AR : Reg12 port map(AR_load ,clk, AR_rst, AR_inc, AR_input, AR_output);
	PC : Reg12 port map(PC_load ,clk, PC_rst, PC_inc, PC_input, PC_output);
	DR : Reg16 port map(DR_load ,clk, DR_rst, DR_inc,'0','0','0',E,DR_input,DR_output);
	AC : Reg16 port map(AC_load ,clk, AC_rst, AC_inc,
				AC_comp , AC_shr , AC_shl,E,
				AC_input , AC_output);
	IR : Reg16 port map(IR_load ,clk,'0','0','0','0','0',E, IR_input, IR_output);
	TR : Reg16 port map(TR_load ,clk, TR_rst, TR_inc,'0','0','0',E, TR_input, TR_output);

	BUSSS : Buss port map(AR_output,PC_output,
			     DR_output,AC_output,IR_output,TR_output,memory_data_out,
				buss_selector,
			     AR_input,PC_input,
			     DR_input,IR_input,
				TR_input,memory_data_in);

	Pins : Set_pins port map (clk,I,D,T,E,
				DR_output,AC_output,IR_11_0,
				PC_load,PC_inc,
				AR_load,AR_rst,AR_inc,
				DR_load,DR_rst,DR_inc,
				IR_load,
				AC_load,AC_rst,AC_inc,AC_comp,AC_shr,AC_shl,
				SC_rst,
				memory_read,memory_write);

	ALUU : Alu port map(D,T,
			   AC_output,DR_output,
			   AC_input,
			   E,C_out);
--------------------------------------------------------------------------
--------------------------------------------------------------------------
	PC_rst <= '0';

	S <= '1' when (D(7)='1' and I='0' and T(3)='1' and IR_11_0(0)='1');

	E <= C_out when (D(1)='1' and T(5)='1') else 
	     '0' when (D(7)='1' and I='0' and T(3)='1' and IR_11_0(10)='1') else
	     not(E) when (D(7)='1' and I='0' and T(3)='1' and IR_11_0(8)='1') else
	     AC_output(0)  when (D(7)='1' and I='0' and T(3)='1' and IR_11_0(7)='1') else
	     AC_output(15) when (D(7)='1' and I='0' and T(3)='1' and IR_11_0(6)='1');
	------------------------------------------------------------------
	------------------------------------------------------------------
	------------------------------------------------------------------
	buss_selector <= "001" when (D(4)='1' and T(4)='1') or 
				    (D(5)='1' and T(5)='1')  else 

			 "010" when (T(0)='1') or
				    (D(5)='1' and T(4)='1')  else

			 "011" when (D(2)='1' and T(5)='1') or
				    (D(6)='1' and T(6)='1')  else	

			 "100" when (D(3)='1' and T(4)='1')  else

			 "101" when (T(2)='1')  else

			 --"110" when ()  else 
		--temp register didnt used because there is no I/O

			 "111" when  (D(0)='1' and T(4)='1') or
				     (D(1)='1' and T(4)='1') or
				     (D(2)='1' and T(4)='1') or 
				     (D(6)='1' and T(4)='1') or 
				     (T(1)='1') or
				     (D(7)='0' and I='1' and T(3)='1') else

			 "000";
	------------------------------------------------------
	------------------------------------------------------
	TT <= T; 
	DD<= D;
	AR_out <= AR_output;
	PC_out <= PC_output;
	memory_in <= memory_data_in;
	memory_out <= memory_data_out;
	DR_out <= DR_output;
	AC_out <= AC_output;
	IR_out <= IR_output;
	TR_out <= TR_output;
	EE <= E;
	II <= I;
	CC_out <= C_out;
	SS <= S;

end App;
