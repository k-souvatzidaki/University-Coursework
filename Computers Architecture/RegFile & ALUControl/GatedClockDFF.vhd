-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;
ENTITY GatedClockDFF IS
PORT (input, clock, enable: IN STD_Logic;
		Output : OUT STD_Logic);
END GatedClockDFF;

ARCHITECTURE LogicFunc OF GatedClockDFF IS
SIGNAL P1, P2, P3, P4, five, six, afterClock : STD_Logic;
BEGIN
	P3 <= P1 NAND P4;
	P1 <= afterClock NAND P3;
	P2 <= NOT(afterClock AND P1 AND P4);
	P4 <= input NAND P2;
	five <= six NAND P1;
	six <= P2 NAND five;
	afterClock <= clock AND enable;
	output <= five;
END LogicFunc;