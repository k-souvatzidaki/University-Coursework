--Κωνσταντίνα Σουβατζιδάκη, 3170149 
--Χαρά Γκέργκη, 3170029
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY myOR3 IS
PORT(input1,input2,input3: in std_logic;
		output1: out std_logic);
END myOR3;

ARCHITECTURE Behavior OF myOR3 IS
BEGIN
	output1 <= input1 OR input2 OR input3;
END Behavior;