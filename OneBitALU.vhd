library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity OneBitALU is
    port( a_in,b_in,less : in std_logic;
          invert_a : in std_logic;
          invert_b : in std_logic;
          c_in : in std_logic;
          operation : in std_logic_vector(1 downto 0);
          result : out std_logic;
          set : out std_logic;
          overflow : out std_logic;
          c_out : out std_logic
        );
end OneBitALU;

architecture Behavioral of OneBitALU is
    component OverflowDetection is
        port(
            in_sum, in_carry , in_a, in_b : in std_logic;
            out_overflow : out std_logic
            );
    end component;

    component FullAdder is
        port(
            x,y,z : in std_logic;
            s,c : out std_logic
            );
    end component;
    signal a, b, carry_out, sum : std_logic;
begin
    OverFlow0 : OverflowDetection
    PORT MAP(
            in_a => a,
            in_b => b,
            in_carry => carry_out,
            in_sum => sum,
            out_overflow => overflow
        );
    FullAdder0 : FullAdder
        PORT MAP(
            x => a_in,
            y => b_in,
            z => c_in,
            s => sum,
            c => carry_out
        );
    process(a,b) is
    begin
        set <= sum;
        c_out <= carry_out;
        if (invert_a = '1') then
            a <= not a_in;
        else
            a <= a_in;
        end if;
        if (invert_b = '1') then
            b <= not b_in;
        else
            b <= b_in;
        end if;
        case operation is
            when "00" => result <= a and b;
            when "01" => result <= a or b;
            when "10" => result <= sum;
            when "11" => result <= less;
            -- when others => result <= '0';
        end case;
    end process;
end Behavioral;