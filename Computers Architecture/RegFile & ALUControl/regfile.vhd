-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY regfile IS
GENERIC(
         n : INTEGER := 16;
			k : INTEGER := 3;
			regnum : INTEGER := 8
		);

PORT(
   clock : IN STD_LOGIC;
	write1: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	write1ad, read1ad, read2ad: IN STD_LOGIC_VECTOR(k-1 DOWNTO 0);
	read1, read2: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	outall: OUT STD_LOGIC_VECTOR(n*regnum-1 DOWNTO 0)
  );
END regfile;

ARCHITECTURE LogicFunc OF regfile IS
  COMPONENT reg0 IS
  PORT(
	  input: in STD_LOGIC_VECTOR(n-1 DOWNTO 0);
	  enable, clock: in STD_LOGIC;
	  output: out STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
  END COMPONENT;
  
  COMPONENT reg16 IS
  PORT(
	   input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		enable, clock: IN STD_LOGIC;
		output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
  END COMPONENT;
  
  COMPONENT decode3to8 IS
  PORT(
	  input: IN STD_LOGIC_VECTOR(k-1 DOWNTO 0);
	  output: OUT STD_LOGIC_VECTOR(regnum-1 DOWNTO 0)
    );
  END COMPONENT;
  
  COMPONENT mux8to1 IS
    port(
	   input0, input1, input2, input3, input4, input5, input6, input7: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		choice: IN STD_LOGIC_VECTOR(k-1 DOWNTO 0);
		output: OUT	STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	 );
  END COMPONENT;
  
  SIGNAL enablesigs: STD_LOGIC_VECTOR(regnum-1 downto 0);
  SIGNAL re0, re1, re2, re3, re4, re5, re6, re7: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
  
BEGIN
  G0: decode3to8 PORT MAP (write1ad, enablesigs);

  G1: reg0 PORT MAP (write1, enablesigs(0), clock, re0);
  G2: reg16 PORT MAP (write1, enablesigs(1), clock, re1);
  G3: reg16 PORT MAP (write1, enablesigs(2), clock, re2);
  G4: reg16 PORT MAP (write1, enablesigs(3), clock, re3);
  G5: reg16 PORT MAP (write1, enablesigs(4), clock, re4);
  G6: reg16 PORT MAP (write1, enablesigs(5), clock, re5);
  G7: reg16 PORT MAP (write1, enablesigs(6), clock, re6);
  G8: reg16 PORT MAP (write1, enablesigs(7), clock, re7);
  
  G9: mux8to1 PORT MAP (re0, re1, re2, re3, re4, re5, re6, re7, read1ad, read1);
  G10: mux8to1 PORT MAP (re0, re1, re2, re3, re4, re5, re6, re7, read2ad, read2);
  
  outall <= re7 & re6 & re5 & re4 & re3 & re2 & re1 & re0;
  
END LogicFunc;
