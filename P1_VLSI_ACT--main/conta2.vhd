LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY conta2 IS
    PORT(CLK, RST, HAB : IN     STD_LOGIC;
         SEL           : BUFFER INTEGER RANGE 0 TO 2);
END ENTITY;

ARCHITECTURE BEAS OF conta2 IS
BEGIN
    PROCESS(CLK)
    BEGIN
        IF FALLING_EDGE(CLK) THEN
            IF RST = '1' THEN
                SEL <= 0;
            ELSIF HAB = '1' THEN
                IF SEL = 2 THEN
                    SEL <= 0;
                ELSE
                    SEL <= SEL + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
END BEAS;
