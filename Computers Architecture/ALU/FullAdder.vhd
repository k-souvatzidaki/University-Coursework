--Κωνσταντίνα Σουβατζιδάκη, 3170149 
--Χαρά Γκέργκη, 3170029
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY FullAdder IS
PORT(input1,input2,carryIN: in std_logic;
		sum,carryOUT: out std_logic);
END FullAdder;

ARCHITECTURE Behavior OF FullAdder IS
-- AND gate
COMPONENT myAND2
PORT(input1,input2: in std_logic;
		output1: out std_logic);
END COMPONENT;
-- OR gate
COMPONENT myOR3
PORT(input1,input2,input3: in std_logic;
		output1: out std_logic);
END COMPONENT;
-- XOR gate
COMPONENT myXOR3
PORT(input1,input2,input3: in std_logic;
		output1: out std_logic);
END COMPONENT;

SIGNAL s1,s2,s3: std_logic;
BEGIN
	v0: myXOR3 PORT MAP(input1,input2,carryIN,sum);
	v1: myAND2 PORT MAP(input1,input2,s1);
	v2: myAND2 PORT MAP(input1,carryIN,s2);
	v3: myAND2 PORT MAP(input2,carryIN,s3);
	v4: myOR3 PORT MAP(s1,s2,s3,carryOUT);
END Behavior;