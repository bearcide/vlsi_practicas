-- ============================================
-- Equipo: Brayan, Cristian y Emilio
-- Materia: VLSI
-- Archivo: practicaa.vhd
-- ============================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY practicaa IS
    PORT(
        clk  : IN  STD_LOGIC;
        dir  : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        led  : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF practicaa IS

    SIGNAL clk_div : STD_LOGIC;
    SIGNAL rst     : STD_LOGIC;
    SIGNAL ad      : STD_LOGIC;
    SIGNAL cuenta  : INTEGER RANGE 0 TO 10;
    SIGNAL deco    : STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN

    u_div : ENTITY work.divf
        PORT MAP(clk_in => clk, clk_out => clk_div);

    u_fsm : ENTITY work.fsm_dir
        PORT MAP(clk => clk, dir => dir, rst_c => rst, ad => ad);

    u_conta : ENTITY work.conta_rst
        PORT MAP(clk => clk_div, rst => rst, ad => ad, cuenta => cuenta);

    u_deco : ENTITY work.deco_leds
        PORT MAP(cuenta => cuenta, leds => deco);

    -- Logica final: DER=sin cambio, IZQ=invertir patron
    PROCESS(deco, ad)
    BEGIN
        IF ad = '1' THEN
            led <= deco;
        ELSE
            led <= deco XOR "1111111111";
        END IF;
    END PROCESS;

END ARCHITECTURE;
