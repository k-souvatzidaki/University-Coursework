-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_ID_EX IS
GENERIC (n: integer :=16;
			addressSize: Integer :=3 );
PORT (clock, isEOR, wasJumpOut, isJump, isJR, isBranch, isR, isMFPC, isLW, isSW, isReadDigit, isPrintDigit: IN std_logic;
		ALUFunc: IN std_logic_vector(3 downto 0);
		R1Reg, R2Reg, immediate16: IN std_logic_vector(n-1 downto 0);
		R2AD, R1AD: IN std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr: IN std_logic_vector(11 downto 0);
		-----------------------------------------------------------------------------
		isEOR_IDEX, wasJumpout_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX: OUT std_logic;
		ALUFunc_IDEX: OUT std_logic_vector(3 downto 0);
		R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX: OUT std_logic_vector(n-1 downto 0);
		R2AD_IDEX, R1AD_IDEX: OUT std_logic_vector(addressSize-1 downto 0);
		jumpShortAddr_IDEX: OUT std_logic_vector(11 downto 0)
	);
END register_ID_EX;

ARCHITECTURE LogicFunc OF register_ID_EX IS
BEGIN
	pc: PROCESS(clock)
	BEGIN
		IF clock='1' THEN
			isEOR_IDEX<= isEOR;
			wasJumpOut_IDEX <= wasJumpOut;
			isJump_IDEX <= isJump;
			isJR_IDEX <= isJR;
			isBranch_IDEX <= isBranch;
			isR_IDEX <= isR;
			isMFPC_IDEX <= isMFPC;
			ALUFunc_IDEX <= ALUFunc;
			R1Reg_IDEX <= R1Reg;
			R2Reg_IDEX <= R2Reg;
			immediate16_IDEX <= immediate16;
			R2AD_IDEX <= R2AD;
			R1AD_IDEX <= R1AD;
			jumpShortAddr_IDEX <= jumpShortAddr;
			isSW_IDEX <= isSW;
			isLW_IDEX <= isLW;
			isReadDigit_IDEX <= isReadDigit;
			isPrintDigit_IDEX <= isPrintDigit;
		END IF;
	END PROCESS pc;
END LogicFunc;