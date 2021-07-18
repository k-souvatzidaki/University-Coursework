-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY Controller IS
PORT(opCode: IN std_logic_vector(3 downto 0);
		func: IN std_logic_vector(2 downto 0);
		flush: IN std_logic;
		isMFPC, isJumpD, isReadDigit, isPrintDigit: OUT std_logic;
		isR, isLW, isSW, isBranch, isJR: OUT std_logic);
END Controller;

ARCHITECTURE LogicFunc OF Controller IS
BEGIN
	get_result: PROCESS(flush, func, opCode) BEGIN
	IF flush = '1' THEN
		isR <= '0';
		isMFPC <= '0';
		isLW <= '0';
		isSW <= '0';
		isBranch <= '0';
		isReadDigit <= '0';
		isPrintDigit <= '0';
		isJumpD <= '0';
		isJR <= '0';
	END IF;
		
	IF flush ='0' THEN 
		CASE opCode IS
			WHEN "0000" =>
				isR <= '1';
				IF func = "111" THEN
					isMFPC <= '1';
				END IF;
			WHEN "0001" =>
				isLW <= '1';
			WHEN "0010" =>
				isSW <= '1';
			WHEN "0100" =>
				isBranch <= '1';
			WHEN "0110" =>
				isReadDigit <= '1';
			WHEN "0111" =>
				isPrintDigit <= '1';
			WHEN "1111" =>
				isJumpD <= '1';
			WHEN "1101" =>
				isJR <= '1';
			WHEN OTHERS =>
				isR <= '0';
		END CASE;
	END IF;
	END PROCESS;
END LogicFunc;
