LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY conta IS
    PORT(
        CLK   : IN  STD_LOGIC;
        HAB   : IN  STD_LOGIC;
        CUENTA: OUT STD_LOGIC_VECTOR(0 TO 3)
    );
END conta;

ARCHITECTURE BEAS OF conta IS
    SIGNAL cnt : STD_LOGIC_VECTOR(0 TO 3) := "0000";
BEGIN
    PROCESS(CLK)
    BEGIN
        IF FALLING_EDGE(CLK) THEN
            IF cnt = "1111" THEN
                cnt <= "0000";
            ELSE
                cnt <= cnt + "0001";
            END IF;
        END IF;
    END PROCESS;

    CUENTA <= cnt;
END BEAS;
