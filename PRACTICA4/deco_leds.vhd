-- ============================================
-- Equipo: Brayan, Cristian y Emilio
-- Materia: VLSI
-- Archivo: deco_leds.vhd
-- ============================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY deco_leds IS
    PORT(
        cuenta : IN  INTEGER RANGE 0 TO 10;
        leds   : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE rtl OF deco_leds IS
BEGIN
    WITH cuenta SELECT
        leds <= "0000000000" WHEN 0,
                "0000000001" WHEN 1,
                "0000000011" WHEN 2,
                "0000000111" WHEN 3,
                "0000001111" WHEN 4,
                "0000011111" WHEN 5,
                "0000111111" WHEN 6,
                "0001111111" WHEN 7,
                "0011111111" WHEN 8,
                "0111111111" WHEN 9,
                "1111111111" WHEN 10,
                "0000000000" WHEN OTHERS;
END rtl;
