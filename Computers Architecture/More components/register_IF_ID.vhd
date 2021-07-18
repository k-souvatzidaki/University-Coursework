-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_IF_ID IS
GENERIC (
  n : integer := 16
);

PORT(
    inPC, inInstruction: IN std_logic_vector(n-1 downto 0);
	 clock, IF_Flush, IF_ID_enable: IN std_logic;
	 outPC, outInstruction: OUT std_logic_vector(n-1 downto 0)
);
END register_IF_ID;

ARCHITECTURE LogicFunc OF register_IF_ID IS
BEGIN
  pc: PROCESS(clock, IF_Flush, IF_ID_enable)
  BEGIN
    if clock='1' AND IF_ID_enable='1' THEN
	   outPC <= std_logic_vector(signed(inPC) + 2);
		outInstruction <= inInstruction;
	 ELSIF clock='1' AND IF_Flush='1' THEN
	   outPC <= (OTHERS => '0');
		outInstruction <= (OTHERS => '0');
	 END IF;
  END PROCESS;
END LogicFunc;