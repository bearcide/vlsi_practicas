LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decotecla IS
    PORT(
        CUENTA : IN  STD_LOGIC_VECTOR(0 TO 3);
        TECLA  : OUT INTEGER RANGE 0 TO 15
    );
END decotecla;

ARCHITECTURE BEAS OF decotecla IS
BEGIN
    -- CUENTA(0 TO 1) activa la FILA fisica (via COL del DECO)
    -- CUENTA(2 TO 3) lee la COLUMNA fisica (via FIL del MUX)
    -- Corregido para teclado con conector C1C2C3C4-F1F2F3F4
    WITH CUENTA SELECT
        TECLA <=  1 WHEN "0011",   -- tecla 1  (C1,F1)
                  2 WHEN "0010",   -- tecla 2  (C2,F1)
                  3 WHEN "0001",   -- tecla 3  (C3,F1)
                 10 WHEN "0000",   -- tecla A  (C4,F1)
                  4 WHEN "0111",   -- tecla 4  (C1,F2)
                  5 WHEN "0110",   -- tecla 5  (C2,F2)
                  6 WHEN "0101",   -- tecla 6  (C3,F2)
                 11 WHEN "0100",   -- tecla b  (C4,F2)
                  7 WHEN "1011",   -- tecla 7  (C1,F3)
                  8 WHEN "1010",   -- tecla 8  (C2,F3)
                  9 WHEN "1001",   -- tecla 9  (C3,F3)
                 12 WHEN "1000",   -- tecla C  (C4,F3)
                 15 WHEN "1111",   -- tecla *  (C1,F4)
                  0 WHEN "1110",   -- tecla 0  (C2,F4)
                 14 WHEN "1101",   -- tecla #  (C3,F4)
                 13 WHEN OTHERS;   -- tecla d  (C4,F4)
END BEAS;
