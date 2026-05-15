-- ============================================
-- Equipo: Brayan, Cristian y Emilio
-- Materia: VLSI
-- Archivo: fsm_dir.vhd
-- ============================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fsm_dir IS
    PORT(
        clk   : IN  STD_LOGIC;
        dir   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
        rst_c : OUT STD_LOGIC;
        ad    : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE rtl OF fsm_dir IS
    TYPE estado IS (INI, DER, IZQ);
    SIGNAL presente, siguiente : estado := INI;
BEGIN
    -- Registro de estado
    PROCESS(clk)
    BEGIN
        IF RISING_EDGE(clk) THEN
            presente <= siguiente;
        END IF;
    END PROCESS;

    -- Logica de siguiente estado + salidas
    PROCESS(presente, dir)
    BEGIN
        CASE presente IS

            WHEN INI =>
                rst_c <= '1';
                ad    <= '1';  -- FIX: AD='1' en INI para que XOR no encienda LEDs
                IF dir = "01" THEN
                    siguiente <= DER;
                ELSIF dir = "10" THEN
                    siguiente <= IZQ;
                ELSE
                    siguiente <= INI;
                END IF;

            WHEN DER =>
                rst_c <= '0';
                ad    <= '1';
                IF dir = "00" OR dir = "11" THEN
                    siguiente <= INI;
                ELSIF dir = "10" THEN
                    siguiente <= IZQ;
                ELSE
                    siguiente <= DER;
                END IF;

            WHEN IZQ =>
                rst_c <= '0';
                ad    <= '0';
                IF dir = "00" OR dir = "11" THEN
                    siguiente <= INI;
                ELSIF dir = "01" THEN
                    siguiente <= DER;
                ELSE
                    siguiente <= IZQ;
                END IF;

        END CASE;
    END PROCESS;
END rtl;
