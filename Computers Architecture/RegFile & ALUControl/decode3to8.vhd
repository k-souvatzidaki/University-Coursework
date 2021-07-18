-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY decode3to8 IS
PORT(
	input: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	output: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END decode3to8;

ARCHITECTURE LogicFunc OF decode3to8 IS
BEGIN
  WITH input SELECT
    output <= "00000001" WHEN "000",
	   "00000010" WHEN "001",
		"00000100" WHEN "010",
		"00001000" WHEN "011",
		"00010000" WHEN "100",
		"00100000" WHEN "101",
		"01000000" WHEN "110",
		"10000000" WHEN "111",
		"00000000" WHEN OTHERS;
END LogicFunc;