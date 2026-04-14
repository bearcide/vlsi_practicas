-- ============================================
-- Equipo: Brayan, Cristian y Emilio
-- Materia: VLSI
-- Archivo: conta_rst.vhd
-- ============================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY conta_rst IS
    PORT(
        clk    : IN  STD_LOGIC;
        rst    : IN  STD_LOGIC;
        ad     : IN  STD_LOGIC;
        cuenta : OUT INTEGER RANGE 0 TO 10
    );
END ENTITY;

ARCHITECTURE rtl OF conta_rst IS
    SIGNAL cnt : INTEGER RANGE 0 TO 10 := 0;
BEGIN
    PROCESS(clk)
    BEGIN
        IF FALLING_EDGE(clk) THEN
            IF rst = '1' THEN
                cnt <= 0;
            ELSIF ad = '1' THEN
                -- Cuenta hacia arriba (DER)
                IF cnt = 10 THEN
                    cnt <= 0;
                ELSE
                    cnt <= cnt + 1;
                END IF;
            ELSE
                -- Cuenta hacia abajo (IZQ)
                IF cnt = 0 THEN
                    cnt <= 10;
                ELSE
                    cnt <= cnt - 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    cuenta <= cnt;
END rtl;
