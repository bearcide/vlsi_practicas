LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY conta_rst IS
    PORT(CLK, RST, ENB : IN     STD_LOGIC;
         CARRY         : OUT    STD_LOGIC;
         COUNT         : BUFFER INTEGER RANGE 0 TO 15);
END ENTITY;

ARCHITECTURE BEAS OF conta_rst IS
BEGIN
    PROCESS(CLK)
    BEGIN
        IF RISING_EDGE(CLK) THEN
            IF RST = '1' THEN
                COUNT <= 0;
            ELSIF ENB = '1' THEN
                IF COUNT = 9 THEN
                    COUNT <= 0;
                ELSE
                    COUNT <= COUNT + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    CARRY <= '1' WHEN COUNT = 9 ELSE '0';
END BEAS;
