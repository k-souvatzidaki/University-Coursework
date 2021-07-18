-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY Forwarder IS
GENERIC (addr_size: integer:= 3);
PORT (	R1AD, R2AD, RegAD_EXMEM, RegAD_MEMWB: IN std_logic_vector(addr_size-1 DOWNTO 0);
			S1, S2: OUT std_logic_vector(1 DOWNTO 0));
END Forwarder;

ARCHITECTURE LogicFunc OF Forwarder IS
BEGIN
	PROCESS(RegAD_EXMEM, RegAD_MEMWB, R1AD, R2AD)
	BEGIN 
	-- DEFAULT = 00 (default input is used)
	S1<="00"; -- R1AD
	S2<="01"; -- R2AD
	
	IF (R1AD = RegAD_EXMEM) THEN
		S1 <= "10"; -- Reg_AD_EXMEM
	ELSIF (R1AD = RegAD_MEMWB) THEN
		S1 <= "01"; -- RegAD_MEMWB
	END IF;
	
	IF (R2AD = RegAD_EXMEM) THEN
		S2 <= "10"; -- Reg_AD_EXMEM
	ELSIF(R2AD = RegAD_MEMWB) THEN
		S2 <= "01"; -- RegAD_MEMWB
	END IF;
	END PROCESS;
END LogicFunc;