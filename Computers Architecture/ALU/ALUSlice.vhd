--Κωνσταντίνα Σουβατζιδάκη, 3170149 
--Χαρά Γκέργκη, 3170029
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY ALUSlice IS
PORT(input1,input2,carryIN,AInvert,BInvert,OP1,OP2:in std_logic;
		output1,carryOUT: out std_logic);
END ALUSlice;

ARCHITECTURE Behavior OF ALUSlice IS
-- full adder
COMPONENT FullAdder IS
PORT(input1,input2,carryIN: in std_logic;
		sum,carryOUT: out std_logic);
END COMPONENT;
-- mux
COMPONENT MUX IS
PORT(input1,input2,sig: in std_logic;
		output1: out std_logic);
END COMPONENT;
-- mux3
COMPONENT MUX3 IS
PORT(input1,input2,input3,sig1,sig2: in std_logic;
		output1: out std_logic);
END COMPONENT;

SIGNAL f1,f2,f3,f4,f5: std_logic;
BEGIN
	G0: MUX PORT MAP(input1,NOT input2,AInvert,f1);
	G1: MUX PORT MAP(input2,NOT input2, BINvert,f2);
	f3 <= f1 AND f2;
	f4 <= f1 OR f2;
	G2: FullAdder PORT MAP (f1,f2,carryIN,f5,carryOUT);
	G3: MUX3 PORT MAP(f3,f4,f5,OP1,OP2,output1);
END Behavior;