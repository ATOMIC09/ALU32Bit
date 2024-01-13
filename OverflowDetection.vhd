library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity OverflowDetection is
    port (
        in_sum, in_carry , in_a, in_b : in std_logic;
        out_overflow : out std_logic
    );
end entity OverflowDetection;

architecture Behavioral of OverflowDetection is
    begin
        process(in_sum, in_carry, in_a, in_b)
        begin
            out_overflow <= ((in_a XOR in_b) AND NOT in_sum) OR (in_a AND in_b);
        end process;
end architecture Behavioral;