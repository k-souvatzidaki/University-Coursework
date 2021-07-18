--Κωνσταντίνα Σουβατζιδάκη, 3170149 
--Χαρά Γκέργκη, 3170029
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX IS
PORT(input1,input2,sig: in std_logic;
		output1: out std_logic);
END MUX;

ARCHITECTURE Behavior OF MUX IS
BEGIN
	output1 <= (input1 AND NOT sig) OR (input2 AND sig);
END Behavior;