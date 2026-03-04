LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY divf IS
    GENERIC(FREC: INTEGER := 24999999); -- 1 Hz para prueba final
    -- 24999    >> 1 kHz  (prueba rapida)
    -- 4999999  >> 5 Hz
    -- 24999999 >> 1 Hz   (velocidad final)
    PORT(CLK_MST : IN     STD_LOGIC;
         CLK     : BUFFER STD_LOGIC);
END ENTITY;

ARCHITECTURE BEAS OF divf IS
    SIGNAL AUX: INTEGER RANGE 0 TO FREC;
BEGIN
    PROCESS(CLK_MST)
    BEGIN
        IF RISING_EDGE(CLK_MST) THEN
            IF AUX = 0 THEN
                CLK <= NOT CLK;
                AUX <= FREC;
            ELSE
                AUX <= AUX - 1;
            END IF;
        END IF;
    END PROCESS;
END BEAS;
