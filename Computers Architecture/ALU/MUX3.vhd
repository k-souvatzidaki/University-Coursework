--Κωνσταντίνα Σουβατζιδάκη, 3170149 
--Χαρά Γκέργκη, 3170029
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY MUX3 IS
PORT(input1,input2,input3,sig1,sig2: in std_logic;
		output1: out std_logic);
END MUX3;

ARCHITECTURE Behavior OF MUX3 IS
-- mux
COMPONENT MUX 
PORT(input1,input2,sig:in std_logic;
		output1: OUT STD_logic);
END COMPONENT;

SIGNAL f: std_logic;
BEGIN
	v0: MUX PORT MAP(input1,input2,sig1,f);
	v1: MUX PORT MAP(f,input3,sig2,output1);
END Behavior;