-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

LIBRARY ieee;
USE ieee.STD_Logic_1164.all;

ENTITY sign_extender IS
GENERIC(
   n : INTEGER := 16;
	k : INTEGER := 6
  );
  
PORT(
	immediate : IN STD_LOGIC_VECTOR (k-1 DOWNTO 0);
	extended : OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
  );
END sign_extender;

ARCHITECTURE LogicFunc OF sign_extender IS
BEGIN
  extended <= (n-1 DOWNTO k => immediate(k-1)) & (immediate);
END LogicFunc;