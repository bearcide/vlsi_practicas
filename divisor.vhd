LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY divisor IS
    GENERIC(FREC: INTEGER := 25000000); -- Para 1Hz aprox con 50MHz
    PORT(CLK_MST: IN STD_LOGIC;
         CLK: BUFFER STD_LOGIC := '0'); -- Inicializado en 0
END ENTITY;

ARCHITECTURE BEAS OF divisor IS
    SIGNAL AUX: INTEGER RANGE 0 TO FREC-1 := 0; -- Rango corregido
BEGIN
    PROCESS(CLK_MST)
    BEGIN
        IF RISING_EDGE(CLK_MST) THEN
            IF AUX = FREC-1 THEN -- Comparación corregida
                CLK <= NOT CLK;
                AUX <= 0;
            ELSE
                AUX <= AUX + 1;
            END IF;
        END IF;
    END PROCESS;
END BEAS;