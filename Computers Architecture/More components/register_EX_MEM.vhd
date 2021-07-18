-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_EX_MEM IS
GENERIC (n: integer:= 16;
			addressSize: integer := 3 );
PORT (clock, isLW, WriteEnable, ReadDigit, PrintDigit: IN std_logic;
		R2Reg, Result: IN std_logic_vector(n-1 downto 0);
		RegAD: IN std_logic_vector(addressSize-1 downto 0);
		---------------------------------------------------------
		isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM: OUT std_logic;
		R2Reg_EXMEM, Result_EXMEM: OUT std_logic_vector(n-1 downto 0);
		RegAD_EXMEM: OUT std_logic_vector(addressSize-1 downto 0));
END register_EX_MEM;

ARCHITECTURE LogicFunc OF register_EX_MEM IS
BEGIN
	pc: PROCESS(clock)
	BEGIN
		IF clock='1' THEN
			RegAD_EXMEM <= RegAD;
			R2Reg_EXMEM <= R2Reg;
			Result_EXMEM <= Result;
			isLW_EXMEM <= isLW;
			WriteEnable_EXMEM <= WriteEnable;
			ReadDigit_EXMEM <= ReadDigit;
			PrintDigit_EXMEM <= PrintDigit;
		END IF;
	END PROCESS pc;
END LogicFunc;