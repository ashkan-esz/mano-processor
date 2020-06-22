Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------
Entity Ram is
	Generic(bits : Integer := 16;
		words : Integer := 50);
	port(clk,read,write : in std_logic;
		addr : in std_logic_vector(11 downto 0);
		data_in : in std_logic_vector(15 downto 0);
		data_out : out std_logic_vector(15 downto 0 ));
end Ram;
----------------------------------
Architecture Ram of Ram is

type mem is array (0 to words-1) of std_logic_vector( bits-1 downto 0);
Signal memory : mem := (
			--------memory reference-----
			"0010000000011111", --0 : D2(LDA) => ac = m(ar:31)=5
			"1001000000000010", --1 : D1(ADD) => ac = ac:5 + m(ar:2) 
			"0000000000100000", --2 : in_address ac = ac:5 + m(32)=7 ==12
			
			"0000000000100001", --3 : D0(AND) => ac = ac:1100 ^ m(ar:33):0100 ==0100=4
			"0011000000100001", --4 : D3(STA) => m(ar:33) = ac = 0100=4
			"0010000000011111", --5 : D2(LDA) => ac = m(ar:31)=5
			"0010000000100001", --6 : D2(LDA) => ac = m(ar:33):0100=4

			"0100000000001010", --7 : D4(BUN) => pc = ar:10 = 10
			"0000000000000000", --8 : skipped!
			"0000000000000000", --9 : skipped!
			
			"0101000000001011", --10 : D5(BSA) => m(ar:11) = pc = 10 , pc = ar:11++ =12
			"0000000000000000", --11 :  = pc = 10
			"0110000000100010", --12 : D6(ISA) => m(ar:34) = m(ar:34) + 1 = 0+1=1
			"0110000000100011", --13 : D6(ISA) => m(ar:35) = m(ar:35) + 1,(m+1=0) pc=pc+1=14
			"0000000000000000", --14 : skipped!

			-----register reference----

			"0111100000000000", --15 : B11(CLA) => ac = 0
			"0111010000000000", --16 : B10(CLE) => E = 0
			"0111001000000000", --17 : B9(CMA) => ac = comp(ac)
			"0111000100000000", --18 : B8(CME) => E = comp(E)
			"0010000000100100", --19 : D2(LDA) => ac = m(ar:36)= 0001110000011110
			"0111010000000000", --20 : B10(CLE) => E = 0
			"0111000010000000", --21 : B7(CIR) => shr(ac),E=0  = 0000111000001111,E=0
			"0111000001000000", --22 : B6(CIR) => shl(ac),E=0  = 0001110000011110,E=0
			"0111000000100000", --23 : B5(INC) => ac = ac +1 = 0001110000011111
			"0111000000010000", --24 : B4(SPA) => if ac(15)=0 pc++
			"0111000000001000", --25 : B3(SNA) => if ac(15)=1 pc++
			"0000000000000000", --26 : skipped !!
			"0111000000000100", --27 : B2(SZA) => if (ac='00') pc++
			"0111000000000010", --28 : B1(SZE) => if E=0 pc++
			"0111000000000001", --29 : B0(HLT) => S = 0  programm done!
			"0000000000000000", --30

			---- memory values -----
			"0000000000000101", --31 -
			"0000000000000111", --32 -
			"0000000000000100", --33 -
			"0000000000000000", --34   = 1
			"1111111111111111", --35 -
			"0001110000011110", --36 -
			"0000000000000000", --37
			"0000000000000000", --38
			"0000000000000000", --39
			"0000000000000000", --40
			"0000000000000000", --41
			"0000000000000000", --42
			"0000000000000000", --43
			"0000000000000000", --44
			"0000000000000000", --45
			"0000000000000000", --46
			"0000000000000000", --47
			"0000000000000000", --48
			"0000000000000000"  --49
		) ;
Begin

	process(clk)
	begin
	
		if (clk'event and clk='1' and write = '1') then
			memory(to_integer(unsigned(addr))) <= data_in;
		end if;
			
	end process;


	data_out <= memory(to_integer(unsigned(addr))) when (read = '1');
	--memory(to_integer(unsigned(addr))) <= data_in when (write = '1');
end Ram;




