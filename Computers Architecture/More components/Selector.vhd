-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY Selector IS
GENERIC ( n: Integer:= 16);
PORT ( Reg, Memory, WriteBack: IN std_logic_vector(n-1 downto 0);
			operation: IN std_logic_vector( 1 downto 0 );
			output: OUT std_logic_vector(n-1 downto 0));
END Selector;

ARCHITECTURE LogicFunc OF Selector IS
BEGIN
	WITH operation SELECT
		output <= Reg when "00",
		WriteBack when "01",
		Memory when "10",
		"0000000000000000" when "11";
END LogicFunc;