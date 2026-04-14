-- ============================================
-- Equipo: Brayan, Cristian y Emilio
-- Materia: VLSI
-- Archivo: divf.vhd
-- ============================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY divf IS
    GENERIC(N : INTEGER := 4999999);
    PORT(
        clk_in  : IN  STD_LOGIC;
        clk_out : BUFFER STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF divf IS
    SIGNAL cnt : INTEGER := 0;
BEGIN
    PROCESS(clk_in)
    BEGIN
        IF RISING_EDGE(clk_in) THEN
            IF cnt >= N THEN
                clk_out <= NOT clk_out;
                cnt     <= 0;
            ELSE
                cnt <= cnt + 1;
            END IF;
        END IF;
    END PROCESS;
END rtl;
