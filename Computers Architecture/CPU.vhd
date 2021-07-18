-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;
USE ieee.numeric_std.all;

ENTITY CPU IS
PORT (keyData, fromData, instr: IN std_logic_vector(15 downto 0);
		clock, clock2: IN std_logic;
		printEnable, keyEnable, DataWriteFlag: OUT std_logic;
		dataAD, toData, printCode, printData, instructionAD: OUT std_logic_vector(15 downto 0);
		regOUT: OUT std_logic_vector(143 downto 0));
END CPU;


ARCHITECTURE LogicFunc OF CPU IS
-- ALU Component
COMPONENT ALU IS
	GENERIC(
		n : INTEGER :=16);
	PORT(input1,input2: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			carryIN: IN STD_LOGIC;
			carryOut: OUT STD_LOGIC;
			operation: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END COMPONENT;

-- AluControl Component
COMPONENT AluControl IS
PORT(
	opCode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	func: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	output: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
  );
END COMPONENT;
 
-- RegFile Component
COMPONENT RegFile IS
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
END COMPONENT;

-- TrapUnit Component
COMPONENT TrapUnit IS
PORT (opcode: IN std_logic_vector(3 downto 0);
		EOR: OUT std_logic);
END COMPONENT;

-- JRSelector Component
COMPONENT JRSelector IS
GENERIC ( n: integer :=16 );
PORT (jumpAD, branchAD, PCP2AD: IN std_logic_vector(n-1 downto 0);
		JRopcode: IN std_logic_vector(1 downto 0);
		result: OUT std_logic_vector(n-1 downto 0));
END COMPONENT;

-- reg16b Component - PC
COMPONENT reg16b IS 
PORT( input: IN std_logic_vector(15 downto 0);
		enable, clock: IN std_logic;
		output: OUT std_logic_vector(15 downto 0));
END COMPONENT;

-- register_MEM_WB Component
COMPONENT register_MEM_WB IS
GENERIC(
  n : integer := 16;
  addressSize : integer := 3
);
PORT(
    Result: IN std_logic_vector(n-1 downto 0);
	 RegAD: IN std_logic_vector(addressSize-1 downto 0);
	 clock: IN std_logic;
	 writeData: OUT std_logic_vector(n-1 downto 0);
	 writeAD: OUT std_logic_vector(addressSize-1 downto 0)
  );
END COMPONENT;

-- register_IF_ID Component
COMPONENT register_IF_ID IS
GENERIC (
  n : integer := 16
);

PORT(
    inPC, inInstruction: IN std_logic_vector(n-1 downto 0);
	 clock, IF_Flush, IF_ID_enable: IN std_logic;
	 outPC, outInstruction: OUT std_logic_vector(n-1 downto 0)
);
END COMPONENT;

-- Forwarder Component
COMPONENT Forwarder IS
GENERIC (addr_size: integer:= 3);
PORT (	R1AD, R2AD, RegAD_EXMEM, RegAD_MEMWB: IN std_logic_vector(addr_size-1 DOWNTO 0);
			S1, S2: OUT std_logic_vector(1 DOWNTO 0));
END COMPONENT;

-- Selector Component
COMPONENT Selector IS
GENERIC ( n: Integer:= 16);
PORT ( Reg, Memory, WriteBack: IN std_logic_vector(n-1 downto 0);
			operation: IN std_logic_vector( 1 downto 0 );
			output: OUT std_logic_vector(n-1 downto 0));
END COMPONENT;

-- sign_extender Component
COMPONENT sign_extender IS
GENERIC(
   n : INTEGER := 16;
	k : INTEGER := 6
  );
  
PORT(
	immediate : IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
	extended : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
  );
END COMPONENT;

-- HazardUnit Component
COMPONENT HazardUnit IS
PORT (isJR, isJump, wasJump, mustBranch: IN std_logic;
		flush, wasJumpOut: OUT std_logic;
		JRopcode: OUT std_logic_vector(1 downto 0));
END COMPONENT;

-- Controller Component
COMPONENT Controller IS
PORT(opCode: IN std_logic_vector(3 downto 0);
		func: IN std_logic_vector(2 downto 0);
		flush: IN std_logic;
		isMFPC, isJumpD, isReadDigit, isPrintDigit: OUT std_logic;
		isR, isLW, isSW, isBranch, isJR: OUT std_logic);
END COMPONENT;

-- register_ID_EX Component
COMPONENT register_ID_EX IS
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
END COMPONENT;

-- register_EX_MEM Component
COMPONENT register_EX_MEM IS
GENERIC (n: integer:= 16;
			addressSize: integer := 3 );
PORT (clock, isLW, WriteEnable, ReadDigit, PrintDigit: IN std_logic;
		R2Reg, Result: IN std_logic_vector(n-1 downto 0);
		RegAD: IN std_logic_vector(addressSize-1 downto 0);
		---------------------------------------------------------
		isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM: OUT std_logic;
		R2Reg_EXMEM, Result_EXMEM: OUT std_logic_vector(n-1 downto 0);
		RegAD_EXMEM: OUT std_logic_vector(addressSize-1 downto 0));
END COMPONENT;

--------------------------------- SIGNALS ----------------------------------------------
-- MUX 1
SIGNAL  mux1_out0: std_logic_vector(15 DOWNTO 0):= "0000000000000000";

-- MUX 2
SIGNAL  mux2_out0: std_logic_vector(15 DOWNTO 0):= "0000000000000000";

-- JRSelector
SIGNAL jrSelector_result: std_logic_vector(15 DOWNTO 0);

-- TrapUnit
SIGNAL EOR: std_logic:='0';

-- Comb1
SIGNAL comb1: std_logic;

-- PC 
SIGNAL PC_output: std_logic_vector(15 DOWNTO 0):=x"0000";

-- Register_MEM_WB
SIGNAL writeData: std_logic_vector(15 DOWNTO 0);
SIGNAL writeAD: std_logic_vector(2 DOWNTO 0); 

-- Register_IF_ID
SIGNAL outPC, outInstruction: std_logic_vector(15 DOWNTO 0);

-- Forwarder
SIGNAL s1, s2 : std_logic_vector(1 DOWNTO 0);

-- Selector 1
SIGNAL selector1_output:  std_logic_vector(15 DOWNTO 0);

-- Selector 2
SIGNAL selector2_output:  std_logic_vector(15 DOWNTO 0);

-- ALUControl
SIGNAL aluControl_output: std_logic_vector(3 DOWNTO 0);

-- Sign_extender
SIGNAL extended: std_logic_vector(15 DOWNTO 0);

-- MUX 3
SIGNAL  mux3_out0: std_logic_vector(15 DOWNTO 0);

-- MUX 4
SIGNAL  mux4_out0: std_logic_vector(15 DOWNTO 0);

-- ALU
SIGNAL carryOut: std_logic;
SIGNAL ALU_output: std_logic_vector(15 DOWNTO 0);

-- Comb2
SIGNAL comb2: std_logic;

-- HazardUnit
SIGNAL flush: std_logic:='0';
SIGNAL wasJumpOut: std_logic:='0';
SIGNAL JRopcode: std_logic_vector(1 DOWNTO 0);

-- Comb3
SIGNAL comb3: std_logic;

-- Controller 
SIGNAL isBranch, isJR, isJumpD, isLW, isMPFC, isPrintDigit, isR, isReadDigit, isSW: std_logic;
SIGNAL flushController: std_logic:='0';

-- MUX 5
SIGNAL  mux5_out0: std_logic_vector(2 DOWNTO 0);

-- RegFile
SIGNAL read1, read2: std_logic_vector(15 DOWNTO 0);
SIGNAL OUTall: std_logic_vector(127 DOWNTO 0);

-- Reg_ID_EX
SIGNAL isEOR_IDEX: std_logic:= '0';
SIGNAL isBranch_IDEX, isLW_IDEX, isMFPC_IDEX, isPrintDigit_IDEX, isR_IDEX, isReadDigit_IDEX,
		 isSW_IDEX, wasJumpout_IDEX, isJump_IDEX, isJR_IDEX: std_LOGIC;
SIGNAL  ALUFunc_IDEX: std_logic_vector(3 DOWNTO 0);
SIGNAL R1Reg_IDEX, R2Reg_IDEX, Immediate16_IDEX: std_logic_vector(15 DOWNTO 0);
SIGNAL R2AD_IDEX, R1AD_IDEX: std_logic_vector(2 DOWNTO 0);
SIGNAL jumpShortAddr_IDEX: std_logic_vector(11 DOWNTO 0);

-- Reg_EX_MEM
SIGNAL PrintDigit_EXMEM, ReadDigit_EXMEM, WriteEnable_EXMEM, isLW_EXMEM: std_logic;
SIGNAL R2Reg_EXMEM, Result_EXMEM: std_logic_vector(15 DOWNTO 0);
SIGNAL RegAD_EXMEM: std_logic_vector(2 DOWNTO 0);

BEGIN
-- Instruction Fetch (IF) --
comb1 <= EOR NOR isEOR_IDEX;

PC: reg16b PORT MAP(jrSelector_result, comb1, clock, PC_output);

IFIDREG: register_IF_ID PORT MAP(PC_output, instr, clock, '0', '1', outPC,
                                  outInstruction);

-- Instruction Decode (ID) -- 
SignExtend: sign_extender PORT MAP(outInstruction(5 DOWNTO 0), extended);

flushController <= flush OR isEOR_IDEX;
control: Controller PORT MAP(outInstruction(15 DOWNTO 12), outInstruction(2 DOWNTO 0), flushController, isBranch, isJR, isJumpD, isLW, isMPFC, isPrintDigit, isR, isReadDigit, isSW);

mux5 : PROCESS(isR) BEGIN
	CASE isR is
		WHEN '1' => 
			mux5_out0 <= outInstruction(5 DOWNTO 3);
		WHEN OTHERS =>
			mux5_out0 <= outInstruction(11 DOWNTO 9);
	END CASE;
END PROCESS;

RegisterFile: RegFile PORT MAP(clock2, writeData, writeAD, outInstruction(8 DOWNTO 6), mux5_out0, read1, read2, OUTall);

ALUController: AluControl PORT MAP(outInstruction(15 DOWNTO 12), outInstruction(2 DOWNTO 0), aluControl_output);

Trap: TrapUnit PORT MAP(outInstruction(15 DOWNTO 12), EOR);
													 
IDEXReg: Register_ID_EX PORT MAP(clock, EOR, wasJumpOut, isJumpD, isJR, isBranch, isR, isMPFC, isLW, isSW, isReadDigit, isPrintDigit,
														  aluControl_output, read1, read2, extended, mux5_out0, outInstruction(8 DOWNTO 6), outInstruction(11 DOWNTO 0),
														  isEOR_IDEX, wasJumpout_IDEX, isJump_IDEX, isJR_IDEX, isBranch_IDEX, isR_IDEX, isMFPC_IDEX, isLW_IDEX, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX,
														  ALUFunc_IDEX, R1Reg_IDEX, R2Reg_IDEX, immediate16_IDEX, R2AD_IDEX, R1AD_IDEX, jumpShortAddr_IDEX);
														  
														  
-- Execute(EX) -- 																					 
ForwardUnit: Forwarder PORT  MAP(R1AD_IDEX, R2AD_IDEX, RegAD_EXMEM, writeAD, s1, s2);

selector1: Selector PORT MAP (R1Reg_IDEX, mux2_out0, writeData, s1, selector1_output);

selector2: Selector PORT MAP (R2Reg_IDEX, mux2_out0, writeData, s2, selector2_output);

mux3 : PROCESS(isMFPC_IDEX) BEGIN
	CASE isMFPC_IDEX is
		WHEN '1' => 
			mux3_out0 <= selector1_output;
		WHEN OTHERS =>
			mux3_out0 <= outPC;
	END CASE;
END PROCESS;

mux4 : PROCESS(isR_IDEX) BEGIN
	CASE isR_IDEX is
		WHEN '1' => 
			mux4_out0 <= instr;
		WHEN OTHERS =>
			mux4_out0 <= selector2_output;
	END CASE;
END PROCESS;

ALU16 : ALU PORT MAP(mux3_out0, mux4_out0, '0',  carryOut, aluFunc_IDEX, ALU_output);

comb2 <= carryOut AND isBranch_IDEX;

Hazard : HazardUnit PORT MAP(isJR, isJumpD, comb2, '0', flush, wasJumpOut, JRopcode);

JR : JRSelector  PORT MAP("0000" & jumpShortAddr_IDEX(9 DOWNTO 0) & "00" , immediate16_IDEX, outPC, JRopcode, jrSelector_result);

EXMEMREG : register_EX_MEM PORT MAP(clock, isLW, isSW_IDEX, isReadDigit_IDEX, isPrintDigit_IDEX, R2Reg_IDEX, ALU_output, R2AD_IDEX, 
									isLW_EXMEM, WriteEnable_EXMEM, ReadDigit_EXMEM, PrintDigit_EXMEM, R2Reg_EXMEM, Result_EXMEM, RegAD_EXMEM);

-- Memory (MEM) --
mux1 : PROCESS(readDigit_EXMEM) BEGIN
	CASE readDigit_EXMEM is
		WHEN '0' => 
			mux1_out0 <= result_EXMEM;
		WHEN OTHERS =>
			mux1_out0 <= keyData;
	END CASE;
END PROCESS;

mux2 : PROCESS(isLW_EXMEM) BEGIN
	CASE isLW_EXMEM is
		WHEN '0' => 
			mux2_out0 <= mux1_out0;
		WHEN OTHERS =>
			mux2_out0 <= fromData;
	END CASE;
END PROCESS;

-- Write Back (WB) --
MEMWBREG : register_MEM_WB PORT MAP(mux2_out0, RegAD_EXMEM, clock, writeData, writeAD);

------ outputs -------
printEnable <= printDigit_EXMEM;
keyEnable <= readDigit_EXMEM;
dataWriteFlag <= writeEnable_EXMEM;
dataAD <= R2Reg_EXMEM;
printCode <= R2Reg_EXMEM;
toData <= result_EXMEM;
printData <= result_EXMEM;
regOUT <= PC_output & OUTall;
instructionAD <= PC_output;

END LogicFunc;
