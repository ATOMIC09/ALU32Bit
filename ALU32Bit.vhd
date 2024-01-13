library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_misc.nor_reduce;

entity ALU32Bit is
    port (
        A, B : in std_logic_vector(31 downto 0);
        ALUControlLine : in std_logic_vector(3 downto 0);
        ZERO, OVERFLOW, CARRYOUT : out std_logic;
        RESULT_OUT : out std_logic_vector(31 downto 0)
    );
end entity ALU32Bit;

architecture Structural of ALU32Bit is
    component OneBitALU is
        port (
            a_in, b_in, less, invert_a, invert_b, c_in : in std_logic;
            operation : in std_logic_vector(1 downto 0);
            result, set, overflow, c_out : out std_logic
        );
    end component;
    signal carryout_inside : std_logic_vector(30 downto 0);
    signal LESS : std_logic;
    signal RESULT_TO_NOR : std_logic_vector(31 downto 0);
begin
    ALU0 : OneBitALU
    port map(
        a_in => A(0),
        b_in => B(0),
        less => LESS,
        invert_a => ALUControlLine(3),
        invert_b => ALUControlLine(2),
        c_in => ALUControlLine(2),
        operation => ALUControlLine(1 DOWNTO 0),
        result => RESULT_TO_NOR(0),
        set => open,
        overflow => open,
        c_out => carryout_inside(0)
    );
    
    ALU_gen : for i in 1 to 30 generate
        ALU_i : OneBitALU
        port map(
            a_in => A(i),
            b_in => B(i),
            less => '0',
            invert_a => ALUControlLine(3),
            invert_b => ALUControlLine(2),
            c_in => carryout_inside(i-1),
            operation => ALUControlLine(1 DOWNTO 0),
            result => RESULT_TO_NOR(i),
            set => open,
            overflow => open,
            c_out => carryout_inside(i)
        );
    end generate;

    ALU31 : OneBitALU
    port map(
        a_in => A(31),
        b_in => B(31),
        less => '0',
        invert_a => ALUControlLine(3),
        invert_b => ALUControlLine(2),
        c_in => carryout_inside(30),
        operation => ALUControlLine(1 DOWNTO 0),
        result => RESULT_TO_NOR(31),
        set => LESS,
        overflow => OVERFLOW,
        c_out => CARRYOUT
    );

    -- NOR all bit in RESULT_TO_NOR
    ZERO <= nor_reduce(RESULT_TO_NOR);
    RESULT_OUT <= RESULT_TO_NOR;
end architecture Structural;