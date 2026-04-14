-- ============================================================
-- colraw.vhd
-- Decodificador 2 a 4 (genera columnas activas en bajo)  +
-- Multiplexor   4 a 1 (lee la fila activa)
--
-- CUENTA[0..1] => MSB => DECO 2a4  => COL[0..3]
-- CUENTA[2..3] => LSB => MUX 4a1  => HAB
--
-- COL activo en BAJO (0 = columna seleccionada)
-- FIL activo en BAJO (teclado conecta a GND al presionar)
-- HAB = 1 cuando se detecta tecla presionada en la fila activa
-- ============================================================
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY colraw IS
    PORT(
        CUENTA : IN  STD_LOGIC_VECTOR(0 TO 3);
        FIL    : IN  STD_LOGIC_VECTOR(0 TO 3);
        COL    : OUT STD_LOGIC_VECTOR(0 TO 3);
        HAB    : OUT STD_LOGIC
    );
END colraw;

ARCHITECTURE BEAS OF colraw IS
BEGIN
    -- DECO 2 a 4: bits MSB [0..1] seleccionan columna activa (bajo)
    WITH CUENTA(0 TO 1) SELECT
        COL <= "1110" WHEN "00",   -- COL0 activa
               "1101" WHEN "01",   -- COL1 activa
               "1011" WHEN "10",   -- COL2 activa
               "0111" WHEN OTHERS; -- COL3 activa

    -- MUX 4 a 1: bits LSB [2..3] seleccionan fila a leer
    -- HAB = 1 si la fila seleccionada tiene un '0' (tecla presionada)
    WITH CUENTA(2 TO 3) SELECT
        HAB <= NOT FIL(0) WHEN "00",
               NOT FIL(1) WHEN "01",
               NOT FIL(2) WHEN "10",
               NOT FIL(3) WHEN OTHERS;
END BEAS;
