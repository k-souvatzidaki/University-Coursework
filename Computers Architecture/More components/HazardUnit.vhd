-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY HazardUnit IS
PORT (isJR, isJump, wasJump, mustBranch: IN std_logic;
		flush, wasJumpOut: OUT std_logic;
		JRopcode: OUT std_logic_vector(1 downto 0));
END HazardUnit;

ARCHITECTURE LogicFunc OF HazardUnit IS
BEGIN
	--OPCODE
	-- 00: +2
	-- 01: JumpADd
	-- 10: BranchAd
	PROCESS (isJR, isJump, wasJump, mustBranch)
		BEGIN
			flush <= '0';
			IF isJR = '1' OR isJump = '1' OR wasJump = '1' OR mustBranch = '1' THEN
				flush <= '1';
			END IF;
			
			IF isJump = '1' THEN
				JRopcode <= "01";
			ELSIF mustBranch = '1' THEN
				JRopcode <= "10";
			ELSE
				JRopcode <= "00";
			END IF;
	END PROCESS;
	
	wasJumpOut <= isJump;
END LogicFunc;