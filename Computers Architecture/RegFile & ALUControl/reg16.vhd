-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
ENTITY reg16 IS
GENERIC (n : INTEGER := 16);
PORT(input : IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	  enable, clock : IN STD_LOGIC;
	  output : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END reg16;
ARCHITECTURE LogicFunc OF reg16 IS
	COMPONENT GatedClockDFF IS
		PORT (input, clock, enable : IN STD_LOGIC;
				output : OUT STD_LOGIC);
		END COMPONENT;
BEGIN 
	G0: GatedClockDFF PORT MAP (input(0), clock, enable, output(0));
	G1: GatedClockDFF PORT MAP (input(1), clock, enable, output(1));
	G2: GatedClockDFF PORT MAP (input(2), clock, enable, output(2));
	G3: GatedClockDFF PORT MAP (input(3), clock, enable, output(3));
	G4: GatedClockDFF PORT MAP (input(4), clock, enable, output(4));
	G5: GatedClockDFF PORT MAP (input(5), clock, enable, output(5));
	G6: GatedClockDFF PORT MAP (input(6), clock, enable, output(6));
	G7: GatedClockDFF PORT MAP (input(7), clock, enable, output(7));
	G8: GatedClockDFF PORT MAP (input(8), clock, enable, output(8));
	G9: GatedClockDFF PORT MAP (input(9), clock, enable, output(9));
	G10: GatedClockDFF PORT MAP (input(10), clock, enable, output(10));
	G11: GatedClockDFF PORT MAP (input(11), clock, enable, output(11));
	G12: GatedClockDFF PORT MAP (input(12), clock, enable, output(12));
	G13: GatedClockDFF PORT MAP (input(13), clock, enable, output(13));
	G14: GatedClockDFF PORT MAP (input(14), clock, enable, output(14));
	G15: GatedClockDFF PORT MAP (input(15), clock, enable, output(15));
END LogicFunc;

