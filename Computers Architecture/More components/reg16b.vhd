-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY reg16b IS --PC register
PORT( input: IN std_logic_vector(15 downto 0);
		enable, clock: IN std_logic;
		output: OUT std_logic_vector(15 downto 0));
END reg16b;

ARCHITECTURE LogicFunc OF reg16b IS
BEGIN
	PROCESS(clock)
	BEGIN
		IF clock'EVENT AND Clock ='0' THEN
			IF enable = '1' THEN
				output <= input;
			END IF;
		END IF;
	END PROCESS;
END LogicFunc;