-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY TrapUnit IS
PORT (opcode: IN std_logic_vector(3 downto 0);
		EOR: OUT std_logic);
END TrapUnit;

ARCHITECTURE LogicFunc OF TrapUnit IS
BEGIN
	PROCESS (opcode)
	BEGIN
		IF opcode ="1110" THEN
			EOR <= '1';
		ELSE
			EOR <= '0';
		END IF;
	END PROCESS;
END LogicFunc;