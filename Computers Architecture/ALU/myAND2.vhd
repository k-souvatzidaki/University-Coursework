--Κωνσταντίνα Σουβατζιδάκη, 3170149 
--Χαρά Γκέργκη, 3170029
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY myAND2 IS
PORT(input1,input2: in std_logic;
		output1: out std_logic);
END myAND2;

ARCHITECTURE Behavior OF myAND2 IS
BEGIN
	output1 <= input1 AND input2;
END Behavior;