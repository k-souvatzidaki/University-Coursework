--Κωνσταντίνα Σουβατζιδάκη, 3170149 
--Χαρά Γκέργκη, 3170029
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.all;

ENTITY ALU IS
	GENERIC(
		n : INTEGER :=16);
	PORT(input1,input2: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			carryIN: IN STD_LOGIC;
			carryOut: OUT STD_LOGIC;
			operation: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END ALU;

ARCHITECTURE Behavior OF ALU IS
	COMPONENT ALUSlice IS
		PORT(input1,input2,carryIN,AInvert,BInvert,OP1,OP2:in std_logic;
		output1,carryOUT: out std_logic);
	END COMPONENT;
	
	SIGNAL carryOuts, temp : STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	SIGNAL finalCarryOut : STD_LOGIC;
	
	CONSTANT AND_OP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	CONSTANT OR_OP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0001";
	CONSTANT ADD_OP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0010";
	CONSTANT SUB_OP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0011";
	CONSTANT GEQ_OP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0101";
	CONSTANT NOT_OP : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0110";
	
	BEGIN
	G0: ALUSlice PORT MAP (input1(0), input2(0), carryIN, operation(3), operation(2), operation(0), operation(1), temp(0), carryOuts(0));
	G1: ALUSlice PORT MAP (input1(1), input2(1), carryOuts(0), operation(3), operation(2), operation(0), operation(1), temp(1), carryOuts(1));
	G2: ALUSlice PORT MAP (input1(2), input2(2), carryOuts(1), operation(3), operation(2), operation(0), operation(1), temp(2), carryOuts(2));
	G3: ALUSlice PORT MAP (input1(3), input2(3), carryOuts(2), operation(3), operation(2), operation(0), operation(1), temp(3), carryOuts(3));
	G4: ALUSlice PORT MAP (input1(4), input2(4), carryOuts(3), operation(3), operation(2), operation(0), operation(1), temp(4), carryOuts(4));
	G5: ALUSlice PORT MAP (input1(5), input2(5), carryOuts(4), operation(3), operation(2), operation(0), operation(1), temp(5), carryOuts(5));
	G6: ALUSlice PORT MAP (input1(6), input2(6), carryOuts(5), operation(3), operation(2), operation(0), operation(1), temp(6), carryOuts(6));
	G7: ALUSlice PORT MAP (input1(7), input2(7), carryOuts(6), operation(3), operation(2), operation(0), operation(1), temp(7), carryOuts(7));
	G8: ALUSlice PORT MAP (input1(8), input2(8), carryOuts(7), operation(3), operation(2), operation(0), operation(1), temp(8), carryOuts(8));
	G9: ALUSlice PORT MAP (input1(9), input2(9), carryOuts(8), operation(3), operation(2), operation(0), operation(1), temp(9), carryOuts(9));
	G10: ALUSlice PORT MAP (input1(10), input2(10), carryOuts(9), operation(3), operation(2), operation(0), operation(1), temp(10), carryOuts(10));
	G11: ALUSlice PORT MAP (input1(11), input2(11), carryOuts(10), operation(3), operation(2), operation(0), operation(1), temp(11), carryOuts(11));
	G12: ALUSlice PORT MAP (input1(12), input2(12), carryOuts(11), operation(3), operation(2), operation(0), operation(1), temp(12), carryOuts(12));
	G13: ALUSlice PORT MAP (input1(13), input2(13), carryOuts(12), operation(3), operation(2), operation(0), operation(1), temp(13), carryOuts(13));
	G14: ALUSlice PORT MAP (input1(14), input2(14), carryOuts(13), operation(3), operation(2), operation(0), operation(1), temp(14), carryOuts(14));
	G15: ALUSlice PORT MAP (input1(15), input2(15), carryOuts(14), operation(3), operation(2), operation(0), operation(1), temp(15), finalCarryOut);

	PROCESS(operation)
		VARIABLE temp1: STD_LOGIC_VECTOR(n-1 DOWNTO 0); 
		VARIABLE temp2: STD_LOGIC_VECTOR( 2*n-1 DOWNTO 0); 
		VARIABLE temp3, temp4: STD_LOGIC; 

	BEGIN
		CASE operation IS
			WHEN ADD_OP =>
				temp1 := temp;
			WHEN SUB_OP =>
				temp1 := input1 - input2;
			WHEN AND_OP =>
				temp1 := temp;
			WHEN OR_OP =>
				temp1 := temp;
			WHEN GEQ_OP =>
				temp1 := (OTHERS => NOT(input1(n-1)));
				temp3 := NOT(input1(n-1));
				temp4 := '0';
			WHEN NOT_OP =>
				temp1 := (OTHERS => '0');
				IF (input1 = (n-1 DOWNTO 0 => '0')) THEN
					temp1(0) := '1';
				END IF;
			WHEN OTHERS =>
				temp1 := (OTHERS => '0');
			END CASE;
			
			IF(temp4 = '0') THEN 
				carryOut <= temp3;
			ELSE
				carryOut <= finalCarryOut;
			END IF;
			
			output <= temp1;
	END PROCESS;				
END Behavior;