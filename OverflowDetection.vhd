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
            if (in_a = '0' and in_b = '1' and in_carry = '1' and in_sum = '0' ) then
                out_overflow <= '1';
            elsif (in_a = '1' and in_b = '0' and in_carry = '1' and in_sum = '0' ) then
                out_overflow <= '1';
            elsif (in_a = '1' and in_b = '1' and in_carry = '0' and in_sum = '0' ) then
                out_overflow <= '1';
            elsif (in_a = '1' and in_b = '1' and in_carry = '1' and in_sum = '1' ) then
                out_overflow <= '1';
            else
                out_overflow <= '0';
            end if;
        end process;
end architecture Behavioral;