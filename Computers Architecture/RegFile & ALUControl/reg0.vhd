-- Konstantina Souvatzidaki, 3170149
-- Chara Gergi, 3170029

library ieee;
  USE ieee.STD_Logic_1164.all;

ENTITY reg0 IS
GENERIC (
          n : integer := 16
);
  PORT(
    input: IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    enable, clock : IN STD_LOGIC;
    output: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
  );
END reg0;

ARCHITECTURE LogicFunc OF reg0 IS
BEGIN
	--output is always zero
  output <= (OTHERS => '0');
END LogicFunc;