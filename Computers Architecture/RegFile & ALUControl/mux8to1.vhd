-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY mux8to1 IS
GENERIC(
         n : INTEGER := 16
		);
PORT(
	input0, input1, input2, input3, input4, input5, input6, input7: IN STD_Logic_vector(n-1 downto 0);
	choice: IN STD_Logic_vector(2 DOWNTO 0);
	output: OUT STD_Logic_vector(n-1 DOWNTO 0)
  );
END mux8to1;

ARCHITECTURE LogicFunc OF mux8to1 IS
BEGIN
  WITH choice SELECT
  output <= input0 WHEN "000",
    input1 WHEN "001",
	 input2 WHEN "010",
	 input3 WHEN "011",
	 input4 WHEN "100",
	 input5 WHEN "101",
	 input6 WHEN "110",
	 input7 WHEN "111",
	 "0000000000000000" WHEN OTHERS;
END LogicFunc;