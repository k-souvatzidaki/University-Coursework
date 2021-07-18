-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY JRSelector IS
GENERIC ( n: integer :=16 );
PORT (jumpAD, branchAD, PCP2AD: IN std_logic_vector(n-1 downto 0);
		JRopcode: IN std_logic_vector(1 downto 0);
		result: OUT std_logic_vector(n-1 downto 0));
END JRSelector;

ARCHITECTURE LogicFunc OF JRSelector IS
BEGIN
	--OPCODE:
	-- 00: +2 από το outPC του IF_ID
	-- 01: JumpAD
	-- 10:BranchAD
	PROCESS(JRopcode)
	BEGIN
		CASE JRopcode IS
			WHEN "00" =>
				result <= PCP2AD;
			WHEN "01" =>
				result <= JumpAD;
			WHEN "10" =>
				result <= branchAD;
			WHEN OTHERS => result <= PCP2AD;
		END CASE;
	END PROCESS;
END LogicFunc;