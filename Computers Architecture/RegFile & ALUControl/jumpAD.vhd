-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;
USE ieee.numeric_std.all;

ENTITY jumpAD IS
GENERIC(
  n : INTEGER := 16;
  k : INTEGER := 12
);

PORT(
	jumpADR: IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
	instrP2AD: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	EjumpAD: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
  );
END jumpAD;

ARCHITECTURE LogicFunc OF jumpAD IS
  SIGNAL extended, multed: STD_LOGIC_VECTOR(n-1 DOWNTO 0);
BEGIN
  extended <= (n-1 DOWNTO k => jumpADR(k-1)) & (jumpADR);
  
  PROCESS(instrP2AD)
  BEGIN
	--left shift (multiplication)
    multed <= extended(n-2 DOWNTO 0) & '0';
    EjumpAD <= STD_LOGIC_VECTOR( UNSIGNED(multed) + UNSIGNED(instrP2AD));
  END PROCESS;
END LogicFunc;