-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_MEM_WB IS
GENERIC(
  n : integer := 16;
  addressSize : integer := 3
);

PORT(
    Result: IN std_logic_vector(n-1 downto 0);
	 RegAD: IN std_logic_vector(addressSize-1 downto 0);
	 clock: IN std_logic;
	 writeData: OUT std_logic_vector(n-1 downto 0);
	 writeAD: OUT std_logic_vector(addressSize-1 downto 0)
  );
END register_MEM_WB;

ARCHITECTURE LogicFunc OF register_MEM_WB IS
BEGIN
  pc: PROCESS(clock)
  BEGIN
    IF clock='1' THEN
	   writeData <= Result;
		writeAD <= RegAD;
    END IF;
  END PROCESS;
END LogicFunc;