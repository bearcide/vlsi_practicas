LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY contador IS
    PORT(CLK, RST: IN STD_LOGIC;
         CUENTA: BUFFER INTEGER RANGE 0 TO 15;
         DEPURACION: OUT STD_LOGIC); -- NUEVA SEÑAL
END ENTITY;

ARCHITECTURE BEAS OF contador IS
BEGIN
    PROCESS(CLK)
    BEGIN
        IF RISING_EDGE(CLK) THEN 
            IF RST = '0' THEN 
                CUENTA <= 0;
            ELSIF CUENTA = 15 THEN 
                CUENTA <= 0;
            ELSE
                CUENTA <= CUENTA + 1;
            END IF;
        END IF;
    END PROCESS;
    
    -- Parpadea cada vez que cambia la cuenta
    DEPURACION <= '1' WHEN CUENTA /= 0 ELSE '0';
END BEAS;