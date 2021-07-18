-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY AluControl IS
PORT(
	opCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	func: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	output: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END AluControl;

ARCHITECTURE LogicFunc OF AluControl IS
BEGIN
	PROCESS(opCode, func)
	BEGIN
		CASE opCode IS
			WHEN "0000" =>
			--if R instruction: return 'func' padded with a zero
			output(3) <= '0';
			output(2 DOWNTO 0) <= func(2 DOWNTO 0);
			WHEN OTHERS => output <= opCode;
		END CASE;
	END PROCESS;
END LogicFunc;