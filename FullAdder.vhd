LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FullAdder IS
	PORT (
		x, y, z : IN STD_LOGIC;
		s, c : OUT STD_LOGIC);
END FullAdder;

ARCHITECTURE Behavioral OF FullAdder IS
BEGIN
	PROCESS (x,y,z) IS
	BEGIN
		s <= (x XOR y) XOR z;
		c <= ((x XOR y) AND z) OR (x AND y);
	END PROCESS;
END Behavioral;